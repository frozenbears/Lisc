
#import <Cocoa/Cocoa.h>
#import "LiscEnvironment.h"


@interface LiscBoolean : NSObject {
	BOOL value;
}

+ (id)t;
+ (id)f;

- (id)eval:(LiscEnvironment *)env;
- (NSString *)toString;
- (BOOL)isEqualToExpression:(id)exp;

@property(nonatomic, assign) BOOL value;

@end
