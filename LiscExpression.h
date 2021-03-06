
#import <Cocoa/Cocoa.h>

@class LiscEnvironment;

//for our purposes an expression is anything that can be evaluated
@interface LiscExpression : NSObject

- (LiscExpression *)eval:(LiscEnvironment *)env;
- (NSString *)print;
- (BOOL)isEqualToExpression:(LiscExpression *)exp;

@end
