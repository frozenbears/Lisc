
#import "LiscNumber.h"

@implementation LiscNumber

- (id)initWithNumber:(NSNumber *)theNumber {
    if (self = [super init]) {
        self.number = theNumber;
    }
    return self;
}

+ (id)numberWithNumber:(NSNumber *)theNumber {
    return [[LiscNumber alloc] initWithNumber:theNumber];
}

- (NSString *)print {
    return [NSString stringWithFormat:@"%g", [self.number doubleValue]];
}

- (BOOL)isEqualToExpression:(LiscExpression *)exp {
    if ([self isMemberOfClass:[exp class]]) {
        NSNumber *num = ((LiscNumber *) exp).number;
        return [self.number isEqualToNumber:num];
    } else {
        return NO;
    }
}

@end
