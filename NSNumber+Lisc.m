
#import "NSNumber+Lisc.h"

@implementation NSNumber(Lisc)

- (id)eval:(LiscEnvironment *)env {
	return self;
}

- (NSString *)toString {
	return [NSString stringWithFormat:@"%g", [self doubleValue]];
}

- (BOOL)isEqualToExpression:(id)exp {
	if ([self isMemberOfClass:[exp class]]) {
		return [self isEqualToNumber:(NSNumber *)exp];
	} else {
		return NO;
	}
}

@end
