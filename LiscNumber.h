
#import <Cocoa/Cocoa.h>
#import "LiscExpression.h"

@interface LiscNumber : LiscExpression

+ (id)numberWithNumber:(NSNumber *)theNumber;
- (id)initWithNumber:(NSNumber *)theNumber;

@property(nonatomic, strong) NSNumber *number;

@end
