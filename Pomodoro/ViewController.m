//
//  ViewController.m
//  Pomodoro
//
//  Created by Kenny Shi on 1/23/15.
//  Copyright (c) 2015 Kenny Shi. All rights reserved.
//

#import "ViewController.h"
@import Foundation;

@implementation ViewController

-(IBAction)Start:(id)sender{
    if(OnBreak){
        TotalTime = BreakLength;
    }
    else
        TotalTime = SessionLength;
    
    PomodoroTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(TimerStart) userInfo:nil repeats:YES];
}

-(void)TimerStart{
    
    NSSound *systemSound = [NSSound soundNamed:@"Pop"];
    [systemSound play];

    TotalTime = TotalTime - 1;
    int minutes = TotalTime/60;
    int seconds = TotalTime - (minutes * 60);
    
    Display.stringValue = [NSString stringWithFormat:@"%.2d:%.2d", minutes,seconds];
    
    //When we get to 0, system notification
    if (TotalTime == 0) {
        [PomodoroTimer invalidate];
        PomodoroTimer = nil;
        
        if(OnBreak){
            OnBreak = false;
            TotalTime = SessionLength;
            //Send notification finished with break
            NSUserNotification *notification = [[NSUserNotification alloc] init];
            [notification setTitle:@"Break's Over!"];
            [notification setInformativeText:@"Your break is over, get back to work!"];
            [notification setSoundName:NSUserNotificationDefaultSoundName];
            [[NSUserNotificationCenter defaultUserNotificationCenter] deliverNotification:notification];
            PomodoroTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(TimerStart) userInfo:nil repeats:YES];
        }
        else{
            OnBreak = true;
            TotalTime = BreakLength;
            //Send notification finished with Pomodoro session
            NSUserNotification *notification = [[NSUserNotification alloc] init];
            [notification setTitle:@"Finished Session!"];
            [notification setInformativeText:@"You've finished your session, your break starts now!"];
            [notification setSoundName:NSUserNotificationDefaultSoundName];
            [[NSUserNotificationCenter defaultUserNotificationCenter] deliverNotification:notification];
            PomodoroTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(TimerStart) userInfo:nil repeats:YES];
        }
        

    }
}

-(IBAction)Stop:(id)sender{
    
    if(OnBreak){
        TotalTime = BreakLength;
        [PomodoroTimer invalidate];
    } else {
        TotalTime = SessionLength;
        [PomodoroTimer invalidate];
    }
    
}

-(IBAction)Restart:(id)sender{
    
    if(OnBreak){
        TotalTime = BreakLength;
        Display.stringValue = @"5:00";
    } else {
        TotalTime = SessionLength;
        Display.stringValue = @"25:00";
    }
    
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
