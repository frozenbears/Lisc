
#import "LiscEvaluator.h"
#import "LiscSymbol.h"
#import "LiscLambda.h"

@implementation LiscEvaluator

- (id)evaluate:(id)x withEnvironment:(LiscEnvironment *)env {
	return [x eval:env];		
}

@end
