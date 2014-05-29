#import "Interpreter.h"
#import "Program.h"
#import "Line.h"
#import "MemoryWritable.h"
#import "MemoryReadable.h"
#import "Registers.h"

@implementation Interpreter {
  id<MemoryWritable, MemoryReadable> _memory;
  Program *_program;
  id<Registers> _registers;
}

#pragma mark - memory

- (instancetype)initWithProgram:(Program *)program memory:(id<MemoryWritable, MemoryReadable>)memory registers:(id<Registers>)registers
{
  if (self = [super init]) {
    _program = program;
    _memory = memory;
    _registers = registers;
  }
  return self;
}

#pragma makr - opcodes

- (void)SET:(NSString *)value
{
  _registers.accumulator = value.integerValue;
}

- (void)WRITE:(NSString *)address
{
  [_memory writeToAddress:address.integerValue withValue:_registers.accumulator];
}

- (void)WRITEINDIRECT:(NSString *)addressOfAddress
{
  [_memory writeToAddress:[_memory readFromAddress:addressOfAddress.integerValue] withValue:_registers.accumulator];
}

- (void)READINDIRECT:(NSString *)addressOfAddress
{
  _registers.accumulator = [_memory readFromAddress:[_memory readFromAddress:addressOfAddress.integerValue]];
}

- (void)READ:(NSString *)address
{
  _registers.accumulator = [_memory readFromAddress:address.integerValue];
}

- (void)PRINT
{
  NSLog(@"-- DEBUG OUTPUT : ASCII = %c : DECIMAL = %lu --", (int)_registers.accumulator, (unsigned long)_registers.accumulator);
}

- (void)IF:(NSString *)label
{
  if (_registers.accumulator) {
    // first find the pc of the label we need to jump to
    for (NSUInteger i = 0 ; i < _program.numLines ; i++) {
      
      NSString *scannedOpcode = [_program.lines[i] opcode];
      
      // have we found a label that matches?
      if ([label isEqualToString:scannedOpcode]) {
        _registers.programCounter = i;
        return;
      }
    }
    assert(0);
  }
}

- (void)ADD:(NSString *)value
{
  _registers.accumulator += value.integerValue;
}

#pragma mark - interpreter

- (BOOL)hasNotFinished
{
  return _registers.programCounter < _program.numLines;
}

- (NSInteger)run
{
  NSUInteger retVal = 0;
  
  while (_registers.programCounter < _program.numLines) {
    retVal = [self runNextLine];
  }
  
  return retVal;
}

- (NSInteger)runNextLine
{ 
    // this really is it, im using strings....
    // Why not though, makes debugging (in the developent of IF) easier
    
    Line *currentLine = _program.lines[_registers.programCounter];
  
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
    else if ([opcode isEqualToString:@"READINDRECT"]) {
      [self READINDIRECT:value];
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
    
    _registers.programCounter++;
  
  return _registers.accumulator;
}

@end
