
#import "LiscFileInputPort.h"
#import "NSFileHandle+ReadLine.h"
#import "LiscEOF.h"

@implementation LiscFileInputPort

@synthesize handle;

- (id)initWithFile:(NSString *)path {
	if (self = [super init]) {
		self.handle = [NSFileHandle fileHandleForReadingAtPath:path];
	}
	
	return self;
}

- (id)initWithStdin {
	if (self = [super init]) {
		self.handle = [NSFileHandle fileHandleWithStandardInput];
	}
	
	return self;
}

+ (LiscFileInputPort *)portWithFile:(NSString *)path {
	return [[[LiscFileInputPort alloc] initWithFile:path] autorelease];
}

+ (LiscFileInputPort *)portWithStdin {
	return [[[LiscFileInputPort alloc] initWithStdin] autorelease];
}

- (id)readLine {
	NSString *line = [handle readLine];
	if (!line || !line.length) return [LiscEOF eof];
	return line;
}

- (void)dealloc {
	self.handle = nil;
	[super dealloc];
}

@end
