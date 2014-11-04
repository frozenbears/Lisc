
#import <XCTest/XCTest.h>
#import "LiscEnvironment.h"
#import "LiscStringInputPort.h"
#import "LiscEOF.h"

@interface Lisc_Tests : XCTestCase
@property(nonatomic, strong) LiscEnvironment *environment;
@property(nonatomic, strong) LiscStringInputPort *inport;
@end

@implementation Lisc_Tests

- (void)setUp {
    [super setUp];
    self.environment = [LiscEnvironment environment];
    //self.inport = [LiscStringInputPort stringInputPortWithString:<#(NSString *)#>
}

- (void)eval:(NSString *)input expectingOutput:(NSString *)expectedOutput {
    LiscStringInputPort *inport = [LiscStringInputPort stringInputPortWithString:input];
    LiscStringInputPort *expectedPort = [LiscStringInputPort stringInputPortWithString:expectedOutput];
    LiscExpression *outputExpression;

    while (1) {
        LiscExpression *next = [[inport read] eval:self.environment];
        if ([next isKindOfClass:[LiscEOF class]]) {
            break;
        }
        outputExpression = next;
    }

    LiscExpression *expectedExpression = [[expectedPort read] eval:self.environment];

    BOOL passed = [outputExpression isEqualToExpression:expectedExpression];
    XCTAssertTrue(passed, @"%@ => %@, expecting %@", input, [outputExpression print], [expectedExpression print]);
}

- (void)testAdd {
    [self eval:@"(+ 1 2 3)" expectingOutput:@"6"];
}

- (void)testSubtract {
    [self eval:@"(- 1 2 3)" expectingOutput:@"-4"];
}

- (void)testIs {
    [self eval:@"(is 3 3)" expectingOutput:@"true"];
    [self eval:@"(is 123 \"gordon\")" expectingOutput:@"false"];
    [self eval:@"(is (1 2 3) (1 2 3))" expectingOutput:@"true"];
    [self eval:@"(is (1 2 3) (1 2 3))" expectingOutput:@"true"];
    [self eval:@"(is (1 2 3) (1 2 3 4 5))" expectingOutput:@"false"];
}

- (void)testFirst {
    [self eval:@"(first (\"foo\" \"bar\" \"baz\"))" expectingOutput:@"\"foo\""];
}

- (void)testLast {
    [self eval:@"(last (\"foo\" \"bar\" \"baz\"))" expectingOutput:@"\"baz\""];
}

- (void)testRest {
    [self eval:@"(rest (\"foo\" \"bar\" \"baz\"))" expectingOutput:@"(\"bar\" \"baz\")"];
}

- (void)testCons {
    [self eval:@"(cons (\"foo\" \"bar\" \"baz\") 4000)" expectingOutput:@"(\"foo\" \"bar\" \"baz\" 4000)"];
}

- (void)testIf {
    [self eval:@"(if (is 1 2) \"monkeys\" \"dragons\")" expectingOutput:@"\"dragons\""];
    [self eval:@"(if (rest (1)) (quote foo) (quote bar))" expectingOutput:@"(quote bar)"];
    [self eval:@"(if (rest (1 2 3 4 5)) (quote rad) (quote lame))" expectingOutput:@"(quote rad)"];
}

- (void)testDefine {
    [self eval:@"(define foo (lambda (x) (+ x 20))) (foo 20)" expectingOutput:@"40"];
    [self eval:@"(define foo 3) (set! foo \"muppets\") foo" expectingOutput:@"\"muppets\""];
}

- (void)tearDown {

    [super tearDown];
}

- (void)testExample {
}

@end
