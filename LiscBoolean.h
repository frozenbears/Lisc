
#import <Cocoa/Cocoa.h>
#import "LiscExpression.h"

@interface LiscBoolean : LiscExpression {
	BOOL value;
}

+ (id)t;
+ (id)f;

@property(nonatomic, assign) BOOL value;

@end
