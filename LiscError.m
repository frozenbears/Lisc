
#import "LiscError.h"

@implementation LiscError

+ (void)throw:(NSString *)name withReason:(NSString *)reason {

	@throw [NSException exceptionWithName:name
								   reason:reason  
								 userInfo:nil];
}

+ (void)raiseSyntaxError:(NSString *)reason {
	[LiscError throw:@"SyntaxError" withReason:reason];
}

+ (void)raiseNameError:(NSString *)reason {
	[LiscError throw:@"NameError" withReason:reason];
}

+ (void)raiseTypeError:(NSString *)reason {
	[LiscError throw:@"TypeError" withReason:reason];
}

+ (void)raiseIndexError:(NSString *)reason {
	[LiscError throw:@"IndexError" withReason:reason];
}

@end
