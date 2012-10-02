
#import "LiscEOF.h"

@implementation LiscEOF

+ (id)eof {
	return [[LiscEOF new] autorelease];
}

- (NSString *)toString {
	return @"#EOF#";
}

@end
