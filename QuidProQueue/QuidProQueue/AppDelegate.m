//
//  AppDelegate.m
//  QuidProQueue
//
//  Created by Dare Ryan on 3/7/14.
//  Copyright (c) 2014 Dare Ryan. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>
#import "ParseSync.h"
#import "DataStore.h"


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.queue = [[NSOperationQueue alloc]init];
    DataStore *dataStore = [DataStore sharedInstance];
    
    [Parse setApplicationId:@"hAgfTgoHwynFD2u3s5MTvsiC4SttaOseQgnuVbWh"
                  clientKey:@"C3TECcnLIidkKyuslzkce2SiX5riXaQBMyhNPaSw"];
    [self.queue addOperationWithBlock:^{
        
        [ParseSync syncLocalDataToDataStore:dataStore];
        [ParseSync syncOnlineDataToDataStore:dataStore];
        
    }];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
    //Log out employee
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"User"];
    
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"User"];
    
}


@end
