
#import <Cocoa/Cocoa.h>
#import "LiscTest.h"

@interface LiscTestSuite : NSObject {

	NSMutableArray *tests;
}

+ (id)suite;
- (void)addTest:(LiscTest *)test;
- (BOOL)run;

@property(nonatomic, retain) NSMutableArray *tests;

@end
