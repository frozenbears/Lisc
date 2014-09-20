
#import <Cocoa/Cocoa.h>
#import "LiscInputPort.h"

@interface LiscStringInputPort : LiscInputPort {
	
	NSMutableArray *lines;
}

- (id)initWithString:(NSString *)inputString;

@property(nonatomic, strong) NSMutableArray *lines;

@end
