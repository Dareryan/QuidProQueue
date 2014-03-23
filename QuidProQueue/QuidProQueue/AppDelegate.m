//
//  AppDelegate.m
//  QuidProQueue
//
//  Created by Dare Ryan on 3/7/14.
//  Copyright (c) 2014 Dare Ryan. All rights reserved.
//

#import "AppDelegate.h"
#import "Employee.h"





@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.dataStore = [DataStore sharedInstance];
   
   
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
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Employee"];
    
    if ([[self.dataStore.managedObjectContext executeFetchRequest:fetchRequest error:nil] count] != 0)
    {
        Employee *employee = [self.dataStore.managedObjectContext executeFetchRequest:fetchRequest error:nil][0];
        [self.dataStore.managedObjectContext deleteObject:employee];
        [self.dataStore saveContext];
    }

   

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
    // Saves changes in the application's managed object context before the application terminates.
    
}


@end
