
#import <Cocoa/Cocoa.h>
#import "LiscModule.h"

@interface LiscEnvironment : NSObject {
	
	NSMutableDictionary *dict;
	LiscEnvironment *outer;
}


+ (LiscEnvironment *)globalEnvironment;

- (id)initWithParams:(NSArray *)params args:(NSArray *)args outer:(LiscEnvironment *)env;
- (void)addModule:(LiscModule *)module;
- (LiscEnvironment *)environmentForVar:(NSString *)var;
- (id)find:(NSString *)var;
- (void)setWithVar:(NSString *)var expression:(id)exp;
- (void)defineWithVar:(NSString *)var expression:(id)exp;

@property(nonatomic, retain) NSMutableDictionary *dict;
@property(nonatomic, retain) LiscEnvironment *outer;

@end
