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
int TickSound = 0; // Variable to keep track of tick sounds when starting new session
double SessionNum = 1;
bool OnBreak = false;
bool IsPaused = false;
int SessionLength = 1500; // Default 25 min session (1500)
int BreakLength = 300; // Default 5 min break (300)

@interface ViewController : NSViewController{
    IBOutlet NSTextField *Display;
    IBOutlet NSLevelIndicator *Indicator; //Keeps track of number of pomodoro sessions
    NSTimer *PomodoroTimer;
    
}

-(void)TimerStart;
-(IBAction)Start:(id)sender;
-(IBAction)Pause:(id)sender;
-(IBAction)Restart:(id)sender;

@end

