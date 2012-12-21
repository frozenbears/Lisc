
#import "LiscBoolean.h"

@implementation LiscBoolean

@synthesize value;

+ (id)t {
	LiscBoolean *b = [[[LiscBoolean alloc]init] autorelease];
	b.value = YES;
	return b;
}

+ (id)f {
	LiscBoolean *b = [[[LiscBoolean alloc]init] autorelease];
	b.value = NO;
	return b;
}

- (NSString *)toString {
	if (self.value) {
		return @"true";
	} else {
		return @"false";
	}
}

- (BOOL)isEqualToExpression:(LiscExpression *)exp {
	if ([self isMemberOfClass:[exp class]]) {
		BOOL left = self.value;
		BOOL right = ((LiscBoolean *)exp).value;
		return left == right;
	} else {
		return NO;
	}
}

@end
