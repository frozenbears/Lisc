
#import <Cocoa/Cocoa.h>
#import "LiscExpression.h"

@interface LiscInputPort : LiscExpression

//input streaming
- (id)readLine;
- (id)readString;

//tokenization and parsing
- (id)nextToken;
- (id)read;

@property(nonatomic, strong) id lineBuffer;
@property(nonatomic, strong) NSRegularExpression *tokenizer;

@end
