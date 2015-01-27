//
//  ViewController.h
//  Pomodoro
//
//  Created by Kenny Shi on 1/23/15.
//  Copyright (c) 2015 Kenny Shi. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <AppKit/AppKit.h>


int TotalTime;
bool OnBreak = false;
int SessionLength = 1500; // Default 25 min session
int BreakLength = 300; // Default 5 min break 

@interface ViewController : NSViewController{
    IBOutlet NSTextField *Display;
    NSTimer *PomodoroTimer;
    
}

-(void)TimerStart;
-(IBAction)Start:(id)sender;
-(IBAction)Stop:(id)sender;
-(IBAction)Restart:(id)sender;

@end

