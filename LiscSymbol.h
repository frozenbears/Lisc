
#import <Cocoa/Cocoa.h>
#import "LiscEnvironment.h"

@interface LiscSymbol : NSObject {
	NSString *name;
}

- (id)initWithString:(NSString *)string;

- (id)eval:(LiscEnvironment *)env;
- (NSString *)toString;
- (BOOL)isEqualToExpression:(id)exp;

@property(nonatomic, copy) NSString *name;

@end
