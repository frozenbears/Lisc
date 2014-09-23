
#import <Cocoa/Cocoa.h>
#import "LiscExpression.h"
#import "LiscEnvironment.h"

@interface LiscSymbol : LiscExpression

- (id)initWithString:(NSString *)string;

@property(nonatomic, copy) NSString *name;

@end
