//
//  DataStore.h
//  QuidProQueue
//
//  Created by Dare Ryan on 3/21/14.
//  Copyright (c) 2014 Dare Ryan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataStore : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

+(DataStore *) sharedInstance;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
