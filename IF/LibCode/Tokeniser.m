#import "Tokeniser.h"
#import "Program.h"
#import "Line.h"

@implementation Tokeniser

- (Program *)tokenise:(NSString *)string
{
  if (string == nil || !string.length) {
    return nil;
  }
  
  // dont allow more than 1 space
  NSRange range = [string rangeOfString : @"  "];
  if (range.location != NSNotFound ) {
    assert(0);
  }
  
  NSArray *stringArray = [[string uppercaseString] componentsSeparatedByString:@"\n"];
  
  __block NSMutableArray *lineArray = [[NSMutableArray alloc] init];
  
  [stringArray enumerateObjectsUsingBlock:^(NSString *string, NSUInteger idx, BOOL *stop) {
    [lineArray addObject: [[Line alloc] initWithString:string]];
  }];
  
  Program *program = [[Program alloc] init];
  
  program.lines = [lineArray copy];
  
  return program;
}

@end
