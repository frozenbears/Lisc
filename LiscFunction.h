
#import <Cocoa/Cocoa.h>
#import "LiscCallable.h"
#import "LiscModule.h"
#import "LiscCallBlock.h"


@interface LiscFunction : NSObject <LiscCallable> {
	LiscCallBlock block;
}

+ (LiscFunction *)functionWithBlock:(LiscCallBlock) b;
- (id)initWithBlock:(LiscCallBlock)b;

@property(nonatomic, assign) LiscCallBlock block;

@end
