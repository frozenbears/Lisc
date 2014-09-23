
#import <Cocoa/Cocoa.h>
#import "LiscExpression.h"

@interface LiscString : LiscExpression

@property(nonatomic, strong) NSString *string;

+ (id)stringWithString:(NSString *)theString;
- (id)initWithString:(NSString *)theString;

@end
