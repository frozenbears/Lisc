
#import "LiscModule.h"

@implementation LiscModule

@synthesize bindings;

- (id)init {
	if (self = [super init]) {
		self.bindings = [NSMutableDictionary dictionary];
		[self setupBindings];
	}
	
	return self;
}

- (void)dealloc {
	self.bindings = nil;
	[super dealloc];
}

//override to customize
- (void)setupBindings {
}

- (void)addBindingWithName:(NSString *)name withFunction:(LiscFunction *)function {
	[bindings setObject:function forKey:name];
}

@end
