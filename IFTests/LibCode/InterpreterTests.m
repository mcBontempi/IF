#import <XCTest/XCTest.h>
#import "Tokeniser.h"
#import "Interpreter.h"
#import "Program.h"
#import "ComputerMemory.h"

@interface InterpreterTests : XCTestCase

@end

@implementation InterpreterTests

- (void)testInterpreterEndsWithNoLines
{
  Tokeniser *tokeniser = [[Tokeniser alloc] init];
  
  NSString *rawCode = @"";
  
  Program *program = [tokeniser tokenise:rawCode];
  
  ComputerMemory *computerMemory = [[ComputerMemory alloc] init];
  
  Interpreter *interpreter = [[Interpreter alloc] initWithProgram:program memory:computerMemory];
  
  NSUInteger retVal = [interpreter run];
  
  XCTAssertEqual(retVal, 0, @"program should complete and return 0");
}

- (void)testSETSetsAccumulator
{
  Tokeniser *tokeniser = [[Tokeniser alloc] init];
  
  NSString *rawCode = @"SET 100";
  
  Program *program = [tokeniser tokenise:rawCode];
 
  ComputerMemory *computerMemory = [[ComputerMemory alloc] init];
  
  Interpreter *interpreter = [[Interpreter alloc] initWithProgram:program memory:computerMemory];
  
  NSUInteger retVal = [interpreter run];
  
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
 
  ComputerMemory *computerMemory = [[ComputerMemory alloc] init];
  
  Interpreter *interpreter = [[Interpreter alloc] initWithProgram:program memory:computerMemory];
  
  NSInteger retVal = [interpreter run];
  
  XCTAssertEqual(retVal, 1000, @"should be able to branch correctly");
  
}

- (void)testComplexProgram
{
  Tokeniser *tokeniser = [[Tokeniser alloc] init];
  
  NSString *rawCode = @"SET 54\nWRITE 100\nSET 20\nWRITE 101\nPRINT\nLoop:\nREAD 100\nPRINT\nADD 1\nWRITE 100\nADD -60\nIF Loop:\nREAD 101\nPRINT";
  
  Program *program = [tokeniser tokenise:rawCode];
  
  ComputerMemory *computerMemory = [[ComputerMemory alloc] init];
  
  Interpreter *interpreter = [[Interpreter alloc] initWithProgram:program memory:computerMemory];
  
  NSUInteger retVal = [interpreter run];
  
  XCTAssertEqual(retVal, 20, @"number of lines should be 14");
}

@end
