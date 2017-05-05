
#import <Cocoa/Cocoa.h>

@interface LiscError : NSException

+ (void)raiseSyntaxError:(NSString *)reason;
+ (void)raiseNameError:(NSString *)reason;
+ (void)raiseTypeError:(NSString *)reason;
+ (void)raiseIndexError:(NSString *)reason;

@end
