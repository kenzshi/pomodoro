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

    
    
    if(PomodoroTimer == nil){
        PomodoroTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(TimerStart) userInfo:nil repeats:YES];
    }

}

-(void)TimerStart{
    
    [Indicator setDoubleValue:SessionNum];

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
    
        
        //Set text color depending on break/session, using Crayola colors
        if(OnBreak)
            [Display setTextColor:[NSColor colorWithRed:0.518 green:0.871 blue:0.008 alpha:1.0]]; // Alien Armpit
        else if(TotalTime <= SessionLength*1/5)
            [Display setTextColor:[NSColor colorWithRed:1.000 green:0.220 blue:0.333 alpha:1.0]]; // Sizzling Red
        else if(TotalTime <= SessionLength*2/5)
            [Display setTextColor:[NSColor colorWithRed:0.980 green:0.357 blue:0.239 alpha:1.0]]; // Orange Soda
        else if(TotalTime <= SessionLength*3/5)
            [Display setTextColor:[NSColor colorWithRed:1.000 green:0.667 blue:0.114 alpha:1.0]]; // Bright Yellow
        else if(TotalTime <= SessionLength*4/5)
            [Display setTextColor:[NSColor colorWithRed:1.000 green:0.859 blue:0.000 alpha:1.0]]; // Sizzling Sunrise
        else if(TotalTime <= SessionLength)
            [Display setTextColor:[NSColor colorWithRed:0.518 green:0.871 blue:0.008 alpha:1.0]]; // Alien Armpit
        
        
        
        //Print time to screen
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
    //Pauses and resumes
    if(IsPaused){
        TickSound = 0;
        IsPaused = false;
    }
    else{
        TickSound = 0;
        IsPaused = true;
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
