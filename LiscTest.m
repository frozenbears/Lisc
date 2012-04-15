
#import "LiscTest.h"
#import "LiscEnvironment.h"
#import "LiscExpression.h"
#import "NSString+Lisc.h"

@implementation LiscTest

- (void)run {
    	    
	NSArray *tests = [NSArray arrayWithObjects:@"(+ (+ 5 6 7) 1 2 3)",
					  @"(- 112 35)",
					  @"(define foo (lambda (x) (+ x 20)))",
					  @"(foo 100)",
					  @"(is 3 3)",
					  @"(is (1 2 3) (1 2 3))",
					  @"(is (1 2 3) (2 3 4 5))",
					  @"(is 3 12)",
					  @"(if (is 3 12) (+ 5 10) (+ 100 300))",
					  @"(is (quote foo) (quote bar))",
					  @"(define blah (lambda (x y) (if (is x y) (quote foo) (quote bar))))",
					  @"(blah 10 20)",
					  @"(blah 1523 1523)",
					  @"(print (quote foo))",
					  @"(do (print 3) (print (quote three!!)) (print 33333 3 (1 2 3) (quote hobo)))",
					  @"(print (quote the-secret-of-life:) (+ 155.88 87.77 18.2))",
					  @"(define num 3)",
					  @"(define mutate (lambda (new) (set! num new)))",
					  @"(mutate 211)",
					  @"(print num)",
					  @"(set! num 111)",
					  @"(print num)",
					  @"(first (1 2 3 4 5))",
					  @"(rest (1 2 3 4 5))",
					  @"(cons (1 2 3 4 5) 6)",
					  nil];
	
	LiscEnvironment *env = [LiscEnvironment globalEnvironment];
	
	for (NSString *test in tests) {
		NSLog(@">> %@", test);
		
		NSString *result = [[[test readLisc] eval:env] toString];
		if (![result isEqualToString:@"nil"]) {
			NSLog(@"%@", result);
		}
		
	}
    
}

@end
