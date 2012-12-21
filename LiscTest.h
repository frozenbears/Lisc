
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

@property(nonatomic, retain) LiscEnvironment *environment;
@property(nonatomic, retain) LiscExpression *expression;
@property(nonatomic, retain) LiscExpression *expectedExpression;
@property(nonatomic, copy) NSString *inputString;
@property(nonatomic, copy) NSString *expectedString;

@end
