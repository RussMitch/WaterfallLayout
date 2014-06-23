//
//  AppDelegate.m
//  WaterfallLayout
//
//  Created by Russell on 6/23/14.
//  Copyright (c) 2014 Russell Research Corporation. All rights reserved.
//
//------------------------------------------------------------------------------

#import "AppDelegate.h"
#import "ViewController.h"

@implementation AppDelegate

//------------------------------------------------------------------------------
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
//------------------------------------------------------------------------------
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    self.window.rootViewController= [[ViewController alloc] init];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
