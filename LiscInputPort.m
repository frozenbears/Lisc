
#import "LiscInputPort.h"
#import "LiscEOF.h"
#import "LiscNil.h"
#import "NSString+Lisc.h"
#import "RegexKitLite.h"


#define TOKENIZER @"\\s*(,@|[('`,)]|\"(?:[\\\\].|[^\\\\\"])*\"|;.*|[^\\s('\"`,;)]*)(.*)"

@implementation LiscInputPort

@synthesize lineBuffer;

- (void)syntaxError:(NSString *)message {
	@throw [NSException exceptionWithName:@"SyntaxError"
								   reason:message  userInfo:nil];
}

//input streaming

- (id)init {
	if (self = [super init]) {
		self.lineBuffer = @"";
	}
	
	return self;
}

- (void)dealloc {
	self.lineBuffer = nil;
	[super dealloc];
}

- (id)readLine {
	return [LiscEOF eof];
}

- (id)readString{
	NSString *string;
	id line;
	
	line = [self readLine];
	
	while (![line isMemberOfClass:[LiscEOF class]]) {		
		string = [string stringByAppendingString:line];
		line = [self readLine];
	}
	
	return line;
}

//tokenization and parsing

- (id)nextToken {
	id token;
	
	while(1) {
		
		if ([lineBuffer isEqual:@""]) {
			self.lineBuffer = [self readLine];
		}

		if ([lineBuffer isMemberOfClass:[LiscEOF class]]) {
			return lineBuffer;
		}

		//match token and the rest of the line into token, lineBuffer
		token = [lineBuffer stringByMatching:TOKENIZER capture:1L];
		self.lineBuffer = [lineBuffer stringByMatching:TOKENIZER capture:2L];
		
		//if we got a token and it's not a comment or blank, return it
		if (token && ![token hasPrefix:@";"] &&![token isEqualToString:@""]) {
			return token;
		}		
	}
}

- (id)readAhead:(id)token {
	if ([token isEqualToString:@"("]) {
		NSMutableArray *list = [NSMutableArray array];
		
		while (1) {
			token = [self nextToken];
			if ([token isEqualToString:@")"]) {
				return list;
			} else {
				[list addObject:[self readAhead:token]];
			}
		}
	} 
	
	else if ([token isEqualToString:@")"]) {
		[self syntaxError:@"unexpected \")\""];
	}
	
	else if ([token isKindOfClass:[LiscEOF class]]) {
		[self syntaxError:@"unexpected EOF"];
	}
	
	else {
		return [token atom];
	}
	
	return nil;
}

- (id)read {
	id token =[self nextToken];
	if ([token isKindOfClass:[LiscEOF class]]) {
		return token;
	} 
	
	else {
		return [self readAhead:token];
	}
}

@end
