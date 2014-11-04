
#import "LiscList.h"
#import "LiscSymbol.h"
#import "LiscError.h"
#import "LiscBoolean.h"
#import "LiscLambda.h"
#import "LiscNil.h"
#import "LiscNumber.h" 
#import "LiscArgs.h"

@implementation LiscList

- (id)initWithArray:(NSArray *)theArray {
    if (self = [super init]) {
        self.array = theArray;
    }
    
    return self;
}

+ (id)listWithArray:(NSArray *)theArray {
    return [[LiscList alloc] initWithArray:theArray];
}

//list evaluation can mean lots of things depending on context
- (LiscExpression *)eval:(LiscEnvironment *)env {
    
    //an empty list is just an empty list
    if (!self.array.count) return self;
    
    //the head sets the agenda
    LiscExpression *head = self.array[0];
    
    if ([head isKindOfClass:LiscSymbol.class]) {
        NSString *s = ((LiscSymbol *)head).name;
        NSArray *args = @[];
        if (self.array.count > 1) {
            args = [self.array subarrayWithRange:NSMakeRange(1, self.array.count-1)];
        }
        
        //"quote" prevents the subsequent thing from being evaluated
        if ([s isEqualToString:@"quote"]) {
            [LiscArgs checkArgs:args expecting:@[[LiscExpression class]]];
            return args[0];
        } else if ([s isEqualToString:@"if"]) {
            [LiscArgs checkArgs:args expecting:@[[LiscExpression class], [LiscExpression class], [LiscExpression class]]];
            
            //the thing that may or may not be true
            LiscExpression *test = args[0];
            //the thing to be evaluated if so
            LiscExpression *conseq = args[1];
            //the thing to be evaluated if not
            LiscExpression *alt = args[2];
            
            LiscExpression *result = [test eval:env];
            
            BOOL b = NO;
            
            if([result isKindOfClass:[LiscBoolean class]]) {
                b = ((LiscBoolean *)result).value;
            } else if (![result isKindOfClass:[LiscNil class]]) {
                //non-nil, non-boolean, non-empty-list values are as good as true
                if ([result isKindOfClass:[LiscNumber class]]) {
                    b = [((LiscNumber *)result).number doubleValue] != 0;
                } else if ([result isKindOfClass:[LiscList class]]) {
                    b = ((LiscList *)result).array.count > 0;
                } else {
                    b = YES;
                }
            }
            
            if (b) {
                return [conseq eval:env];
            } else {
                return [alt eval:env];
            }
            
        } else if ([s isEqualToString:@"set!"]) {
            [LiscArgs checkArgs:args expecting:@[[LiscSymbol class], [LiscExpression class]]];
            LiscSymbol *var = args[0];
            LiscExpression *exp = args[1];
            [env setWithVar:var.name expression:[exp eval:env]];
        } else if ([s isEqualToString:@"define"]) {
            [LiscArgs checkArgs:args expecting:@[[LiscSymbol class], [LiscExpression class]]];
            LiscSymbol *var = args[0];
            LiscExpression *exp = args[1];
            [env defineWithVar:var.name expression:[exp eval:env]];
        } else if ([s isEqualToString:@"do"]) {
            if (args.count == 0) return [LiscNil _nil];
            LiscExpression *val;
            for(LiscExpression *exp in args) {
                val = [exp eval:env];
            }
            return val;
        } else if([s isEqualToString:@"lambda"]) {
            //lambda!! <3 <3 <3
            [LiscArgs checkArgs:args expecting:@[[LiscList class], [LiscExpression class]]];
            
            LiscList *vars = args[0];
            LiscExpression *exp = args[1];
            LiscLambda *lambda = [[LiscLambda alloc] initWithVars:vars.array 
                                                        expression:exp
                                                       environment:env];
            return lambda;
        } else {
            //procedure call
            NSMutableArray *exps = [NSMutableArray array];
            
            //evaluate all the expressions in the list, including the head
            for (LiscExpression *exp in self.array) {
                [exps addObject:[exp eval:env]];
            }
            
            LiscExpression *proc = exps[0];
            if ([proc conformsToProtocol:@protocol(LiscCallable)]) {
                //pop the head
                [exps removeObjectAtIndex:0];
                //do it
                return [((LiscExpression<LiscCallable> *)proc) callWithArgs:exps];
            } else {
                NSString *errorString = [NSString stringWithFormat:@"Type Error: %@ is not callable", proc];
                [LiscError raiseTypeError:errorString];
            }
        }
        
    } else {
        //just a regular list
        
        NSMutableArray *exps = [NSMutableArray array];
        
        //evaluate all the expressions in the list, incluing the head, and return
        for (LiscExpression *exp in self.array) {
            [exps addObject:[exp eval:env]];
        }
        
        return [LiscList listWithArray:exps];
    }
    
    return [LiscNil _nil];
}

- (NSString *)print {
    
    NSString *listString = @"(";
    
    for (int i=0; i<self.array.count; i++) {
        
        if (i > 0 && i < self.array.count) {
            listString = [listString stringByAppendingString:@" "];
        } 
        
        listString = [listString stringByAppendingString:[self.array[i] print]];
    }
    
    listString = [listString stringByAppendingString:@")"];
    
    return listString;
}

- (BOOL)isEqualToExpression:(LiscExpression *)exp {
    BOOL result = YES;
    if ([self isKindOfClass:[exp class]]) {
        NSUInteger count = ((LiscList *)exp).array.count;
        if (self.array.count == count) {
            for (int i = 0; i<count; i++) {
                LiscExpression *left = self.array[i];
                LiscExpression *right = (((LiscList *)exp).array)[i];
                if (![left isEqualToExpression:right]) {
                    result = NO;
                }
            }
        } else {
            result = NO;
        }
    } else {
        result = NO;
    }
    return result;
}




@end