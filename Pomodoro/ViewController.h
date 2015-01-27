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
bool IsPaused = false;
int SessionLength = 10; // Default 25 min session (1500)
int BreakLength = 3; // Default 5 min break (300)

@interface ViewController : NSViewController{
    IBOutlet NSTextField *Display;
    NSTimer *PomodoroTimer;
    
}

-(void)TimerStart;
-(IBAction)Start:(id)sender;
-(IBAction)Pause:(id)sender;
-(IBAction)Restart:(id)sender;

@end

