
#import <Cocoa/Cocoa.h>
#import "LiscEnvironment.h"
#import "LiscExpression.h"

@interface LiscTest : NSObject {
	
	LiscEnvironment *environment;
	LiscExpression *expression;
	LiscExpression *expectedExpression;
	NSString *inputString;
	NSString *expectedString;
}

- (id)initWithExpression:(LiscExpression *)theExpression expectingResult:(LiscExpression *)expectedResult;
+ (id)testWithExpression:(LiscExpression *)theExpression expectingResult:(LiscExpression *)expectedResult;
- (id)initWithInputString:(NSString *)theInputString expectingResult:(NSString *)expectedResult;
+ (id)testWithInputString:(NSString *)theInputString expectingResult:(NSString *)expectedResult;
- (BOOL)run;

@property(nonatomic, strong) LiscEnvironment *environment;
@property(nonatomic, strong) LiscExpression *expression;
@property(nonatomic, strong) LiscExpression *expectedExpression;
@property(nonatomic, copy) NSString *inputString;
@property(nonatomic, copy) NSString *expectedString;

@end
