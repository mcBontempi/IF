#import <Foundation/Foundation.h>

@class Program;

@interface Tokeniser : NSObject

- (Program *)tokenise:(NSString *)string;

@end
