
#import <Cocoa/Cocoa.h>
#import "LiscInputPort.h"

@interface LiscStringInputPort : LiscInputPort {
	
	NSMutableArray *lines;
}

- (id)initWithString:(NSString *)inputString;

@property(nonatomic, retain) NSMutableArray *lines;

@end
