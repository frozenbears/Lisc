
#import <Cocoa/Cocoa.h>
#import "LiscExpression.h"

@interface LiscInputPort : LiscExpression {
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
