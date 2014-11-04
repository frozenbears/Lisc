
#import "LiscTest.h"
#import "LiscStringInputPort.h"
#import "LiscEOF.h"
#import "LiscError.h"

@implementation LiscTest

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
        if (self.inputString) {
            LiscStringInputPort *inport = [[LiscStringInputPort alloc] initWithString:self.inputString];
            LiscStringInputPort *expectedPort = [[LiscStringInputPort alloc] initWithString:self.expectedString];
            
            LiscExpression *exp = nil;
            
            //we want to read through and evaluate all the expressions in the input string
            //but only compare the last one with the expected value
            while (1) {
                LiscExpression *read = [[inport read] eval:self.environment];
                if ([read isKindOfClass:[LiscEOF class]]) {
                    break;
                }
                exp = read;
            }
            
            LiscExpression *exp2 = [[expectedPort read] eval:self.environment];
            
            BOOL result = [exp isEqualToExpression:exp2];
            NSLog(@"%@ => %@, expecting %@: %@", self.inputString, [exp print], [exp2 print], result ? @"PASS" : @"FAIL");
            return result;
        } else {
            BOOL result = [[self.expression eval:self.environment] isEqualToExpression:self.expectedExpression];
            NSLog(@"%@ => %@, expecting %@: %@", [self.expression print], [self.expectedExpression print], [self.expectedExpression print], result ? @"PASS" : @"FAIL" );
            return result;
        }
    } @catch (NSException *e) {
        if (![e isKindOfClass:[LiscError class]]) {
            @throw;
        }
        NSString *test = self.inputString ? : [self.expression print];
        NSString *expected = self.expectedString ? : [self.expectedExpression print];
        NSLog(@"%@, expecting %@: %@, %@", test, expected, e.description, @"FAIL");
        return NO;
    }
}


@end
