
#import <Cocoa/Cocoa.h>
#import "LiscExpression.h"

@interface LiscBoolean : LiscExpression

+ (id)t;
+ (id)f;

@property(nonatomic, assign) BOOL value;

@end
