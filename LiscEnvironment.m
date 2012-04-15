
#import "LiscEnvironment.h"
#import "LiscSymbol.h"
#import "LiscFunction.h"
#import "LiscMathModule.h"
#import "LiscCoreModule.h"

@implementation LiscEnvironment

@synthesize dict, outer;

+ (LiscEnvironment *)globalEnvironment {
	
    NSArray *keys = [NSArray array];
    NSArray *values = [NSArray array];
	
    LiscEnvironment *e = [[[LiscEnvironment alloc] initWithParams:keys args:values outer:nil] autorelease];
	
	[e addModule:[[LiscMathModule new] autorelease]];
	[e addModule:[[LiscCoreModule new] autorelease]];
    
	return e;
}

- (id)initWithParams:(NSArray *)params args:(NSArray *)args outer:(LiscEnvironment *)env {
	
	if (self = [super init]) {
		self.dict = [[[NSMutableDictionary alloc] 
					  initWithObjects:args forKeys:params] autorelease];
		self.outer = env;
	}
	
	return self;
}

- (void)addModule:(LiscModule *)module {
	for (NSString *name in [module.bindings allKeys]) {
		[self.dict setObject:
		 [LiscFunction functionWithBlock:[module.bindings objectForKey:name]] forKey:name];
	}
}

- (LiscEnvironment *)environmentForVar:(NSString *)var {
	if ([dict objectForKey:var]) {
		return self;
	} else {
		return [outer environmentForVar:var];
	}
}

- (id)find:(NSString *)var {
	return [[[self environmentForVar:var] dict] objectForKey:var];
}

- (void)setWithVar:(NSString *)var expression:(id)exp {
    [[[self environmentForVar:var] dict] setValue:exp forKey:var];
}

- (void)defineWithVar:(NSString *)var expression:(id)exp {
    [dict setValue:exp forKey:var];
}

- (void)dealloc {
	self.dict = nil;
	self.outer = nil;
	[super dealloc];
}

@end
