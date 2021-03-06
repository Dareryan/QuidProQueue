//
//  AppDelegate.h
//  QuidProQueue
//
//  Created by Dare Ryan on 3/7/14.
//  Copyright (c) 2014 Dare Ryan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataStore.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) DataStore *dataStore;
@property (strong, nonatomic) NSOperationQueue *queue;

@end
