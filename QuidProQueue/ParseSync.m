//
//  ParseSync.m
//  QuidProQueue
//
//  Created by Dare Ryan on 3/28/14.
//  Copyright (c) 2014 Dare Ryan. All rights reserved.
//

#import "ParseSync.h"
#import <Parse/Parse.h>
#import "Customer+Methods.h"
#import "Session+Methods.h"

@interface ParseSync ()


@end

@implementation ParseSync

+(void)syncLocalDataToDataStore:(DataStore *)dataStore {
    
    NSFetchRequest *customerFetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Customer"];
    NSArray *customerArray = [dataStore.managedObjectContext executeFetchRequest:customerFetchRequest error:nil];
    
    for (Customer *customer in customerArray) {
        if (!customer.uniqueID) {
            PFObject *newCustomer = [PFObject objectWithClassName:@"Customer"];
            if (customer.name){
                newCustomer[@"name"] = customer.name;
            }
            if (customer.arrivalTime){
                newCustomer[@"arrivalTime"] = customer.arrivalTime;
            }
            if (customer.notes){
                newCustomer[@"notes"] = customer.notes;
            }
            if (customer.session.employeeNameForSessionStart){
                newCustomer[@"startedBy"] = customer.session.employeeNameForSessionStart;
            }
            if (customer.session.employeeNameForSessionEnd){
                newCustomer[@"endedBy"] = customer.session.employeeNameForSessionEnd;
            }
            if (customer.location.area){
                newCustomer[@"location"] = customer.location.area;
            }
            if (customer.session.isStarted) {
                newCustomer[@"isStarted"] = customer.session.isStarted;
            }
            if (customer.session.startTime){
                newCustomer[@"startTime"] = customer.session.startTime;
            }
            if (customer.session.endTime){
                newCustomer[@"endTime"] = customer.session.endTime;
            }
            if (customer.session.isEnded) {
                newCustomer[@"isEnded"] = customer.session.isEnded;
            }
            
            [newCustomer save];
            
            customer.lastEdited = newCustomer.updatedAt;
            customer.uniqueID = newCustomer.objectId;
            
            [dataStore saveContext];
        }
    }
    [dataStore saveContext];
}

+(void)syncOnlineDataToDataStore:(DataStore *)dataStore
{
    NSFetchRequest *customerFetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Customer"];
    NSArray *customerArray = [dataStore.managedObjectContext executeFetchRequest:customerFetchRequest error:nil];
    NSFetchRequest *locationFetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Location"];
    NSArray *locationArray = [dataStore.managedObjectContext executeFetchRequest:locationFetchRequest error:nil];
    
    PFQuery *newQuery = [PFQuery queryWithClassName:@"Customer"];
    [newQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        for (PFObject *object in objects) {
            NSPredicate *idPredicate = [NSPredicate predicateWithFormat:@"uniqueID = %@", object.objectId];
            NSArray *resultsArray = [customerArray filteredArrayUsingPredicate:idPredicate];
            
            if ([resultsArray count] == 0) {
                NSEntityDescription *customerEntityDescription = [NSEntityDescription entityForName:@"Customer" inManagedObjectContext: dataStore.managedObjectContext];
                Customer *newCustomer = [[Customer alloc]initWithEntity:customerEntityDescription insertIntoManagedObjectContext:dataStore.managedObjectContext];
                
                NSEntityDescription *sessionEntityDescription = [NSEntityDescription entityForName:@"Session" inManagedObjectContext:dataStore.managedObjectContext];
                Session *newSession = [[Session alloc]initWithEntity:sessionEntityDescription insertIntoManagedObjectContext:dataStore.managedObjectContext];
                
                newSession.employeeNameForSessionStart = object[@"startedBy"];
                newSession.employeeNameForSessionEnd = object[@"endedBy"];
                newSession.startTime = object[@"startTime"];
                newSession.customer = newCustomer;
                newCustomer.name = object[@"name"];
                newCustomer.arrivalTime = object[@"arrivalTime"];
                newCustomer.notes = object[@"notes"];
                newCustomer.uniqueID = object.objectId;
                newCustomer.lastEdited = object.updatedAt;
                newCustomer.session.isStarted = object[@"isStarted"];
                newCustomer.session.isEnded = object[@"isEnded"];
                newCustomer.session.startTime = object[@"startTime"];
                newCustomer.session.employeeNameForSessionStart = object[@"startedBy"];
                newCustomer.session.employeeNameForSessionEnd = object[@"endedBy"];
                newCustomer.session.endTime = object[@"endTime"];
                
                NSPredicate *locationPredicate = [NSPredicate predicateWithFormat:@"area = %@", object[@"location"]];
                NSArray *filteredLocationArray = [locationArray filteredArrayUsingPredicate:locationPredicate];
                
                if ([filteredLocationArray count] == 0) {
                    NSEntityDescription *locationEntityDescription = [NSEntityDescription entityForName:@"Location" inManagedObjectContext:dataStore.managedObjectContext];
                    Location *newLocation = [[Location alloc]initWithEntity:locationEntityDescription insertIntoManagedObjectContext:dataStore.managedObjectContext];
                    newLocation.area = object[@"location"];
                    [newLocation addCustomersObject:newCustomer];
                }
                else{
                    Location *location = filteredLocationArray[0];
                    [location addCustomersObject:newCustomer];
                    [dataStore saveContext];
                }
            }
        }
    }];
}

