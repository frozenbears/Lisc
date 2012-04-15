
#import "LiscMathModule.h"
#import "LiscCallBlock.h"

@implementation LiscMathModule

- (void)setupBindings {
	
	LiscCallBlock add = ^(NSArray *args) {
		double sum;
				
		for (NSNumber *n in args) {
			sum += [n doubleValue];
		}
				
		return (id)[NSNumber numberWithDouble:sum]; 
	};
	
	LiscCallBlock subtract = ^(NSArray *args) {
		double difference = [[args objectAtIndex:0]doubleValue];
		
		NSArray *rest = [args subarrayWithRange:NSMakeRange(1, args.count-1)];
		
		for (NSNumber *n in rest) {
			difference -= [n doubleValue];
		}
		
		return (id)[NSNumber numberWithDouble:difference]; 
	};
	
	[bindings setObject:add forKey:@"+"];
	[bindings setObject:subtract forKey:@"-"];
}



@end