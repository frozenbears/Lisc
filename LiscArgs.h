
#import <Cocoa/Cocoa.h>

//convenience class for checking function arguments against expected types
@interface LiscArgs : NSObject

//if variadic, the last expected argument type can be repeated
+ (void)checkArgs:(NSArray *)args expecting:(NSArray *)expected variadic:(BOOL)variadic; //NSArray of Class
+ (void)checkArgs:(NSArray *)args expecting:(NSArray *)expected;

@end
