
#import "LiscStringInputPort.h"
#import "LiscEOF.h"

@implementation LiscStringInputPort

- (id)initWithString:(NSString *)inputString {
    if (self = [super init]) {
        self.lines = [NSMutableArray arrayWithArray:[inputString componentsSeparatedByCharactersInSet:
                      [NSCharacterSet newlineCharacterSet]]];
    }
    
    return self;
}

- (id)readLine {
    if (self.lines.count) {
        NSString *line = self.lines[0];
        [self.lines removeObjectAtIndex:0];
        return line;
    } else {
        return [LiscEOF eof];
    }
}


@end
