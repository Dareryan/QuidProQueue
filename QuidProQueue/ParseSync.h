//
//  ParseSync.h
//  QuidProQueue
//
//  Created by Dare Ryan on 3/28/14.
//  Copyright (c) 2014 Dare Ryan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataStore.h"

@interface ParseSync : NSObject

+(void)syncLocalDataToDataStore:(DataStore *)dataStore;
+(void)syncOnlineDataToDataStore:(DataStore *)dataStore;
+(void)updateLocalDataInDataStore:(DataStore *)dataStore;

@end
