
#import "LiscEOF.h"

@implementation LiscEOF

+ (id)eof {
	return [[LiscEOF new] autorelease];
}

- (NSString *)toString {
	return @"#EOF#";
}

- (BOOL)isEqualToExpression:(LiscExpression *)exp {
	return [exp isKindOfClass:[LiscEOF class]];
}

@end
