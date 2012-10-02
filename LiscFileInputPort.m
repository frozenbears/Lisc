
#import "LiscFileInputPort.h"
#import "NSFileHandle+ReadLine.h"

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
	return [handle readLine];
}

- (void)dealloc {
	self.handle = nil;
	[super dealloc];
}

@end
