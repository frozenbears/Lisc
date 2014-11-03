
#import "LiscMathModule.h"
#import "LiscCallBlock.h"
#import "LiscNumber.h"
#import "LiscError.h"
#import "LiscArgs.h"

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
    
    self.bindings[@"+"] = [LiscFunction functionWithBlock:add];
    self.bindings[@"-"] = [LiscFunction functionWithBlock:subtract];
}

@end