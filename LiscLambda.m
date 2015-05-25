
#import "LiscLambda.h"
#import "LiscSymbol.h"

@implementation LiscLambda

- (id)initWithVars:(NSArray *)vars expressions:(NSArray *)exps environment:(LiscEnvironment *)env {
    
    if (self = [super init]) {
        self.expressions = exps;
        self.names = [NSMutableArray array];
        for (LiscSymbol *s in vars) {
            //these will be the variable names bound to the arguments 
            //passed when the lambda is actually called
            [self.names addObject:s.name];
        }
        
        self.environment = env;
    }
    
    return self;
}

//calling a lambda then simply means evaluating the expression within the enclosing scope
- (LiscExpression *)callWithArgs:(NSArray *)args {
    LiscExpression *result;
    @autoreleasepool {
        LiscEnvironment *enclosingEnvironment = [[LiscEnvironment alloc] initWithParams:self.names args:args outer:self.environment];
        for (LiscExpression *exp in self.expressions) {
            result = [exp eval:enclosingEnvironment];
        }
    }

    return result;
}

@end
