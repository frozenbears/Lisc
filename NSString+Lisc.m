
#import "NSString+Lisc.h"
#import "LiscSymbol.h"


@implementation NSString(Lisc)

- (void)syntaxError:(NSString *)message {
	@throw [NSException exceptionWithName:@"SyntaxError"
								   reason:message  userInfo:nil];
}

- (NSArray *)tokenize {	
	NSString *cleaned = [self stringByReplacingOccurrencesOfString:@"(" withString:@" ( "];
	cleaned = [cleaned stringByReplacingOccurrencesOfString:@")" withString:@" ) "];
	
	//NSLog(@"cleaned expression: %@", cleaned);
	
	NSArray *tokens = [cleaned componentsSeparatedByString:@" "];
	tokens = [tokens filteredArrayUsingPredicate:
			  [NSPredicate predicateWithFormat:@"SELF != ''"]];
	
	//NSLog(@"tokens: %@", [tokens description]);
	
	return tokens;
}

- (id)atom:(NSString *)token {
	NSNumberFormatter *f = [NSNumberFormatter new];
	NSNumber *number = [f numberFromString:token];
	[f release];
	
	if (number) {
		return number;
	} else {
		return [[[LiscSymbol alloc] initWithString:token] autorelease];
	}
	return nil;
}

- (id)readFromTokens:(NSMutableArray *)tokenArray {
	//NSLog(@"reading from tokens...");
	
	if(tokenArray.count == 0) {
		[self syntaxError:@"Unexpected EOF"];
	}
	
	NSString *token = [tokenArray objectAtIndex:0];
	[tokenArray removeObjectAtIndex:0];
	
	if ([token isEqualToString:@"("]) {
		
		NSMutableArray *list = [NSMutableArray array];
		
		while (![[tokenArray objectAtIndex:0] isEqualToString:@")"]) {
			[list addObject:[self readFromTokens:tokenArray]];
		}
		
		[tokenArray removeObjectAtIndex:0];
		
		return list;
		
	} else if ([token isEqualToString:@")"]) {
		[self syntaxError:@"unexpected ')'"];
	} else {
		return [self atom:token];
	}
	return nil;
}


- (id)readLisc {
	NSMutableArray *tokens = [NSMutableArray arrayWithArray:[self tokenize]];
	return [self readFromTokens:tokens];
}

- (id)eval:(LiscEnvironment *)env {
	return self;
}

- (NSString *)toString {
	return self;
}

- (BOOL)isEqualToExpression:(id)exp {
	if ([self isMemberOfClass:[exp class]]) {
		return [self isEqualToString:(NSString *)exp];
	} else {
		return NO;
	}
}

@end
