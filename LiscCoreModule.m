
#import "LiscCoreModule.h"
#import "LiscCallBlock.h"
#import "LiscBoolean.h"
#import "LiscList.h"
#import "LiscNil.h"
#import "LiscString.h"
#import "LiscError.h"
#import "LiscArgs.h"

@implementation LiscCoreModule

- (void)setupBindings {
    
    LiscCallBlock is = ^(NSArray *args) {
        [LiscArgs checkArgs:args 
                  expecting:@[[LiscExpression class], [LiscExpression class]]];
        
        LiscExpression *a = args[0];
        LiscExpression *b = args[1];
        
        if ([a isEqualToExpression:b]) {
            return [LiscBoolean t];
        } else {
            return [LiscBoolean f];
        }
    };
    
    LiscCallBlock print = ^(NSArray *args) {
        NSString *output = [NSString string];
        for (int i=0; i<args.count; i++) {
            
            if (i > 0 && i <args.count) {
                output = [output stringByAppendingString:@" "];
            }
            
            LiscExpression *exp = args[i];
            
            if ([exp isKindOfClass:[LiscString class]]) {
                output = [output stringByAppendingString:((LiscString *)exp).string];
            } else {
                output = [output stringByAppendingString:[args[i] print]];
            }
        }
        
        NSFileHandle *outhandle = [NSFileHandle fileHandleWithStandardOutput];
        [outhandle writeData:[output dataUsingEncoding:NSUTF8StringEncoding]];
        [outhandle writeData:[@"\n"  dataUsingEncoding:NSUTF8StringEncoding]];
        
        return (id)[LiscNil _nil];      
    };
    
    LiscCallBlock first = ^(NSArray *args) {
        [LiscArgs checkArgs:args expecting:@[[LiscList class]]];
        LiscList *list = args[0];
        if (list.array.count > 0) {
            return (list.array)[0];
        } else {
            [LiscError raiseIndexError:@"Index Error: list index is out of bounds"];
        }
        
        return (id)[LiscNil _nil];  
    };
    
    LiscCallBlock last = ^(NSArray *args) {
        [LiscArgs checkArgs:args expecting:@[[LiscList class]]];
        LiscList *list = args[0];
        if (list.array.count > 0) {
            return (list.array)[list.array.count-1];
        } else {
            [LiscError raiseIndexError:@"Index Error: list index is out of bounds"];
        }
        
        return (id)[LiscNil _nil];          
    };
    
    LiscCallBlock rest = ^(NSArray *args) {
        [LiscArgs checkArgs:args expecting:@[[LiscList class]]];
        LiscList *list = args[0];
        if (list.array.count > 1) {
            return [LiscList listWithArray:[list.array subarrayWithRange:NSMakeRange(1, list.array.count-1)]];
        } else {
            //return the empty list instead of raising an error
            return [LiscList listWithArray:@[]];
        }
        
        return (id)[LiscNil _nil];
    };
    
    LiscCallBlock cons = ^(NSArray *args) {
        [LiscArgs checkArgs:args expecting:@[[LiscList class],[NSObject class]]];
        LiscList *list = args[0];
        id exp = args[1];
        return [LiscList listWithArray:[list.array arrayByAddingObject:exp]];
        
        return (id)[LiscNil _nil];      
    };
    
    self.self.bindings[@"is"] = [LiscFunction functionWithBlock:is];
    self.self.bindings[@"print"] = [LiscFunction functionWithBlock:print];
    self.bindings[@"first"] = [LiscFunction functionWithBlock:first];
    self.bindings[@"last"] = [LiscFunction functionWithBlock:last];
    self.bindings[@"rest"] = [LiscFunction functionWithBlock:rest];
    self.bindings[@"cons"] = [LiscFunction functionWithBlock:cons];
}

@end
