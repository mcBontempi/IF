#import <XCTest/XCTest.h>
#import "Tokeniser.h"
#import "Program.h"

@interface TokeniserTests : XCTestCase

@end

@implementation TokeniserTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testGivenAnEmptyStringReturnsNilProgram
{
  Tokeniser *tokeniser = [[Tokeniser alloc] init];
  
  Program *program = [tokeniser tokenise:@""];
  
  XCTAssertNil(program, @"program should be nil");
}

- (void)testGivenAnNilStringReturnsNilProgram
{
  Tokeniser *tokeniser = [[Tokeniser alloc] init];
  
  Program *program = [tokeniser tokenise:nil];
  
  XCTAssertNil(program, @"program should be nil");
}

- (void)testTokenisesCorrectNumberOfLines
{
  Tokeniser *tokeniser = [[Tokeniser alloc] init];
  
  NSString *rawCode = @"SET 54\nWRITE 100\nSET 20\nWRITE 101\nOUT\nLoop:\nREAD 100\nOUT\nINC 1\nWRITE 100\nDEC 60\nIF Loop\nREAD 101\nOUT";
  
  Program *program = [tokeniser tokenise:rawCode];
  
  NSLog(@"%@", [program debugDescription]);
  
  XCTAssertEqual(program.numLines, 14, @"number of lines should be 14");
}

@end
