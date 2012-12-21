
#import <Foundation/Foundation.h>
#import "LiscEvaluator.h"
#import "LiscEnvironment.h"
#import "LiscCallable.h"
#import "LiscExpression.h"

@interface LiscLambda : LiscExpression <LiscCallable> {
    
    LiscEnvironment *environment;
	NSMutableArray *names; //of NSString
    id expression;
}

- (id)initWithVars:(NSArray *)vars expression:(id)exp environment:(LiscEnvironment *)env;

@property(nonatomic, retain) LiscEnvironment *environment;
@property(nonatomic, retain) NSMutableArray *names;
@property(nonatomic, retain) id expression;

@end
