
#import <Cocoa/Cocoa.h>
#import "LiscModule.h"
#import "LiscExpression.h"

@interface LiscEnvironment : NSObject {
	NSMutableDictionary *dict; //where we store all the bindings
	LiscEnvironment *outer; //an optional outer environment, for keeping track of scope
}

+ (LiscEnvironment *)globalEnvironment; //use this to make a brand new one with no outer scope

- (id)initWithParams:(NSArray *)params args:(NSArray *)args outer:(LiscEnvironment *)env;
- (void)addModule:(LiscModule *)module;
- (LiscEnvironment *)environmentForVar:(NSString *)var; //get the environment (if any) that binds the supplied variable, starting here
- (LiscExpression *)find:(NSString *)var; //symbol resolution
- (void)setWithVar:(NSString *)var expression:(LiscExpression *)exp;
- (void)defineWithVar:(NSString *)var expression:(LiscExpression *)exp;

@property(nonatomic, retain) NSMutableDictionary *dict;
@property(nonatomic, retain) LiscEnvironment *outer;

@end
