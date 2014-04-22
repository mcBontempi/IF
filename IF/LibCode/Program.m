#import "Program.h"
#import "Line.h"

@implementation Program 

- (NSUInteger)numLines
{
  return self.lines.count;
}

- (NSString *)debugDescription
{
  __block NSMutableString *mutableString = [@"" mutableCopy];
  
  [self.lines enumerateObjectsUsingBlock:^(Line *line, NSUInteger idx, BOOL *stop) {
    
    [mutableString appendString:line.debugDescription];
    
  }];
  
  return [mutableString copy];
}


@end
