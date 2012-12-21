
#import "LiscCoreModule.h"
#import "LiscCallBlock.h"
#import "LiscBoolean.h"
#import "LiscList.h"
#import "LiscNil.h"
#import "LiscString.h"
#import "LiscError.h"
#import "LiscArgs.h"

@implementation LiscCoreModule

- (void)setupBindings {
	
	LiscCallBlock is = ^(NSArray *args) {
		[LiscArgs checkArgs:args 
				  expecting:[NSArray arrayWithObjects:[LiscExpression class], [LiscExpression class], nil]];
		
		LiscExpression *a = [args objectAtIndex:0];
		LiscExpression *b = [args objectAtIndex:1];
		
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
			
			LiscExpression *exp = [args objectAtIndex:i];
			
			if ([exp isKindOfClass:[LiscString class]]) {
				output = [output stringByAppendingString:((LiscString *)exp).string];
			} else {
				output = [output stringByAppendingString:[[args objectAtIndex:i]toString]];
			}
		}
		
		NSFileHandle *outhandle = [NSFileHandle fileHandleWithStandardOutput];
		[outhandle writeData:[output dataUsingEncoding:NSUTF8StringEncoding]];
		[outhandle writeData:[@"\n"  dataUsingEncoding:NSUTF8StringEncoding]];
		
		return (id)[LiscNil _nil];		
	};
	
	LiscCallBlock first = ^(NSArray *args) {
		[LiscArgs checkArgs:args expecting:[NSArray arrayWithObjects:[LiscList class],nil]];
		LiscList *list = [args objectAtIndex:0];
		if (list.array.count > 0) {
			return [list.array objectAtIndex:0];
		} else {
			[LiscError raiseIndexError:@"Index Error: list index is out of bounds"];
		}
		
		return (id)[LiscNil _nil];	
	};
	
	LiscCallBlock last = ^(NSArray *args) {
		[LiscArgs checkArgs:args expecting:[NSArray arrayWithObjects:[LiscList class],nil]];
		LiscList *list = [args objectAtIndex:0];
		if (list.array.count > 0) {
			return [list.array objectAtIndex:list.array.count-1];
		} else {
			[LiscError raiseIndexError:@"Index Error: list index is out of bounds"];
		}
		
		return (id)[LiscNil _nil];			
	};
	
	LiscCallBlock rest = ^(NSArray *args) {
		[LiscArgs checkArgs:args expecting:[NSArray arrayWithObjects:[LiscList class],nil]];
		LiscList *list = [args objectAtIndex:0];
		if (list.array.count > 1) {
			return [LiscList listWithArray:[list.array subarrayWithRange:NSMakeRange(1, list.array.count-1)]];
		} else {
			//return the empty list instead of raising an error
			return [LiscList listWithArray:[NSArray array]];
		}
		
		return (id)[LiscNil _nil];
	};
	
	LiscCallBlock cons = ^(NSArray *args) {
		[LiscArgs checkArgs:args expecting:[NSArray arrayWithObjects:[LiscList class],[NSObject class],nil]];
		LiscList *list = [args objectAtIndex:0];
		id exp = [args objectAtIndex:1];
		return [LiscList listWithArray:[list.array arrayByAddingObject:exp]];
		
		return (id)[LiscNil _nil];		
	};
	
	[bindings setObject:[LiscFunction functionWithBlock:is] forKey:@"is"];
	[bindings setObject:[LiscFunction functionWithBlock:print] forKey:@"print"];
	[bindings setObject:[LiscFunction functionWithBlock:first] forKey:@"first"];
	[bindings setObject:[LiscFunction functionWithBlock:last] forKey:@"last"];
	[bindings setObject:[LiscFunction functionWithBlock:rest] forKey:@"rest"];
	[bindings setObject:[LiscFunction functionWithBlock:cons] forKey:@"cons"];
}

@end
