#import <Foundation/Foundation.h>
#import "Registers.h"

@interface StandardRegisters : NSObject <Registers>

@property (nonatomic) NSUInteger programCounter;
@property (nonatomic) NSInteger accumulator;

+ (instancetype)standardRegisters;

@end
