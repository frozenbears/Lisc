
#import "LiscFunction.h"
#import "LiscError.h"

@implementation LiscFunction

+ (LiscFunction *)functionWithBlock:(LiscCallBlock)b {
    return [[LiscFunction alloc] initWithBlock:b];
}

- (id)initWithBlock:(LiscCallBlock)b {
    if (self = [super init]) {
        self.block = b;
    }
    
    return self;
}

- (LiscExpression *)callWithArgs:(NSArray *)args {
    return self.block(args);
}

- (void)dealloc {
    self.block = nil;
}

@end
