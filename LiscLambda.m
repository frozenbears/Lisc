
#import "LiscLambda.h"
#import "LiscSymbol.h"

@implementation LiscLambda

@synthesize environment, vars, names, expression;

- (id)initWithVars:(NSArray *)v expression:(id)exp environment:(LiscEnvironment *)env {
    
    if (self = [super init]) {
        self.expression = exp;
		self.vars = v;
			
		self.names = [NSMutableArray array];
		for (LiscSymbol *s in v) {
			[names addObject:s.name];
		}
		
		self.environment = env;
    }
    
    return self;
}

- (id)callWithArgs:(NSArray *)args {
	LiscEnvironment *enclosingEnvironment = [[[LiscEnvironment alloc] initWithParams:names args:args outer:environment] autorelease];
    id result = [expression eval:enclosingEnvironment];
    return result;
}

- (void)dealloc {
    self.environment = nil;
    self.expression = nil;
    self.vars = nil;
    [super dealloc];
}

@end
