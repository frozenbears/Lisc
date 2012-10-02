
#import <Cocoa/Cocoa.h>
#import "LiscCallable.h"
#import "LiscCallBlock.h"


@interface LiscFunction : NSObject <LiscCallable> {
	LiscCallBlock block;
	int minArgs;
}

+ (LiscFunction *)functionWithBlock:(LiscCallBlock) b withMinArgs:(int)theMinArgs;
- (id)initWithBlock:(LiscCallBlock)b withMinArgs:(int)theMinArgs;

@property(nonatomic, assign) LiscCallBlock block;
@property(nonatomic, assign) int minArgs;

@end
