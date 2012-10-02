
#import "LiscFunction.h"

@implementation LiscFunction

@synthesize block;
@synthesize minArgs;

+ (LiscFunction *)functionWithBlock:(LiscCallBlock) b withMinArgs:(int)theMinArgs {
	return [[[LiscFunction alloc] initWithBlock:b withMinArgs:theMinArgs] autorelease];
}

- (id)initWithBlock:(LiscCallBlock) b withMinArgs:(int)theMinArgs {
	if (self = [super init]) {
		self.block = b;
		self.minArgs = theMinArgs;
	}
	
	return self;
}

- (id)callWithArgs:(NSArray *)args {
	if (args.count >= minArgs) {
		return block(args);
	} else {
		NSString *errorMessage = [NSString stringWithFormat:@"Parameter Error: expected at least %d arguments", minArgs];
		@throw [NSException exceptionWithName:@"ParameterError"
									   reason:errorMessage
									 userInfo:nil];
	}
}

- (void)dealloc {
	self.block = nil;
	[super dealloc];
}

@end
