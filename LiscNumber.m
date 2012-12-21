
#import "LiscNumber.h"

@implementation LiscNumber

@synthesize number;

- (id)initWithNumber:(NSNumber *)theNumber {
	if (self = [super init]) {
		self.number = theNumber;
	}
	return self;
}

+ (id)numberWithNumber:(NSNumber *)theNumber {
	return [[[LiscNumber alloc] initWithNumber:theNumber] autorelease];
}

- (NSString *)toString {
	return [NSString stringWithFormat:@"%g", [number doubleValue]];
}

- (BOOL)isEqualToExpression:(LiscExpression *)exp {
	if ([self isMemberOfClass:[exp class]]) {
		NSNumber *num = ((LiscNumber *) exp).number;
		return [number isEqualToNumber:num];
	} else {
		return NO;
	}
}

- (void)dealloc {
	self.number = nil;
	[super dealloc];
}

@end
