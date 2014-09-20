
#import <Cocoa/Cocoa.h>
#import "LiscExpression.h"

@interface LiscList : LiscExpression {

	NSMutableArray *array;
}

@property(nonatomic, strong) NSArray *array;

- (id)initWithArray:(NSArray *)theArray;
+ (id)listWithArray:(NSArray *)theArray;

@end
