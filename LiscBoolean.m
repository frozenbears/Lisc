
#import "LiscBoolean.h"

@implementation LiscBoolean

+ (id)t {
    LiscBoolean *b = [[LiscBoolean alloc]init];
    b.value = YES;
    return b;
}

+ (id)f {
    LiscBoolean *b = [[LiscBoolean alloc]init];
    b.value = NO;
    return b;
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
