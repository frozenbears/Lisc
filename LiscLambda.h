
#import <Foundation/Foundation.h>
#import "LiscEvaluator.h"
#import "LiscEnvironment.h"
#import "LiscCallable.h"

@interface LiscLambda : NSObject <LiscCallable>{
    
    LiscEnvironment *environment;
    NSArray *vars; //of LiscSymbol
	NSMutableArray *names; //of NSString
    id exppression;
}

- (id)initWithVars:(NSArray *)v expression:(id)exp environment:(LiscEnvironment *)env;
- (id)callWithArgs:(NSArray *)args;

@property(nonatomic, retain) LiscEnvironment *environment;
@property(nonatomic, retain) NSArray *vars;
@property(nonatomic, retain) NSMutableArray *names;
@property(nonatomic, retain) id expression;

@end
