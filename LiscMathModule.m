
#import "LiscMathModule.h"
#import "LiscCallBlock.h"
#import "LiscNumber.h"
#import "LiscError.h"
#import "LiscArgs.h"
#import "LiscBoolean.h"

@implementation LiscMathModule

- (void)setupBindings {
    
    LiscCallBlock add = ^(NSArray *args) {
        double sum;
        BOOL first = YES;
        
        [LiscArgs checkArgs:args 
                  expecting:@[[LiscNumber class], [LiscNumber class]]
                   variadic:YES];
        
        for (LiscNumber *n in args) {
            if (first) {
                sum = [n.number doubleValue];
                first = NO;
            } else {
                sum += [((LiscNumber *)n).number doubleValue];
            }
        }
                
        return (id)[LiscNumber numberWithNumber:@(sum)]; 
    };
    
    LiscCallBlock subtract = ^(NSArray *args) {
        double difference;
        BOOL first = YES;
        
        [LiscArgs checkArgs:args 
                  expecting:@[[LiscNumber class], [LiscNumber class]]
                   variadic:YES];
        
        for (LiscNumber *n in args) {
            if (first) {
                difference = [n.number doubleValue];
                first = NO;
            } else {
                difference -= [((LiscNumber *)n).number doubleValue];
            }           
        }       
        return (id)[LiscNumber numberWithNumber:@(difference)]; 
    };

    LiscCallBlock lessThan = ^(NSArray *args) {
        [LiscArgs checkArgs:args expecting:@[[LiscNumber class], [LiscNumber class]]];
        LiscNumber *first = [args objectAtIndex:0];
        LiscNumber *second = [args objectAtIndex:1];
        BOOL b = first.number.doubleValue < second.number.doubleValue;
        return (id)[LiscBoolean booleanWithValue:b];
    };
    
    self.bindings[@"+"] = [LiscFunction functionWithBlock:add];
    self.bindings[@"-"] = [LiscFunction functionWithBlock:subtract];
    self.bindings[@"<"] = [LiscFunction functionWithBlock:lessThan];
}

@end