//
//  FirstViewController.m
//  IF
//
//  Created by Daren David Taylor on 22/04/2014.
//  Copyright (c) 2014 com.DDT. All rights reserved.
//

#import "FirstViewController.h"
#import "CharGridVIew.h"
#import "Tokeniser.h"
#import "Program.h"
#import "Interpreter.h"
#import "ComputerMemory.h"


const NSUInteger KInitialMemoryInBytes = 10000;

@interface FirstViewController ()

@end

@implementation FirstViewController {
  
  __weak IBOutlet CharGridView *_charGridView;
  
  Interpreter *_interpreter;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  [_charGridView setupWithRows:10 colCount:10];
  
  [self startPressed:nil];
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



- (IBAction)startPressed:(id)sender
{
  Tokeniser *tokeniser = [[Tokeniser alloc] init];
  
  NSString *rawCode = [self indirectAddressingCode];
  
  Program *program = [tokeniser tokenise:rawCode];
  
  ComputerMemory *computerMemory = [[ComputerMemory alloc] initWithCapacity:KInitialMemoryInBytes delegate:self];
  
  _interpreter = [[Interpreter alloc] initWithProgram:program memory:computerMemory];
  
  [self run];
}

- (void)run
{
  [_interpreter runNextLine];
  
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
