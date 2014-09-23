
#import <Foundation/Foundation.h>
#import "LiscEnvironment.h"
#import "LiscCallable.h"
#import "LiscExpression.h"

@interface LiscLambda : LiscExpression <LiscCallable>

- (id)initWithVars:(NSArray *)vars expression:(id)exp environment:(LiscEnvironment *)env;

@property(nonatomic, strong) LiscEnvironment *environment;
@property(nonatomic, strong) NSMutableArray *names; //of NSString;
@property(nonatomic, strong) id expression;

@end
