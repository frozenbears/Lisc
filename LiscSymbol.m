
#import "LiscSymbol.h"

@implementation LiscSymbol

@synthesize name;

- (id)initWithString:(NSString *)string {
	
	if (self = [super init]) {
		self.name = string;
	}
	
	return self;
}

- (id)copyWithZone:(NSZone *)zone {
	LiscSymbol *copy = [[LiscSymbol alloc] initWithString:name];
	return copy;
}

- (id)eval:(LiscEnvironment *)env {
	return [env find:self.name];
}

- (NSString *)toString {
	return self.name;
}

- (BOOL)isEqualToExpression:(id)exp {
	if ([self isMemberOfClass:[exp class]]) {
		NSString *left = self.name;
		NSString *right = ((LiscSymbol *)exp).name;
		return [left isEqualToString:right];
	} else {
		return NO;
	}
}

- (void)dealloc {
	self.name = nil;
	[super dealloc];
}

@end
