
#import <Cocoa/Cocoa.h>
#import "LiscEnvironment.h"

@interface NSString(Lisc)

- (id)readLisc;

- (id)atom;

- (id)eval:(LiscEnvironment *)env;
- (NSString *)toString;
- (BOOL)isEqualToExpression:(id)exp;

@end
