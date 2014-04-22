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
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [_charGridView setupWithRows:10 colCount:10];
    
    [self startPressed:nil];
}

- (IBAction)startPressed:(id)sender
{

    Tokeniser *tokeniser = [[Tokeniser alloc] init];
    
    NSString *rawCode = @""
    "LOOP:\n"
    "READ 1050\n"
    "ADD 1\n"
    "WRITE 1050\n"
    "ADD -1000\n"
    "IF LOOP:";
    
    Program *program = [tokeniser tokenise:rawCode];
    
    ComputerMemory *computerMemory = [[ComputerMemory alloc] initWithCapacity:KInitialMemoryInBytes delegate:self];
    
    Interpreter *interpreter = [[Interpreter alloc] initWithProgram:program memory:computerMemory];
    
    dispatch_queue_t queue = dispatch_queue_create("com.yourdomain.yourappname", NULL);
    dispatch_async(queue, ^{
        
        [interpreter run];
    
    });
    
    

}


- (void)writeToAddress:(NSUInteger)address withValue:(NSInteger)value
{
    if (address >=1000 && address <1200) {
        [_charGridView writeToAddress:address-1000 withValue:(NSInteger)value];
    }
}

@end
