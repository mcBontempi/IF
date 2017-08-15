#import "FirstViewController.h"
#import "CharGridVIew.h"
#import "Tokeniser.h"
#import "Program.h"
#import "Interpreter.h"
#import "ComputerMemory.h"
#import "StandardRegisters.h"


const NSUInteger KInitialMemoryInBytes = 10000;

@implementation FirstViewController {
  
  __weak IBOutlet CharGridView *_charGridView;
  __weak IBOutlet UITextView *_textView;
  
  Interpreter *_interpreter;
  
  StandardRegisters *_standardRegisters;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  [_charGridView setupWithRows:10 colCount:10];
  
  _textView.text = [self helloCode];
  
 // [self startPressed:nil];
}

- (NSString *)simpleLoopWiteCharOutToDsplayCode
{
  return @""
  "SET 64\n"
  "WRITE 1000\n"
  "LOOP:\n"
  "READ 1000\n"
  "ADD 1\n"
  "WRITE 1000\n"
  "ADD -90\n"
  "IF LOOP:";
}

- (NSString *)indirectAddressingCode
{
  return @""
  "SET 63\n" //the value we are gonna set into the addresses
  "WRITE 10\n"
  "SET 1000\n"
  "LOOPOUTER:\n"
  "ADD 1\n"
  "WRITE 0\n" //just use address zero for indirect, easy to rememebr
  "LOOP:\n"
  "READ 0\n"
  "ADD 1\n"
  "WRITE 0\n"
  "READ 10\n"
  "ADD 1\n"
  "WRITE 10\n"
  "WRITEINDRECT 0\n"
  "ADD -95\n"
  "IF LOOP:\n"
  "READ 10\n"
  "ADD -29\n"
  "WRITE 10\n"
  "READ 0\n"
  "ADD -29\n"
  "IF LOOPOUTER:";
}

- (NSString*)helloCode
{
  return @""
  "SET 32\n"
  "WRITE 2\n"
  "SET 72\n"
  "WRITE 3\n"
  "SET 69\n"
  "WRITE 4\n"
  "SET 76\n"
  "WRITE 5\n"
  "WRITE 6\n"
  "SET 79\n"
  "WRITE 7\n"
  "SET 32\n"
  "WRITE 8\n"
  
  "SET 1000\n"
  "WRITE 1\n"

  "WRITE 20\n"
  
  
  "SCROLLLOOP:\n"
  "READ 20\n"
  "ADD 1\n"
  "WRITE 20\n"
  "WRITE 1\n"
  
  
  "SET 2\n"
  "WRITE 0\n"

  
  "LOOP:\n"
  "READINDRECT 0\n"
  "WRITEINDRECT 1\n"
  
  "READ 1\n"
  "ADD 1\n"
  "WRITE 1\n"
  "READ 0\n"
  "ADD 1\n"
  "WRITE 0\n"
  
  "ADD -9\n"
  "IF LOOP:\n"
  
  "READ 1\n"
  "ADD -1110\n"
  "IF SCROLLLOOP:";

}

- (IBAction)startPressed:(id)sender
{
  [_textView resignFirstResponder];
  
  Tokeniser *tokeniser = [[Tokeniser alloc] init];
  
  NSString *rawCode = _textView.text;
  
  Program *program = [tokeniser tokenise:rawCode];
  
  ComputerMemory *computerMemory = [[ComputerMemory alloc] initWithCapacity:KInitialMemoryInBytes delegate:self];
  
  _standardRegisters = [StandardRegisters standardRegisters];
  
  _interpreter = [[Interpreter alloc] initWithProgram:program memory:computerMemory registers:_standardRegisters];
  
  [self run];
}

- (void)run
{
  [_interpreter runNextLine];
  
 // _textView.
  
  if  ([_interpreter hasNotFinished]) {
    [self performSelector:@selector(run) withObject:nil afterDelay:0.00];
  }
}


- (void)writeToAddress:(NSUInteger)address withValue:(NSInteger)value
{
  if (address >=1000 && address <1200) {
    [_charGridView writeToAddress:address-1000 withValue:(NSInteger)value];
  }
}

@end
