
#import <Cocoa/Cocoa.h>
#import "LiscInputPort.h"

@interface LiscStringInputPort : LiscInputPort

+ (instancetype)stringInputPortWithString:(NSString *)inputString;
- (id)initWithString:(NSString *)inputString;

@property(nonatomic, strong) NSMutableArray *lines;

@end
