
#import "LiscMainTestSuite.h"

@interface LiscMainTestSuite()
- (void)configure;
@end

@implementation LiscMainTestSuite

- (id)init {
    if (self = [super init]) {
        [self configure];
    }
    
    return self;
}

+ (id)suite {
    return [[LiscMainTestSuite alloc] init];
}

- (void)configure {
    [self addTest:[LiscTest testWithInputString:@"(+ 1 2 3)" expectingResult:@"6"]];
    [self addTest:[LiscTest testWithInputString:@"(- 1 2 3)" expectingResult:@"-4"]];
    [self addTest:[LiscTest testWithInputString:@"(is 3 3)" expectingResult:@"true"]];
    [self addTest:[LiscTest testWithInputString:@"(is 123 \"gordon\")" expectingResult:@"false"]];
    [self addTest:[LiscTest testWithInputString:@"(is (1 2 3) (1 2 3))" expectingResult:@"true"]];
    [self addTest:[LiscTest testWithInputString:@"(is (1 2 3) (1 2 3 4 5))" expectingResult:@"false"]];
    [self addTest:[LiscTest testWithInputString:@"(first (\"foo\" \"bar\" \"baz\"))" expectingResult:@"\"foo\""]];
    [self addTest:[LiscTest testWithInputString:@"(last (\"foo\" \"bar\" \"baz\"))" expectingResult:@"\"baz\""]];
    [self addTest:[LiscTest testWithInputString:@"(rest (\"foo\" \"bar\" \"baz\"))" expectingResult:@"(\"bar\" \"baz\")"]];
    [self addTest:[LiscTest testWithInputString:@"(cons (\"foo\" \"bar\" \"baz\") 4000)" expectingResult:@"(\"foo\" \"bar\" \"baz\" 4000)"]];
    [self addTest:[LiscTest testWithInputString:@"(if (is 1 2) \"monkeys\" \"dragons\")" expectingResult:@"\"dragons\""]];
    [self addTest:[LiscTest testWithInputString:@"(if (rest (1)) (quote foo) (quote bar))" expectingResult:@"(quote bar)"]];
    [self addTest:[LiscTest testWithInputString:@"(if (rest (1 2 3 4 5)) (quote rad) (quote lame))" expectingResult:@"(quote rad)"]];
    [self addTest:[LiscTest testWithInputString:@"(define foo (lambda (x) (+ x 20))) (foo 20)" expectingResult:@"40"]];
    [self addTest:[LiscTest testWithInputString:@"(define foo 3) (set! foo \"muppets\") foo" expectingResult:@"\"muppets\""]];
}

@end
