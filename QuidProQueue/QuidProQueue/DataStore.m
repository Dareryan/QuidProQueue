//
//  DataStore.m
//  QuidProQueue
//
//  Created by Dare Ryan on 3/21/14.
//  Copyright (c) 2014 Dare Ryan. All rights reserved.
//

#import "DataStore.h"
#import "Customer.h"
#import "Session.h"

@implementation DataStore

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;


+(DataStore *) sharedInstance
{
    static DataStore *_sharedClient = nil;
    
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedClient = [[self alloc] init];
    });
    
    return _sharedClient;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSFetchRequest *fetchRequest =[[NSFetchRequest alloc]initWithEntityName:@"Customer"];
        NSPredicate *sessionIsStartedPredicate = [NSPredicate predicateWithFormat:@"session.isStarted = nil"];
        fetchRequest.predicate = sessionIsStartedPredicate;
        NSSortDescriptor *arrivalTimeDescriptor = [[NSSortDescriptor alloc]initWithKey:@"arrivalTime" ascending:YES];
        fetchRequest.sortDescriptors = @[arrivalTimeDescriptor];
        _fetchedResultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
        [self.fetchedResultsController performFetch:nil];
        
    }
    return self;
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"QuidProQueue" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"QuidProQueue.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark - Custom Methods

+(void)addLocationWithAreaName:(NSString *)name toCustomer:(Customer *)customer inManagedObjectContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Location"];
    NSMutableArray *locationArray = [NSMutableArray arrayWithArray:[context executeFetchRequest:fetchRequest error:nil]];
    NSPredicate *locationPredicate = [NSPredicate predicateWithFormat:@"area = %@", name];
    NSArray *resultsArray = [locationArray filteredArrayUsingPredicate:locationPredicate];
    
    if ([resultsArray count] == 0){
        NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Location" inManagedObjectContext:context];
        
        Location *newLocation = [[Location alloc]initWithEntity:entityDescription insertIntoManagedObjectContext:context];
        newLocation.area = name;
        [newLocation addCustomersObject:customer];
    }
    else{
        customer.location = resultsArray[0];
    }
}

+(NSArray *)returnCustomersWithStartedSessionsInContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Customer"];
    NSMutableArray *allCustomers = [[NSMutableArray alloc] initWithArray:[context executeFetchRequest:fetchRequest error:nil]];
    NSMutableArray *customersWithSessions = [[NSMutableArray alloc]init];
    
    for (Customer *customer in allCustomers) {
        if ([customer.session.isStarted boolValue] == YES || [customer.session.isEnded boolValue] == YES){
            [customersWithSessions addObject:customer];
        }
    }
    return customersWithSessions;
}

+(NSArray *)returnAnArrayOfCurrentlyPresentCustomersForAreaNamed:(NSString *)area InContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Location"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"area = %@",area];
    fetchRequest.predicate = predicate;
    Location *location = [context executeFetchRequest:fetchRequest error:nil][0];
    
    NSArray *allCustomersForLocation = [location.customers allObjects];
    
    NSMutableArray *customersPresentAtLocationArray = [[NSMutableArray alloc]init];
    
    for (Customer *presentCustomer in allCustomersForLocation){
        if (!presentCustomer.session || [presentCustomer.session.isStarted boolValue] == YES || ([presentCustomer.session.isEnded boolValue] == NO && [presentCustomer.session.isStarted boolValue] == NO)){
            [customersPresentAtLocationArray addObject:presentCustomer];
        }
    }
    return customersPresentAtLocationArray;
}

@end
