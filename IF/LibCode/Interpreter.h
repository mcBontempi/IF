#import <Foundation/Foundation.h>

@class Program;
@protocol MemoryWritable;
@protocol Registers;

@interface Interpreter : NSObject

- (BOOL)hasNotFinished;

- (instancetype)initWithProgram:(Program *)program memory:(id<MemoryWritable>)memory registers:(id<Registers>) registers;

- (NSInteger)run;

- (NSInteger)runNextLine;



@end
