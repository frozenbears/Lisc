
#import "LiscEnvironment.h"
#import "LiscSymbol.h"
#import "LiscFunction.h"
#import "LiscMathModule.h"
#import "LiscCoreModule.h"
#import "LiscError.h"

@implementation LiscEnvironment

+ (LiscEnvironment *)globalEnvironment {
    
    NSArray *keys = @[];
    NSArray *values = @[];
    
    LiscEnvironment *e = [[LiscEnvironment alloc] initWithParams:keys args:values outer:nil];
    
    //a global environment should at least have a basic set of function bindings
    [e addModule:[LiscMathModule new]];
    [e addModule:[LiscCoreModule new]];
    
    return e;
}

- (id)initWithParams:(NSArray *)params args:(NSArray *)args outer:(LiscEnvironment *)env {
    
    if (self = [super init]) {
        //this will happen if you try to call a lambda with the wrong number of arguments
        if(args.count != params.count) {
            NSString *errorString = [NSString stringWithFormat:@"Type Error: expected %lu arguments and received %lu", (unsigned long)params.count, (unsigned long)args.count];
            [LiscError raiseTypeError:errorString];
        } else {
            self.dict = [[NSMutableDictionary alloc] 
                      initWithObjects:args forKeys:params];
            self.outer = env;
        }
    }
    
    return self;
}

- (void)addModule:(LiscModule *)module {
    for (NSString *name in [module.bindings allKeys]) {
        (self.dict)[name] = (module.bindings)[name];
    }
}

- (LiscEnvironment *)environmentForVar:(NSString *)var {
    if (self.dict[var]) {
        return self;
    } else {
        return [self.outer environmentForVar:var];
    }
}

- (LiscExpression *)find:(NSString *)var {
    return [[self environmentForVar:var] dict][var];
}

- (void)setWithVar:(NSString *)var expression:(LiscExpression *)exp {
    [[[self environmentForVar:var] dict] setValue:exp forKey:var];
}

- (void)defineWithVar:(NSString *)var expression:(LiscExpression *)exp {
    [self.dict setValue:exp forKey:var];
}


@end
