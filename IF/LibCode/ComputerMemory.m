#import "ComputerMemory.h"

@interface ComputerMemory ()

@property (nonatomic, strong) NSMutableArray *memory;

@end

@implementation ComputerMemory {
    NSUInteger _capacity;
    id<MemoryWritable> _delegate;
}

- (instancetype)init
{
  assert(0);
  return nil;
}

- (instancetype)initWithCapacity:(NSUInteger)capacity delegate:(id<MemoryWritable>) delegate
{
    if (self = [super init]) {
        _delegate = delegate;
        _capacity = capacity;
    }
    
    return self;
}

- (NSMutableArray*) memory
{
    if (!_memory) {
        _memory = [@[] mutableCopy];
        
        for (NSUInteger i = 0 ; i < _capacity ; i++ ) {
            _memory[i] = [NSNumber numberWithInteger:0];
        }
    }
    
    return _memory;
}

- (void)writeToAddress:(NSUInteger)address withValue:(NSInteger)value
{
    [_delegate writeToAddress:address withValue:value];
    
    self.memory[address] = [NSNumber numberWithInteger:value];
    
}

- (NSInteger)readFromAddress:(NSUInteger)address
{
  NSLog(@"%d", address);
  
    return [self.memory[address] integerValue];
}

@end
