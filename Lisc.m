#import <Foundation/Foundation.h>
#import "LiscMainTestSuite.h"
#import "LiscEnvironment.h"
#import "LiscExpression.h"
#import "LiscFileInputPort.h"
#import "LiscEOF.h"
#import "liscError.h"

int main (int argc, const char * argv[]) {
    @autoreleasepool {
        //uncomment for testing joy
        //TODO: set up an additional target and/or command line flag?
        LiscMainTestSuite *suite = [LiscMainTestSuite suite];
        [suite run];

        //our global environment
        LiscEnvironment *env = [LiscEnvironment globalEnvironment];
        
        //a port for reading lisc expressions from stdin
        LiscFileInputPort *inport = [LiscFileInputPort portWithStdin];
        
        //so we don't need to use NSLog for writing to stdout
        //TODO: wrapping this in an output port would make it more convenient
        NSFileHandle *output = [NSFileHandle fileHandleWithStandardOutput];
            
        [output writeData:[@"Lisc v0.2 (c) 2012 Marc Sciglimpaglia or whatever" dataUsingEncoding:NSUTF8StringEncoding]];
        [output writeData:[@"\n" dataUsingEncoding:NSUTF8StringEncoding]];
        
        //this is how you make a REPL
        while (1) {
            NSString *prompt = @"> ";
            [output writeData:[prompt dataUsingEncoding:NSUTF8StringEncoding]];
            @try {
                NSString *result = [[[inport read] eval:env] print];
                //don't bother printing if the result is nil (which happens a lot)
                if (![result isEqualToString:@"nil"]) {
                    [output writeData:[result dataUsingEncoding:NSUTF8StringEncoding]];
                    [output writeData:[@"\n" dataUsingEncoding:NSUTF8StringEncoding]];
                }
            } @catch (NSException *e) {
                if (![e isKindOfClass:[LiscError class]]) {
                    @throw;
                }

                [output writeData:[e.description dataUsingEncoding:NSUTF8StringEncoding]];
                [output writeData:[@"\n" dataUsingEncoding:NSUTF8StringEncoding]];
            }
        }
    }
    return 0;
}
