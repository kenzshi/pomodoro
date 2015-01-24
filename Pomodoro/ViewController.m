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
    PomodoroTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(TimerStart) userInfo:nil repeats:YES];
}

-(void)TimerStart{
    
    TotalTime = TotalTime - 1;
    int minutes = TotalTime/60;
    int seconds = TotalTime - (minutes * 60);
    
    Display.stringValue = [NSString stringWithFormat:@"%.2d:%.2d", minutes,seconds];
    
    //When we get to 0, system notification
    if (TotalTime == 0) {
        [PomodoroTimer invalidate];
        PomodoroTimer = nil;
        
        //Send notification
        NSUserNotification *notification = [[NSUserNotification alloc] init];
        [notification setTitle:@"Pomodoro Timer"];
        [notification setInformativeText:@"You've finished your session!"];
        [notification setSoundName:NSUserNotificationDefaultSoundName];
        
        [[NSUserNotificationCenter defaultUserNotificationCenter] deliverNotification:notification];
    }
}

-(IBAction)Stop:(id)sender{
    
    [PomodoroTimer invalidate];
    
}

-(IBAction)Restart:(id)sender{
    
    TotalTime = 1500;
    Display.stringValue = @"25:00";
    
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
