
#import <Cocoa/Cocoa.h>
#import <Block.h>
#import "LiscFunction.h"

@interface LiscModule : NSObject {
	
	NSMutableDictionary *bindings; //NSString --> LiscFunction
}

- (void)setupBindings;

@property(nonatomic, retain) NSDictionary *bindings;

@end
