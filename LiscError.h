
#import <Cocoa/Cocoa.h>

@interface LiscError : NSObject {

}

+ (void)raiseSyntaxError:(NSString *)reason;
+ (void)raiseNameError:(NSString *)reason;
+ (void)raiseTypeError:(NSString *)reason;
+ (void)raiseIndexError:(NSString *)reason;

@end
