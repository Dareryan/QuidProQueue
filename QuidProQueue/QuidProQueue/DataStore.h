//
//  DataStore.h
//  QuidProQueue
//
//  Created by Dare Ryan on 3/21/14.
//  Copyright (c) 2014 Dare Ryan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Customer.h"
#import "Location.h"

@interface DataStore : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

+(DataStore *) sharedInstance;

- (void)saveContext;

- (NSURL *)applicationDocumentsDirectory;

+(void)addLocationWithAreaName:(NSString *)name toCustomer:(Customer *)customer inManagedObjectContext:(NSManagedObjectContext *)context;

+(NSArray *)returnCustomersWithStartedSessionsInContext:(NSManagedObjectContext *)context;

+(NSArray *)returnAnArrayOfCurrentlyPresentCustomersForAreaNamed:(NSString *)area InContext:(NSManagedObjectContext *)context;


@end
