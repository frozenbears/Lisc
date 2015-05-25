#import <Foundation/Foundation.h>
#import "LiscEnvironment.h"
#import "LiscExpression.h"
#import "LiscFileInputPort.h"
#import "LiscStringInputPort.h"
#import "LiscEOF.h"
#import "LiscError.h"

int main (int argc, const char * argv[]) {

    @autoreleasepool {

        //our global environment
        LiscEnvironment *env = [LiscEnvironment environment];
        
        //a port for reading lisc expressions from stdin
        LiscFileInputPort *inport = [LiscFileInputPort portWithStdin];
        
        //so we don't need to use NSLog for writing to stdout
        //TODO: wrapping this in an output port would make it more convenient
        NSFileHandle *output = [NSFileHandle fileHandleWithStandardOutput];
            
        [output writeData:[@"Lisc v0.2 (c) 2012 Marc Sciglimpaglia or whatever" dataUsingEncoding:NSUTF8StringEncoding]];
        [output writeData:[@"\n" dataUsingEncoding:NSUTF8StringEncoding]];
        
        //this is how you make a REPL
        while (1) {
            @autoreleasepool {
                NSString *prompt = @"> ";
                [output writeData:[prompt dataUsingEncoding:NSUTF8StringEncoding]];
                @try {
                    LiscExpression *res = [[inport read] eval:env];
                    NSString *result = [res print];
                    //don't bother printing if the result is nil (which happens a lot)
                    if (![result isEqualToString:@"nil"]) {
                        [output writeData:[result dataUsingEncoding:NSUTF8StringEncoding]];
                        [output writeData:[@"\n" dataUsingEncoding:NSUTF8StringEncoding]];
                    }
                } @catch (NSException *e) {
                    if (![e isKindOfClass:[LiscError class]]) {
                        NSLog(@"%@", e.description);
                    } else {
                        @throw;
                    }

                    [output writeData:[e.description dataUsingEncoding:NSUTF8StringEncoding]];
                    [output writeData:[@"\n" dataUsingEncoding:NSUTF8StringEncoding]];
                }
            }
        }
    }

    return 0;
}
