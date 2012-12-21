
#import <Cocoa/Cocoa.h>
#import "LiscExpression.h"

@interface LiscNumber : LiscExpression {
	NSNumber *number;
}

+ (id)numberWithNumber:(NSNumber *)theNumber;
- (id)initWithNumber:(NSNumber *)theNumber;

@property(nonatomic, retain) NSNumber *number;

@end
