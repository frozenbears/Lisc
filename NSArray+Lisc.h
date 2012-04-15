
#import <Cocoa/Cocoa.h>
#import "LiscEnvironment.h"

@interface NSArray(Lisc)

- (id)eval:(LiscEnvironment *)env;
- (NSString *)toString;
- (BOOL)isEqualToExpression:(id)exp;

@end
