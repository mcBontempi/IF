#import <Foundation/Foundation.h>
#import "MemoryWritable.h"
#import "MemoryReadable.h"

@interface ComputerMemory : NSObject <MemoryWritable, MemoryReadable>

- (instancetype)init;

- (instancetype)initWithCapacity:(NSUInteger)capacity delegate:(id<MemoryWritable>) delegate;

- (void)writeToAddress:(NSUInteger)address withValue:(NSInteger)value;

- (NSInteger)readFromAddress:(NSUInteger)address;

@end
