
#import "LiscNil.h"

@implementation LiscNil

+ (LiscNil *)_nil {
	return [[LiscNil new] autorelease];
}

- (id)eval:(LiscEnvironment *)env {
	return self;
}

- (NSString *)toString {
	return @"nil";
}

- (BOOL)isEqualToExpression:(id)exp {
	return [self isMemberOfClass:[exp class]];
}

@end
