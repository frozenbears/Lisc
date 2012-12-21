
#import <Cocoa/Cocoa.h>
#import "LiscCallable.h"
#import "LiscCallBlock.h"
#import "LiscExpression.h"

@interface LiscFunction : LiscExpression <LiscCallable> {
	LiscCallBlock block;
}

+ (LiscFunction *)functionWithBlock:(LiscCallBlock)b;
- (id)initWithBlock:(LiscCallBlock)b;

@property(nonatomic, assign) LiscCallBlock block;

@end
