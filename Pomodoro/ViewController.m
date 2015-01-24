//
//  ViewController.m
//  Pomodoro
//
//  Created by Kenny Shi on 1/23/15.
//  Copyright (c) 2015 Kenny Shi. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

-(IBAction)Start:(id)sender{
    PomodoroTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(TimerStart) userInfo:nil repeats:YES];
}

-(void)TimerStart{
    
    Counter = Counter - 1;
    Display.stringValue = [NSString stringWithFormat:@"%i", Counter];
}

-(IBAction)Stop:(id)sender{
    
    [PomodoroTimer invalidate];
    
}

-(IBAction)Restart:(id)sender{
    
    Counter = 25;
    Display.stringValue = [NSString stringWithFormat:@"%i", Counter];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

@end
