
#import "LiscFunction.h"
#import "LiscError.h"

@implementation LiscFunction

@synthesize block;

+ (LiscFunction *)functionWithBlock:(LiscCallBlock)b {
	return [[LiscFunction alloc] initWithBlock:b];
}

- (id)initWithBlock:(LiscCallBlock)b {
	if (self = [super init]) {
		self.block = b;
	}
	
	return self;
}

- (LiscExpression *)callWithArgs:(NSArray *)args {
	return block(args);
}

- (void)dealloc {
	self.block = nil;
}

@end
