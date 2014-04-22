#import <Foundation/Foundation.h>

@protocol MemoryReadable <NSObject>

- (NSInteger)readFromAddress:(NSUInteger)address;

@end
