
#import "LiscTest.h"
#import "LiscStringInputPort.h"
#import "LiscEOF.h"

@implementation LiscTest

@synthesize environment;
@synthesize expression;
@synthesize expectedExpression;
@synthesize inputString;
@synthesize expectedString;

- (id)initWithExpression:(LiscExpression *)theExpression expectingResult:(LiscExpression *)expectedResult {
	if (self = [super init]) {
		self.environment = [LiscEnvironment globalEnvironment];
		self.expression = theExpression;
		self.expectedExpression = expectedResult;
	}
	return self;
}

+ (id)testWithExpression:(LiscExpression *)theExpression expectingResult:(LiscExpression *)expectedResult {
	return [[LiscTest alloc] initWithExpression:theExpression expectingResult:expectedResult];
}

- (id)initWithInputString:(NSString *)theInputString expectingResult:(NSString *)expectedResult {
	if (self = [super init]) {
		self.environment = [LiscEnvironment globalEnvironment];
		self.inputString = theInputString;
		self.expectedString = expectedResult;
	}
	return self;
}

+ (id)testWithInputString:(NSString *)theInputString expectingResult:(NSString *)expectedResult {
	return [[LiscTest alloc] initWithInputString:theInputString expectingResult:expectedResult];
}

- (BOOL)run {
	@try {
		if (inputString) {
			LiscStringInputPort *inport = [[LiscStringInputPort alloc] initWithString:inputString];
			LiscStringInputPort *expectedPort = [[LiscStringInputPort alloc] initWithString:expectedString];
			
			LiscExpression *exp = nil;
			
			//we want to read through and evaluate all the expressions in the input string
			//but only compare the last one with the expected value
			while (1) {
				LiscExpression *read = [[inport read] eval:environment];
				if ([read isKindOfClass:[LiscEOF class]]) {
					break;
				}
				exp = read;
			}
			
			LiscExpression *exp2 = [[expectedPort read] eval:environment];
			
			BOOL result = [exp isEqualToExpression:exp2];
			NSLog(@"%@ => %@, expecting %@: %@", inputString, [exp toString], [exp2 toString], result ? @"PASS" : @"FAIL");
			return result;
		} else {
			BOOL result = [[expression eval:environment] isEqualToExpression:expectedExpression];
			NSLog(@"%@ => %@, expecting %@: %@", [expression toString], [expectedExpression toString], [expectedExpression toString], result ? @"PASS" : @"FAIL" );
			return result;
		}
	} @catch (NSException *e) {
		NSString *test = inputString ? : [expression toString];
		NSString *expected = expectedString ? : [expectedExpression toString];
		NSLog(@"%@, expecting %@: %@, %@", test, expected, e.description, @"FAIL");
		return NO;
	}
}


@end
