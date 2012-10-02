
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
	id retval = [env find:self.name];
	if (!retval) {
		NSString *errorMessage = [NSString stringWithFormat:@"Symbol Error: Unable to resolve symbol \"%@\"", self.name];
		@throw [NSException exceptionWithName:@"SymbolError"
									   reason:errorMessage
									 userInfo:nil];
	}
	return retval;
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
