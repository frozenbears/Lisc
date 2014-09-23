
#import <Cocoa/Cocoa.h>
#import <Block.h>
#import "LiscFunction.h"

@interface LiscModule : NSObject

- (void)setupBindings;
- (void)addBindingWithName:(NSString *)name withFunction:(LiscFunction *)function;

@property(nonatomic, strong) NSMutableDictionary *bindings;

@end
