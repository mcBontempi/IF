#import <Foundation/Foundation.h>

@interface Program : NSObject

@property (nonatomic, strong) NSArray *lines;

@property (nonatomic, assign, readonly) NSUInteger numLines;

@end
