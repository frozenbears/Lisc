
#import "LiscEOF.h"

@implementation LiscEOF

+ (id)eof {
    return [LiscEOF new];
}

- (NSString *)print {
    return @"#EOF#";
}

- (BOOL)isEqualToExpression:(LiscExpression *)exp {
    return [exp isKindOfClass:[LiscEOF class]];
}

@end
