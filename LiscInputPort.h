

#import <Cocoa/Cocoa.h>

@interface LiscInputPort : NSObject {
	id lineBuffer;
}

//input streaming
- (id)readLine;
- (id)readString;

//tokenization and parsing
- (id)nextToken;
- (id)read;

@property(nonatomic, retain) id lineBuffer;

@end
