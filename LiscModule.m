
#import "LiscModule.h"

@implementation LiscModule

- (id)init {
    if (self = [super init]) {
        self.bindings = [NSMutableDictionary dictionary];
        [self setupBindings];
    }
    
    return self;
}


//override to customize
- (void)setupBindings {
}

- (void)addBindingWithName:(NSString *)name withFunction:(LiscFunction *)function {
    self.bindings[name] = function;
}

@end
