
#import <Cocoa/Cocoa.h>
#import "LiscEnvironment.h"

@interface LiscNil : NSObject {

}

+ (LiscNil *)_nil;

- (id)eval:(LiscEnvironment *)env;
- (NSString *)toString;
- (BOOL)isEqualToExpression:(id)exp;

@end
