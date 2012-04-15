
#import <Cocoa/Cocoa.h>
#import "LiscEnvironment.h"

@protocol LiscExpression

- (id)eval:(LiscEnvironment *)env;
- (NSString *)toString;
- (BOOL)isEqualToExpression:(id)exp;

@end
