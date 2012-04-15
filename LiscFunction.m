
#import "LiscFunction.h"

@implementation LiscFunction

@synthesize block;

+ (LiscFunction *)functionWithBlock:(LiscCallBlock) b {
	return [[[LiscFunction alloc] initWithBlock:b] autorelease];
}

- (id)initWithBlock:(LiscCallBlock) b {
	if (self = [super init]) {
		self.block = b;
	}
	
	return self;
}

- (id)callWithArgs:(NSArray *)args {
	return block(args);
}

- (void)dealloc {
	self.block = nil;
	[super dealloc];
}

@end
