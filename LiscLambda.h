
#import <Foundation/Foundation.h>
#import "LiscEnvironment.h"
#import "LiscCallable.h"
#import "LiscExpression.h"

@interface LiscLambda : LiscExpression <LiscCallable>

- (id)initWithVars:(NSArray *)vars expressions:(NSArray *)exps environment:(__weak LiscEnvironment *)env;

@property(nonatomic, weak) LiscEnvironment *environment;
@property(nonatomic, strong) NSMutableArray *names; //of NSString;
@property(nonatomic, strong) NSArray *expressions;

@end
