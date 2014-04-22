#import "Interpreter.h"
#import "Program.h"
#import "Line.h"
#import "MemoryWritable.h"
#import "MemoryReadable.h"

@implementation Interpreter {
  NSInteger _accumulator;
  NSUInteger _programCounter;
  
  id<MemoryWritable, MemoryReadable> _memory;
  Program *_program;
}

#pragma mark - memory

- (instancetype)initWithProgram:(Program *)program memory:(id<MemoryWritable, MemoryReadable>)memory
{
  if (self = [super init]) {
    _program = program;
    _memory = memory;
  }
  return self;
}



#pragma makr - opcodes

- (void)SET:(NSString *)value
{
  _accumulator = value.integerValue;
}

- (void)WRITE:(NSString *)address
{
  [_memory writeToAddress:address.integerValue withValue:_accumulator];
}

- (void)WRITEINDIRECT:(NSString *)addressOfAddress
{
  [_memory writeToAddress:[_memory readFromAddress:addressOfAddress.integerValue] withValue:_accumulator];
}

- (void)READ:(NSString *)address
{
  _accumulator = [_memory readFromAddress:address.integerValue];
}

- (void)PRINT
{
  NSLog(@"-- DEBUG OUTPUT : ASCII = %c : DECIMAL = %lu --", (int)_accumulator, (unsigned long)_accumulator);
}

- (void)IF:(NSString *)label
{
  if (_accumulator) {
    // first find the pc of the label we need to jump to
    for (NSUInteger i = 0 ; i < _program.numLines ; i++) {
      
      NSString *scannedOpcode = [_program.lines[i] opcode];
      
      // have we found a label that matches?
      if ([label isEqualToString:scannedOpcode]) {
        _programCounter = i;
        return;
      }
    }
    assert(0);
  }
}

- (void)ADD:(NSString *)value
{
  _accumulator += value.integerValue;
}

#pragma mark - interpreter

- (BOOL)hasNotFinished
{
  return _programCounter < _program.numLines;
}

- (NSInteger)run
{
  NSUInteger retVal = 0;
  
  while (_programCounter < _program.numLines) {
    retVal = [self runNextLine];
  }
  
  return retVal;
}

- (NSInteger)runNextLine
{ 
    // this really is it, im using strings....
    // Why not though, makes debugging (in the developent of IF) easier
    
    Line *currentLine = _program.lines[_programCounter];
  
    NSString *opcode = currentLine.opcode;
    NSString *value = currentLine.value;
    
    
    if ([opcode isEqualToString:@"SET"]) {
      [self SET:value];
    }
    else if ([opcode isEqualToString:@"WRITE"]) {
      [self WRITE:value];
    }
    else if ([opcode isEqualToString:@"WRITEINDRECT"]) {
      [self WRITEINDIRECT:value];
    }
    else if ([opcode isEqualToString:@"READ"]) {
      [self READ:value];
    }
    else if ([opcode isEqualToString:@"PRINT"]) {
      [self PRINT];
    }
    else if ([opcode isEqualToString:@"ADD"]) {
      [self ADD:value];
    }
    else if ([opcode isEqualToString:@"IF"]) {
      [self IF:value];
    }
    else if ([[opcode substringWithRange:NSMakeRange(opcode.length-1,1)] isEqualToString:@":"]) {
      // we dont need to do anything if the opcode is a label
      // this saves us reportign an error
    }
    else {
      assert(0);
    }
    
    _programCounter++;
  
  return _accumulator;
}

@end
