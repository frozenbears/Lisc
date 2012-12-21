
#import <Cocoa/Cocoa.h>
#import "LiscExpression.h"

@interface LiscString : LiscExpression {
	NSString *string;
}

@property(nonatomic, retain) NSString *string;

+ (id)stringWithString:(NSString *)theString;
- (id)initWithString:(NSString *)theString;

@end
