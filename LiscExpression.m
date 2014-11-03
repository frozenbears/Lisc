
#import "LiscExpression.h"


@implementation LiscExpression

- (LiscExpression *)eval:(LiscEnvironment *)env {
	return self;
}

- (NSString *)print {
	return [self description];
}

//most derived types should probably override this, unless weird comparison semantics are desired
- (BOOL)isEqualToExpression:(LiscExpression *)exp {
	return [self isEqualTo:exp];
}

@end
