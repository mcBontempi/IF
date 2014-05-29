#import <Foundation/Foundation.h>

@protocol Registers <NSObject>

- (void)setProgramCounter:(NSUInteger)programCounter;
- (NSUInteger)programCounter;

- (void)setAccumulator:(NSInteger)accumulator;
- (NSInteger)accumulator;

@end
