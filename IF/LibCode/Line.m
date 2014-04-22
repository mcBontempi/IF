#import "Line.h"

@implementation Line {
  NSString *_string;
}

- (instancetype)initWithString:(NSString *)string
{
  if (self = [super init]) {
    _string = string;
  }
  return self;
}

- (NSString *)opcode
{
  if (!_opcode) {
    [self parse];
  }
  return _opcode;
}

- (NSString *)value
{
  if (!_value) {
    [self parse];
  }
  return _value;
}

- (void)parse
{
  NSArray *array = [_string componentsSeparatedByString:@" "];
  _opcode = array[0];
  if (array.count>1) {
    _value = array[1];
  }
}

- (NSString *)debugDescription
{
  return [NSString stringWithFormat:@"%@ %@\n",self.opcode, self.value ? self.value : @""];
}

@end
