#import <Foundation/Foundation.h>

@class Program;
@protocol MemoryWritable;

@interface Interpreter : NSObject

- (BOOL)hasNotFinished;

- (instancetype)initWithProgram:(Program *)program memory:(id<MemoryWritable>)memory;

- (NSInteger)run;

- (NSInteger)runNextLine;

@end
