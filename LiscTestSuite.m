

#import "LiscTestSuite.h"

@implementation LiscTestSuite

- (id)init {
    if (self = [super init]) {
        self.tests = [NSMutableArray array];
    }
    
    return self;
}

+ (id)suite {
    return [[LiscTestSuite alloc] init];
}

- (void)addTest:(LiscTest *)test {
    [self.tests addObject:test];
}

- (BOOL)run {
    int passed = 0;
    for (LiscTest *test in self.tests) {
        if ([test run]) {
            passed++;
        }
    }
    NSLog(@"%d/%lu tests passed", passed, (unsigned long)self.tests.count);
    
    return passed == self.tests.count;
}


@end
