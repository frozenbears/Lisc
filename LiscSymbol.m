
#import "LiscSymbol.h"
#import "LiscError.h"

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

//evaluating a symbol always means trying to resolve it
- (LiscExpression *)eval:(LiscEnvironment *)env {
	LiscExpression *retval = [env find:self.name];
	if (!retval) {
		NSString *errorMessage = [NSString stringWithFormat:@"Name Error: Unable to resolve symbol \"%@\"", self.name];
		[LiscError raiseNameError:errorMessage];
	}
	return retval;
}

- (NSString *)toString {
	return self.name;
}

- (BOOL)isEqualToExpression:(LiscExpression *)exp {
	if ([self isMemberOfClass:[exp class]]) {
		NSString *left = self.name;
		NSString *right = ((LiscSymbol *)exp).name;
		return [left isEqualToString:right];
	} else {
		return NO;
	}
}


@end
