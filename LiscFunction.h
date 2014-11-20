
#import <Cocoa/Cocoa.h>
#import "LiscCallable.h"
#import "LiscCallBlock.h"
#import "LiscExpression.h"

@interface LiscFunction : LiscExpression <LiscCallable>

+ (LiscFunction *)functionWithBlock:(LiscCallBlock)b;
- (id)initWithBlock:(LiscCallBlock)b;

@property(nonatomic, strong) LiscCallBlock block;

@end
