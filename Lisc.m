#import <Foundation/Foundation.h>
#import "LiscTest.h"

int main (int argc, const char * argv[]) {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	
    NSLog(@"LISC :D :D :D\n\n");
	
	LiscTest *test = [LiscTest new];
	[test run];
	
	
    
    [pool drain];
    return 0;
}
