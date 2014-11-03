
#import "NSFileHandle+Readline.h"
#import "NSData+Extensions.h"

//category implementation gratefully borrowed from:
//http://stackoverflow.com/questions/3707427/how-to-read-data-from-nsfilehandle-line-by-line

@implementation NSFileHandle(Readline)

- (NSString*)readLine {
    
    NSString * _lineDelimiter = @"\n";
    
    NSData* newLineData = [_lineDelimiter dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableData* currentData = [[NSMutableData alloc] init];
    BOOL shouldReadMore = YES;
    
    NSUInteger _chunkSize = 1;
    
    while (shouldReadMore) {
        NSData* chunk = [self readDataOfLength:_chunkSize]; // always length = 10
        
        if ([chunk length] == 0) {
            break;
        }
        
        // Find the location and length of the next line delimiter.
        NSRange newLineRange = [chunk rangeOfData:newLineData];
        if (newLineRange.location != NSNotFound) {
            // Include the length so we can include the delimiter in the string.
            NSRange subDataRange = NSMakeRange(0, newLineRange.location + [newLineData length]);
            unsigned long long newOffset = [self offsetInFile] - [chunk length] + newLineRange.location + [newLineData length];
            [self seekToFileOffset:newOffset];
            chunk = [chunk subdataWithRange:subDataRange];
            shouldReadMore = NO;
        }
        [currentData appendData:chunk];
    }
    
    NSString* line = [currentData stringValueWithEncoding:NSASCIIStringEncoding];
    return line;
}

- (NSString*)readLineBackwards {
    
    NSString * _lineDelimiter = @"\n";
    
    NSData* newLineData = [_lineDelimiter dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger _chunkSize = 10;
    
    NSMutableData* currentData = [[NSMutableData alloc] init];
    BOOL shouldReadMore = YES;
    
    while (shouldReadMore) {
        
        unsigned long long offset;
        
        NSUInteger currentChunkSize = _chunkSize;
        
        if ([self offsetInFile] <= _chunkSize) {
            offset = 0;
            currentChunkSize = [self offsetInFile];
            shouldReadMore = NO;
        } else {
            offset = [self offsetInFile] - _chunkSize;
        }
        
        //NSLog(@"seek to offset %qu, offset in file is %qu", offset, [self offsetInFile]);
        
        [self seekToFileOffset:offset];
        
        NSData* chunk = [self readDataOfLength:currentChunkSize];
        
        NSRange newLineRange = [chunk rangeOfDataBackwardsSearch:newLineData];
        
        if (newLineRange.location == NSNotFound) {
            [self seekToFileOffset:offset];
        }
        
        if (newLineRange.location != NSNotFound) {
            NSUInteger subDataLoc = newLineRange.location;
            NSUInteger subDataLen = currentChunkSize - subDataLoc;
            chunk = [chunk subdataWithRange:NSMakeRange(subDataLoc, subDataLen)];
            NSLog(@"got chunk data %@", [chunk stringValueWithEncoding:NSASCIIStringEncoding]);
            shouldReadMore = NO;
            [self seekToFileOffset:offset + newLineRange.location];
        }
        [currentData prepend:chunk];
    }
    
    NSString* line = [[NSString alloc] initWithData:currentData encoding:NSASCIIStringEncoding];
    return line;
}

@end