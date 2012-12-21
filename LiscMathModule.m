
#import "LiscMathModule.h"
#import "LiscCallBlock.h"
#import "LiscNumber.h"
#import "LiscError.h"
#import "LiscArgs.h"

@implementation LiscMathModule

- (void)setupBindings {
	
	LiscCallBlock add = ^(NSArray *args) {
		double sum;
		BOOL first = YES;
		
		[LiscArgs checkArgs:args 
				  expecting:[NSArray arrayWithObjects:[LiscNumber class], [LiscNumber class], nil]
				   variadic:YES];
		
		for (LiscNumber *n in args) {
			if (first) {
				sum = [n.number doubleValue];
				first = NO;
			} else {
				sum += [((LiscNumber *)n).number doubleValue];
			}
		}
				
		return (id)[LiscNumber numberWithNumber:[NSNumber numberWithDouble:sum]]; 
	};
	
	LiscCallBlock subtract = ^(NSArray *args) {
		double difference;
		BOOL first = YES;
		
		[LiscArgs checkArgs:args 
				  expecting:[NSArray arrayWithObjects:[LiscNumber class], [LiscNumber class], nil]
				   variadic:YES];
		
		for (LiscNumber *n in args) {
			if (first) {
				difference = [n.number doubleValue];
				first = NO;
			} else {
				difference -= [((LiscNumber *)n).number doubleValue];
			}			
		}		
		return (id)[LiscNumber numberWithNumber:[NSNumber numberWithDouble:difference]]; 
	};
	
	[bindings setObject:[LiscFunction functionWithBlock:add] forKey:@"+"];
	[bindings setObject:[LiscFunction functionWithBlock:subtract] forKey:@"-"];
}

@end