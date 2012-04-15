
#import "LiscCoreModule.h"
#import "LiscCallBlock.h"
#import "LiscBoolean.h"
#import "LiscNil.h"


@implementation LiscCoreModule

- (void)setupBindings {
	
	LiscCallBlock is = ^(NSArray *args) {
		id a = [args objectAtIndex:0];
		id b = [args objectAtIndex:1];
		
		if ([a isEqualToExpression:b]) {
			return [LiscBoolean t];
		} else {
			return [LiscBoolean f];
		}
	};
	
	LiscCallBlock print = ^(NSArray *args) {
		NSString *output = [NSString string];
		for (int i=0; i<args.count; i++) {
			
			if (i > 0 && i <args.count) {
				output = [output stringByAppendingString:@" "];
			} 
			
			output = [output stringByAppendingString:[[args objectAtIndex:i]toString]];
		}
		NSLog(@"%@", output);
		return (id)[LiscNil _nil];		
	};
	
	[bindings setObject:is forKey:@"is"];
	[bindings setObject:print forKey:@"print"];
}

@end
