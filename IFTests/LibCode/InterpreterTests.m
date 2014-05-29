#import <XCTest/XCTest.h>
#import "Tokeniser.h"
#import "Interpreter.h"
#import "Program.h"
#import "ComputerMemory.h"
#import <OCMock/OCMock.h>
#import "StandardRegisters.h"

@interface InterpreterTests : XCTestCase

@end

@implementation InterpreterTests

- (void)testInterpreterEndsWithNoLines
{
  Tokeniser *tokeniser = [[Tokeniser alloc] init];
  
  NSString *rawCode = @"";
  
  Program *program = [tokeniser tokenise:rawCode];
  
  ComputerMemory *computerMemory = [[ComputerMemory alloc] initWithCapacity:1000 delegate:nil];
  
  Interpreter *interpreter = [[Interpreter alloc] initWithProgram:program memory:computerMemory registers:[StandardRegisters standardRegisters]];
  
  NSUInteger retVal = [interpreter run];
  
  XCTAssertEqual(retVal, 0, @"program should complete and return 0");
}

- (void)testSETSetsAccumulator
{
  Tokeniser *tokeniser = [[Tokeniser alloc] init];
  
  NSString *rawCode = @"SET 100";
  
  Program *program = [tokeniser tokenise:rawCode];
 
  ComputerMemory *computerMemory = [[ComputerMemory alloc] initWithCapacity:1000 delegate:nil];
  
  Interpreter *interpreter = [[Interpreter alloc] initWithProgram:program memory:computerMemory registers:[StandardRegisters standardRegisters]];
  
  NSUInteger retVal = [interpreter run];
  
  XCTAssertEqual(retVal, 100, @"program should complete and return 100");
}

- (void)testWRITEINDIRECTWritesIndirectly
{
  Tokeniser *tokeniser = [[Tokeniser alloc] init];
  
  NSString *rawCode = @""
  
  // we should write 100 out to memory locations 1000 & 1001
  
  // start at memory location 0
  "SET 1000\n"
  "WRITE 0\n"
  "LOOP:\n"
  
  // set 100 at memory location ponted to by 0
  "SET 100\n"
  "WRITEINDRECT 0\n"
  
  // increase the pointer
  "READ 0\n"
  "ADD 1\n"
  "WRITE 0\n"
  
  // Only do 3 iterations
  "ADD -1002\n"
  "IF LOOP:";
  
  Program *program = [tokeniser tokenise:rawCode];
  
  ComputerMemory *computerMemory = [[ComputerMemory alloc] initWithCapacity:2000 delegate:nil];
  
  Interpreter *interpreter = [[Interpreter alloc] initWithProgram:program memory:computerMemory registers:[StandardRegisters standardRegisters]];
  
  [interpreter run];
  
  XCTAssertEqual([computerMemory readFromAddress:1000], 100, @"should have been set to 100");
  XCTAssertEqual([computerMemory readFromAddress:1001], 100, @"should have been set to 100");
  XCTAssertEqual([computerMemory readFromAddress:1002], 0, @"should have been set to 100");
}

- (void)testREADINDIRECTReadsIndirectly
{
  Tokeniser *tokeniser = [[Tokeniser alloc] init];
  
  NSString *rawCode = @""
  
  "SET 100\n"
  "WRITE 1000\n"
  
  "SET 1000\n"
  "WRITE 0\n"
  
  "READINDRECT 0";
  
  Program *program = [tokeniser tokenise:rawCode];
  
  ComputerMemory *computerMemory = [[ComputerMemory alloc] initWithCapacity:2000 delegate:nil];
  
  Interpreter *interpreter = [[Interpreter alloc] initWithProgram:program memory:computerMemory registers:[StandardRegisters standardRegisters]];

  NSInteger retVal = [interpreter run];

  XCTAssertEqual(retVal, 100, @"program should complete and return 100");
}

- (void)testSimpleLoop
{
  Tokeniser *tokeniser = [[Tokeniser alloc] init];
  
  NSString *rawCode = @""
  "LOOP:\n"
  "READ 0\n"
  "ADD 1\n"
  "WRITE 0\n"
  "ADD -1000\n"
  "IF LOOP:\n"
  "READ 0";
  
  Program *program = [tokeniser tokenise:rawCode];
 
  ComputerMemory *computerMemory = [[ComputerMemory alloc] initWithCapacity:1000 delegate:nil];
  
  Interpreter *interpreter = [[Interpreter alloc] initWithProgram:program memory:computerMemory registers:[StandardRegisters standardRegisters]];
  
  NSInteger retVal = [interpreter run];
  
  XCTAssertEqual(retVal, 1000, @"should be able to branch correctly");
  
}

- (void)testComplexProgram
{
  Tokeniser *tokeniser = [[Tokeniser alloc] init];
  
  NSString *rawCode = @"SET 54\nWRITE 100\nSET 20\nWRITE 101\nPRINT\nLoop:\nREAD 100\nPRINT\nADD 1\nWRITE 100\nADD -60\nIF Loop:\nREAD 101\nPRINT";
  
  Program *program = [tokeniser tokenise:rawCode];
  
  ComputerMemory *computerMemory = [[ComputerMemory alloc] initWithCapacity:1000 delegate:nil];
  
  Interpreter *interpreter = [[Interpreter alloc] initWithProgram:program memory:computerMemory registers:[StandardRegisters standardRegisters]];
  
  NSUInteger retVal = [interpreter run];
  
  XCTAssertEqual(retVal, 20, @"number of lines should be 14");
}

@end
