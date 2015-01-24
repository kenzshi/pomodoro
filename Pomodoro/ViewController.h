//
//  ViewController.h
//  Pomodoro
//
//  Created by Kenny Shi on 1/23/15.
//  Copyright (c) 2015 Kenny Shi. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <AppKit/AppKit.h>


int Counter = 25;

@interface ViewController : NSViewController{
    IBOutlet NSTextField *Display;
    NSTimer *PomodoroTimer;
    
}

-(void)TimerStart;
-(IBAction)Start:(id)sender;
-(IBAction)Stop:(id)sender;
-(IBAction)Restart:(id)sender;

@end

