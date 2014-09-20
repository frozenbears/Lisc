
#import <Foundation/Foundation.h>
#import "LiscEnvironment.h"
#import "LiscCallable.h"
#import "LiscExpression.h"

@interface LiscLambda : LiscExpression <LiscCallable> {
    
    LiscEnvironment *environment;
	NSMutableArray *names; //of NSString
    id expression;
}

- (id)initWithVars:(NSArray *)vars expression:(id)exp environment:(LiscEnvironment *)env;

@property(nonatomic, strong) LiscEnvironment *environment;
@property(nonatomic, strong) NSMutableArray *names;
@property(nonatomic, strong) id expression;

@end
