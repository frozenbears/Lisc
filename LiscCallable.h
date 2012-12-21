
#import <Foundation/Foundation.h>
#import "LiscExpression.h"

@protocol LiscCallable <NSObject>

- (LiscExpression *)callWithArgs:(NSArray *)args;

@end
