
#import "LiscStringInputPort.h"
#import "LiscEOF.h"

@implementation LiscStringInputPort

@synthesize lines;

- (id)initWithString:(NSString *)inputString {
	if (self = [super init]) {
		self.lines = [NSMutableArray arrayWithArray:[inputString componentsSeparatedByCharactersInSet:
					  [NSCharacterSet newlineCharacterSet]]];
	}
	
	return self;
}

- (id)readLine {
	if (lines.count) {
		NSString *line = lines[0];
		[lines removeObjectAtIndex:0];
		return line;
	} else {
		return [LiscEOF eof];
	}
}


@end
