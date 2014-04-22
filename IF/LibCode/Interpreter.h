#import <Foundation/Foundation.h>

@class Program;
@protocol MemoryWritable;

@interface Interpreter : NSObject

- (instancetype)initWithProgram:(Program *)program memory:(id<MemoryWritable>)memory;

- (NSInteger)run;

@end
