
#import "LiscInputPort.h"
#import "LiscEOF.h"
#import "LiscBoolean.h"
#import "LiscNumber.h"
#import "LiscString.h"
#import "LiscSymbol.h"
#import "LiscNil.h"
#import "LiscList.h"
#import "LiscError.h"

#define TOKENIZER @"\\s*(,@|[('`,)]|\"(?:[\\\\].|[^\\\\\"])*\"|;.*|[^\\s('\"`,;)]*)(.*)"

@implementation LiscInputPort

//input streaming

- (id)init {
    if (self = [super init]) {
        self.lineBuffer = @"";
        self.tokenizer = [NSRegularExpression regularExpressionWithPattern:TOKENIZER options:0 error:NULL];
    }
    
    return self;
}

- (LiscExpression *)atomFromToken:(NSString *)token {
    
    NSNumberFormatter *f = [NSNumberFormatter new];
    NSNumber *number = [f numberFromString:token];
    
    //number
    if (number) {
        return [LiscNumber numberWithNumber:number];
    }
    
    //string
    else if ([token hasPrefix:@"\""]) {
        //return the string without the surrounding quotes
        return [LiscString stringWithString:[token substringWithRange:NSMakeRange(1, [token length]-2)]];
    }
    
    //true
    else if ([token isEqualToString:@"true"]) {
        return [LiscBoolean t];
    }
    
    //false
    else if ([token isEqualToString:@"false"]) {
        return [LiscBoolean f];
    }
    
    
    //nil
    else if ([token isEqualToString:@"nil"]) {
        return [LiscNil _nil];
    }
    
    //symbol
    return [[LiscSymbol alloc] initWithString:token];
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
        
        if ([self.lineBuffer isEqual:@""]) {
            self.lineBuffer = [self readLine];
        }

        if ([self.lineBuffer isMemberOfClass:[LiscEOF class]]) {
            return self.lineBuffer;
        }

        NSTextCheckingResult *match = [self.tokenizer firstMatchInString:self.lineBuffer
                                                                 options:0
                                                                   range:NSMakeRange(0, [self.lineBuffer length])];

        token = [self.lineBuffer substringWithRange:[match rangeAtIndex:1]];
        self.lineBuffer = [self.lineBuffer substringWithRange:[match rangeAtIndex:2]];
        
        //if we got a token and it's not a comment or blank, return it
        if (token && ![token hasPrefix:@";"] &&![token isEqualToString:@""]) {
            return token;
        }       
    }
}

- (id)readAhead:(id)token {
    if ([token isEqualToString:@"("]) {
        NSMutableArray *listArray = [NSMutableArray array];
        
        while (1) {
            token = [self nextToken];
            if ([token isEqualToString:@")"]) {
                return [LiscList listWithArray:listArray];
            } else {
                [listArray addObject:[self readAhead:token]];
            }
        }
    } 
    
    else if ([token isEqualToString:@")"]) {
        [LiscError raiseSyntaxError:@"unexpected \")\""];
    }
    
    else if ([token isKindOfClass:[LiscEOF class]]) {
        [LiscError raiseSyntaxError:@"unexpected EOF"];
    }
    
    else {
        return [self atomFromToken:token];
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
