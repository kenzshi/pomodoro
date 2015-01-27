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
        [sender setTitle:@"New Session!"];
    } else{
        [sender setTitle:@"Start Break!"];
    }
    
    if(PomodoroTimer == nil)
        //[sender setTitle:@"Pause"];
        PomodoroTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(TimerStart) userInfo:nil repeats:YES];

}

-(void)TimerStart{
    if (!IsPaused){
    
        //First 5 seconds will have sound
        TickSound++;
        if (TickSound <= 5){
            NSSound *systemSound = [NSSound soundNamed:@"Pop"];
            [systemSound play];
        }

        TotalTime = TotalTime - 1;
        int minutes = TotalTime/60;
        int seconds = TotalTime - (minutes * 60);
    
        
        //Set text color depending on break/session
        if(OnBreak)
            [Display setTextColor:[NSColor colorWithRed:0.518 green:0.871 blue:0.008 alpha:1.0]];
        else
            [Display setTextColor:[NSColor colorWithRed:0.855 green:0.149 blue:0.278 alpha:1.0]];
        
        Display.stringValue = [NSString stringWithFormat:@"%.2d:%.2d", minutes,seconds];
    
        //When we get to 0:00, system notification
        if (TotalTime == 0) {
            //Reset TickSound
            TickSound = 0;
            
            //Stop timer
            [PomodoroTimer invalidate];
            PomodoroTimer = nil;
        
            //Notify and reinitialize depending on session or break
            if(OnBreak){
                OnBreak = false;
                TotalTime = SessionLength;
                //Send notification finished with break
                NSUserNotification *notification = [[NSUserNotification alloc] init];
                [notification setTitle:@"Break's Over!"];
                [notification setInformativeText:@"Your break is over, get back to work!"];
                [notification setSoundName:NSUserNotificationDefaultSoundName];
                [[NSUserNotificationCenter defaultUserNotificationCenter] deliverNotification:notification];

            }
            else{
                OnBreak = true;
                TotalTime = BreakLength;
                //Send notification finished with Pomodoro session
                NSUserNotification *notification = [[NSUserNotification alloc] init];
                [notification setTitle:@"Finished Session!"];
                [notification setInformativeText:@"You've finished your session, click to start your break!"];
                [notification setSoundName:NSUserNotificationDefaultSoundName];
                [[NSUserNotificationCenter defaultUserNotificationCenter] deliverNotification:notification];

            }
        }
    }
}

-(IBAction)Pause:(id)sender{
    
    if(IsPaused){
        TickSound = 0;
        IsPaused = false;
        [sender setTitle:@"Pause"];
    }
    else{
        TickSound = 0;
        IsPaused = true;
        [sender setTitle:@"Resume"];
    }
    
    
}

-(IBAction)Restart:(id)sender{
    
    if(OnBreak){
        TickSound = 0;
        TotalTime = BreakLength;
        int minutes = TotalTime/60;
        int seconds = TotalTime - (minutes * 60);
        Display.stringValue = [NSString stringWithFormat:@"%.2d:%.2d", minutes,seconds];
    } else {
        TickSound = 0;
        TotalTime = SessionLength;
        int minutes = TotalTime/60;
        int seconds = TotalTime - (minutes * 60);
        Display.stringValue = [NSString stringWithFormat:@"%.2d:%.2d", minutes,seconds];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    
    if(OnBreak){
        TotalTime = BreakLength;
    }
    else
        TotalTime = SessionLength;
    
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

@end
