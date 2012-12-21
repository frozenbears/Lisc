
#import "LiscLambda.h"
#import "LiscSymbol.h"

@implementation LiscLambda

@synthesize environment, names, expression;

- (id)initWithVars:(NSArray *)vars expression:(id)exp environment:(LiscEnvironment *)env {
    
    if (self = [super init]) {
        self.expression = exp;			
		self.names = [NSMutableArray array];
		for (LiscSymbol *s in vars) {
			//these will be the variable names bound to the arguments 
			//passed when the lambda is actually called
			[names addObject:s.name];
		}
		
		self.environment = env;
    }
    
    return self;
}

//calling a lambda then simply means evaluating the expression within the enclosing scope
- (LiscExpression *)callWithArgs:(NSArray *)args {
	LiscEnvironment *enclosingEnvironment = [[[LiscEnvironment alloc] initWithParams:names args:args outer:environment] autorelease];
    id result = [expression eval:enclosingEnvironment];
    return result;
}

- (void)dealloc {
    self.environment = nil;
    self.expression = nil;
    self.names = nil;
    [super dealloc];
}

@end
