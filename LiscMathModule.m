
#import "LiscMathModule.h"
#import "LiscCallBlock.h"

@implementation LiscMathModule

- (void)setupBindings {
	
	LiscCallBlock add = ^(NSArray *args) {
		double sum = [[args objectAtIndex:0] doubleValue];
		
		NSArray *rest = [args subarrayWithRange:NSMakeRange(1, args.count-1)];
				
		for (NSNumber *n in rest) {
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
	
	[bindings setObject:[LiscFunction functionWithBlock:add withMinArgs:2] forKey:@"+"];
	[bindings setObject:[LiscFunction functionWithBlock:subtract withMinArgs:2] forKey:@"-"];
}



@end