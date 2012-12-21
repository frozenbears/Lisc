
#import "LiscArgs.h"
#import "LiscExpression.h"
#import "LiscError.h"

@implementation LiscArgs

+ (void)checkArgs:(NSArray *)args expecting:(NSArray *)expected variadic:(BOOL)variadic {
	// we should at least have as many arguments as we expect
	// Note: this means we're effectively ignoring all additional values, which may not actually be desirable
	if (args.count < expected.count) {
		NSString *atLeast = variadic ? @"at least " : @"";
		NSString *errorString = [NSString stringWithFormat:@"Type Error: expected %@%d arguments and received %d", atLeast, expected.count, args.count]; 
		[LiscError raiseTypeError:errorString];
	}
	
	//if we have enough arguments, iterate through and compare types
	for (int i = 0; i < args.count; i++) {
		LiscExpression *exp = [args objectAtIndex:i];
		Class type;
		if (i > expected.count-1) {
			if (variadic) {
				//if this is a variadic expression, we only care about the last known type
				type = [expected objectAtIndex:expected.count-1];
			} else {
				//otherwise there's no point in further checking
				break;
			}
		} else {
			type = [expected objectAtIndex:i];
		}
		if (![exp isKindOfClass:type]) {
			NSString *errorString = [NSString stringWithFormat:@"Type Error: expected type %@ and received %@", type, exp]; 
			[LiscError raiseTypeError:errorString];
		}
	}
}

+ (void)checkArgs:(NSArray *)args expecting:(NSArray *)expected {
	[LiscArgs checkArgs:args expecting:expected variadic:NO];
}

@end
