

#import "LiscTestSuite.h"

@implementation LiscTestSuite

@synthesize tests;

- (id)init {
	if (self = [super init]) {
		self.tests = [NSMutableArray array];
	}
	
	return self;
}

+ (id)suite {
	return [[[LiscTestSuite alloc] init] autorelease];
}

- (void)addTest:(LiscTest *)test {
	[tests addObject:test];
}

- (BOOL)run {
	int passed = 0;
	for (LiscTest *test in tests) {
		if ([test run]) {
			passed++;
		}
	}
	NSLog(@"%d/%d tests passed", passed, tests.count);
	
	return passed == tests.count;
}

- (void)dealloc {
	self.tests = nil;
	[super dealloc];
}

@end
