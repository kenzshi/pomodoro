//
//  AppDelegate.m
//  Pomodoro
//
//  Created by Kenny Shi on 1/23/15.
//  Copyright (c) 2015 Kenny Shi. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

//Added to get popup notification working
- (BOOL)userNotificationCenter:(NSUserNotificationCenter *)center
     shouldPresentNotification:(NSUserNotification *)notification
{
    return YES;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    [[NSUserNotificationCenter defaultUserNotificationCenter] setDelegate:self];

}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
