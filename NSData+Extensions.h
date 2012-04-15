
/**
 Extension of the NSData class. 
 Data can be found forwards or backwards. Further the extension supplies a function 
 to convert the contents to string for debugging purposes.
 @param Additions Category labeled Additions.
 @returns An initialized NSData object or nil if the object could not be created.
 */
@interface NSData (Additions)

- (NSRange)rangeOfData:(NSData*)dataToFind;
- (NSRange)rangeOfDataBackwardsSearch:(NSData*)dataToFind;
- (NSString*)stringValueWithEncoding:(NSStringEncoding)encoding;

@end

/**
 Extension of the NSMutableData class. 
 Data can be prepended in addition to the append function of the framework.
 @param Additions Category labeled Additions.
 @returns An initialized NSMutableData object or nil if the object could not be created.
 */
@interface NSMutableData (Additions)

- (void)prepend:(NSData*)data;

@end