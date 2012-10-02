
#import <Cocoa/Cocoa.h>
#import "LiscInputPort.h"

@interface LiscFileInputPort : LiscInputPort {
	NSFileHandle *handle;
}

@property(nonatomic, retain) NSFileHandle *handle;

- (id)initWithFile:(NSString *)path;
- (id)initWithStdin;

+ (LiscFileInputPort *)portWithFile:(NSString *)path;
+ (LiscFileInputPort *)portWithStdin;

@end
