
#import "NSString+Lisc.h"
#import "LiscSymbol.h"
#import "LiscNil.h"
#import "RegexKitLite.h"


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

- (id)atom {
	NSNumberFormatter *f = [NSNumberFormatter new];
	NSNumber *number = [f numberFromString:self];
	[f release];
	
	//number
	if (number) {
		return number;
	}
	
	//string
	else if ([self hasPrefix:@"\""]) {
		//return the string without the surrounding quotes
		return [self substringWithRange:NSMakeRange(1, [self length]-2)];
	}
	
	//symbol
	else {
		return [[[LiscSymbol alloc] initWithString:self] autorelease];
	}	
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
		return [token atom];
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
	NSString *output = @"\"";
	output = [output stringByAppendingString:self];
	output = [output stringByAppendingString:@"\""];
	return output;
}

- (BOOL)isEqualToExpression:(id)exp {
	if ([self isMemberOfClass:[exp class]]) {
		return [self isEqualToString:(NSString *)exp];
	} else {
		return NO;
	}
}

@end
