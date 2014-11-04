
#import <Cocoa/Cocoa.h>
#import "LiscModule.h"
#import "LiscExpression.h"

@interface LiscEnvironment : NSObject

+ (LiscEnvironment *)environment; //use this to make a brand new one with no outer scope

- (id)initWithParams:(NSArray *)params args:(NSArray *)args outer:(LiscEnvironment *)env;
- (void)addModule:(LiscModule *)module;
- (LiscEnvironment *)environmentForVar:(NSString *)var; //get the environment (if any) that binds the supplied variable, starting here
- (LiscExpression *)find:(NSString *)var; //symbol resolution
- (void)setWithVar:(NSString *)var expression:(LiscExpression *)exp;
- (void)defineWithVar:(NSString *)var expression:(LiscExpression *)exp;

@property(nonatomic, strong) NSMutableDictionary *dict;
@property(nonatomic, strong) LiscEnvironment *outer;

@end
