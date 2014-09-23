
#import <Cocoa/Cocoa.h>
#import "LiscTest.h"

@interface LiscTestSuite : NSObject

+ (id)suite;
- (void)addTest:(LiscTest *)test;
- (BOOL)run;

@property(nonatomic, strong) NSMutableArray *tests;

@end
