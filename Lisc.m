#import <Foundation/Foundation.h>
#import "LiscTest.h"
#import "LiscEnvironment.h"
#import "LiscExpression.h"
#import "LiscFileInputPort.h"

int main (int argc, const char * argv[]) {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	
	LiscEnvironment *env = [LiscEnvironment globalEnvironment];
	
	LiscFileInputPort *inport = [LiscFileInputPort portWithStdin];
	NSFileHandle *output = [NSFileHandle fileHandleWithStandardOutput];
	
	[output writeData:[@"Lisc v0.11 (c) 2012 Marc Sciglimpaglia or whatever" dataUsingEncoding:NSUTF8StringEncoding]];
	[output writeData:[@"\n" dataUsingEncoding:NSUTF8StringEncoding]];
	
	while (1) {
		NSString *prompt = @"> ";
		[output writeData:[prompt dataUsingEncoding:NSUTF8StringEncoding]];
		NSString *result = [[[inport read] eval:env] toString];
		if (![result isEqualToString:@"nil"]) {
			[output writeData:[result dataUsingEncoding:NSUTF8StringEncoding]];
			[output writeData:[@"\n" dataUsingEncoding:NSUTF8StringEncoding]];
		}
	}
	
    [pool drain];
    return 0;
}
