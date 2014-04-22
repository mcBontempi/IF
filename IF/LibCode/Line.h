#import <Foundation/Foundation.h>

@interface Line : NSObject

@property (nonatomic, strong) NSString *opcode;
@property (nonatomic, strong) NSString *value;

- (instancetype)initWithString:(NSString *)string;
- (NSString *)debugDescription;

@end
