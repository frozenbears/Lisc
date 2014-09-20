
#import "LiscNil.h"

@implementation LiscNil

+ (LiscNil *)_nil {
	return [LiscNil new];
}

- (NSString *)toString {
	return @"nil";
}

- (BOOL)isEqualToExpression:(LiscExpression *)exp {
	return [self isMemberOfClass:[exp class]];
}

@end
