#import <Foundation/Foundation.h>

@protocol MemoryWritable <NSObject>

- (void)writeToAddress:(NSUInteger)address withValue:(NSInteger)value;

@end