+(void)updateLocalDataInDataStore:(DataStore *)dataStore
{
    
    NSFetchRequest *customerFetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Customer"];
    NSArray *customerArray = [dataStore.managedObjectContext executeFetchRequest:customerFetchRequest error:nil];
    
    PFQuery *newQuery = [PFQuery queryWithClassName:@"Customer"];
    [newQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        for (PFObject *object in objects) {
            for (Customer *customer in customerArray) {
                if ([customer.uniqueID isEqualToString: object.objectId]) {
                    NSComparisonResult result;
                    result = [customer.lastEdited compare:object.updatedAt];
                    
                    if (result == NSOrderedAscending) {
                        
                        customer.name = object[@"name"];
                        customer.arrivalTime = object[@"arrivalTime"];
                        customer.notes = object[@"notes"];
                        customer.location.area = object[@"location"];
                        if (customer.session) {
                            customer.session.employeeNameForSessionStart = object[@"startedBy"];
                            customer.session.employeeNameForSessionEnd = object[@"endedBy"];
                            customer.session.isStarted = object[@"isStarted"];
                            customer.session.startTime = object[@"startTime"];
                            customer.session.isEnded = object[@"isEnded"];
                            customer.session.endTime = object[@"endTime"];
                        }
                        if (!customer.session) {
                            NSEntityDescription *sessionDescription = [NSEntityDescription entityForName:@"Session" inManagedObjectContext:dataStore.managedObjectContext];
                            
                            Session *newSession = [[Session alloc]initWithEntity:sessionDescription insertIntoManagedObjectContext:dataStore.managedObjectContext];
                            
                            customer.session = newSession;
                            customer.session.employeeNameForSessionStart = object[@"startedBy"];
                            customer.session.employeeNameForSessionEnd = object[@"endedBy"];
                            customer.session.isStarted = object[@"isStarted"];
                            customer.session.startTime = object[@"startTime"];
                            customer.session.isEnded = object[@"isEnded"];
                            customer.session.endTime = object[@"endTime"];
                        }
                        
                        customer.lastEdited = object.updatedAt;
                        
                        [dataStore saveContext];
                    }
                    if (result == NSOrderedDescending) {
                        if (customer.name) {
                            object[@"name"] = customer.name;
                        }
                        if (customer.arrivalTime) {
                            object[@"arrivalTime"] = customer.arrivalTime;
                        }
                        if (customer.notes) {
                            object[@"notes"] = customer.notes;
                        }
                        if (customer.session.employeeNameForSessionStart) {
                            object[@"startedBy"] = customer.session.employeeNameForSessionStart;
                        }
                        if (customer.session.employeeNameForSessionEnd) {
                            object[@"endedBy"] = customer.session.employeeNameForSessionEnd;
                        }
                        if (customer.location.area) {
                            object[@"location"] = customer.location.area;
                        }
                        if (customer.session.isStarted != nil) {
                            object[@"isStarted"] = customer.session.isStarted;
                        }
                        if (customer.session.startTime) {
                            object[@"startTime"] = customer.session.startTime;
                        }
                        if (customer.session.endTime) {
                            object[@"endTime"] = customer.session.endTime;
                        }
                        if (customer.session.isEnded != nil) {
                            object[@"isEnded"] = customer.session.isEnded;
                        }
                        
                        [object save];
                        [dataStore saveContext];
                    }
                }
            }
        }
    }];
}

@end
