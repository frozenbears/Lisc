
#import "LiscString.h"

@implementation LiscString

@synthesize string;

- (id)initWithString:(NSString *)theString {
	if (self = [super init]) {
		self.string = theString;
	}
	
	return self;
}

+ (id)stringWithString:(NSString *)theString {
	return [[LiscString alloc] initWithString:theString];
}

- (NSString *)toString {
	NSString *output = @"\"";
	output = [output stringByAppendingString:string];
	output = [output stringByAppendingString:@"\""];
	return output;
}

- (BOOL)isEqualToExpression:(LiscExpression *)exp {
	if ([exp isKindOfClass:[LiscString class]]) {
		return [self.string isEqualToString:((LiscString *)exp).string];
	} else {
		return NO;
	}
}


@end
