
#import "LiscBoolean.h"

@implementation LiscBoolean

- (instancetype)initWithValue:(BOOL)value {
    self = [super init];
    if (self) {
        self.value = value;
    }
    return self;
}

+ (instancetype)booleanWithValue:(BOOL)value {
    return [[self alloc] initWithValue:value];
}

+ (id)t {
    return [LiscBoolean booleanWithValue:YES];
}

+ (id)f {
    return [LiscBoolean booleanWithValue:NO];
}

- (NSString *)print {
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
