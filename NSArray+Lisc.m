
#import "NSArray+Lisc.h"
#import "LiscSymbol.h"
#import "LiscLambda.h"
#import "LiscBoolean.h"
#import "LiscNil.h"

@implementation NSArray(Lisc)

- (id)eval:(LiscEnvironment *)env {
	
	id head = [(NSArray *)self objectAtIndex:0];
	
	if ([head isMemberOfClass:LiscSymbol.class]) {
		NSString *s = ((LiscSymbol *)head).name;
		
		if ([s isEqualToString:@"quote"]) {
			return [self objectAtIndex:1];
		} else if ([s isEqualToString:@"if"]) {
			id test = [self objectAtIndex:1];
			id conseq = [self objectAtIndex:2];
			id alt = [self objectAtIndex:3];
			
			id result = [test eval:env];
			BOOL b = NO;
			if([result isMemberOfClass:[LiscBoolean class]]) {
				b = ((LiscBoolean *)result).value;
			} else if (![result isMemberOfClass:[LiscNil class]]){
				b = YES;
			}
			
			if (b) {
				return [conseq eval:env];
			} else {
				return [alt eval:env];
			}
			
		} else if ([s isEqualToString:@"set!"]) {
			LiscSymbol *var = [self objectAtIndex:1];
			id exp = [self objectAtIndex:2];
			[env setWithVar:var.name expression:[exp eval:env]];
		} else if ([s isEqualToString:@"define"]) {
			LiscSymbol *var = [self objectAtIndex:1];
			id exp = [self objectAtIndex:2];
			[env defineWithVar:var.name expression:[exp eval:env]];
		} else if ([s isEqualToString:@"do"]) {
			id exps = [self subarrayWithRange:NSMakeRange(1,[self count]-1)];
			
			id val;
			for(id exp in exps) {
				val = [exp eval:env];
			}
			return val;
		} else if([s isEqualToString:@"lambda"]) {
			//lambda!!
			id vars = [self objectAtIndex:1];
			id exp = [self objectAtIndex:2];
			LiscLambda *lambda = [[[LiscLambda alloc] initWithVars:vars 
														expression:exp 
													   environment:env] autorelease];
			return lambda;
		} else if([s isEqualToString:@"first"]) {
			id exp = [self objectAtIndex:1];
			return [(NSArray *)exp objectAtIndex:0];
		} else if([s isEqualToString:@"rest"]) {
			id exp = [self objectAtIndex:1];
			return [(NSArray *)exp subarrayWithRange:NSMakeRange(1, ((NSArray *)exp).count-1)];
		} else if([s isEqualToString:@"cons"]) {
			id exp = [self objectAtIndex:1];
			id exp2 = [self objectAtIndex:2];
			return [(NSArray *)exp arrayByAddingObject:exp2];
		} else {
			//procedure call
			NSMutableArray *exps = [NSMutableArray array];
			
			//evaluate all the expressions in the list
			for (id exp in self) {
				[exps addObject:[exp eval:env]];
			}
			
			//pop the head
			id proc = [exps objectAtIndex:0];
			[exps removeObjectAtIndex:0];
			
			//do it
			return [proc callWithArgs:exps];
		}
		
	} else {
		
		NSMutableArray *exps = [NSMutableArray array];
		
		//evaluate all the expressions in the list and return
		for (id exp in self) {
			[exps addObject:[exp eval:env]];
		}
		
		return exps;
    }
	
	return [LiscNil _nil];
	
}

- (NSString *)toString {
	
	NSString *listString = @"(";

	for (int i=0; i<self.count; i++) {
		
		if (i > 0 && i <self.count) {
			listString = [listString stringByAppendingString:@" "];
		} 
		
		listString = [listString stringByAppendingString:[[self objectAtIndex:i]toString]];
	}

	listString = [listString stringByAppendingString:@")"];

	return listString;
	
}

- (BOOL)isEqualToExpression:(id)exp {
	BOOL result = YES;
	if ([self isMemberOfClass:[exp class]]) {
		int count = ((NSArray *)exp).count;
		if (self.count == count) {
			for (int i = 0; i<count; i++) {
				id left = [self objectAtIndex:i];
				id right = [(NSArray *)exp objectAtIndex:i];
				if (![left isEqualToExpression:right]) {
					result = NO;
				}
			}
		} else {
			result = NO;
		}
	} else {
		result = NO;
	}
	return result;
}

@end
