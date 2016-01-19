//
//  AppDelegate.m
//  HHLanguage
//
//  Created by caohuihui on 16/1/8.
//  Copyright © 2016年 caohuihui. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "HHTool.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:kFilePathKey];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
