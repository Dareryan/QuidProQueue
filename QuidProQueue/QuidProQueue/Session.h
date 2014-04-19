//
//  Session.h
//  QuidProQueue
//
//  Created by Dare Ryan on 3/31/14.
//  Copyright (c) 2014 Dare Ryan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Customer, Employee;

@interface Session : NSManagedObject

@property (nonatomic, retain) NSString * employeeNameForSessionEnd;
@property (nonatomic, retain) NSString * employeeNameForSessionStart;
@property (nonatomic, retain) NSDate * endTime;
@property (nonatomic, retain) NSNumber * isEnded;
@property (nonatomic, retain) NSNumber * isStarted;
@property (nonatomic, retain) NSDate * startTime;
@property (nonatomic, retain) NSString * uniqueID;
@property (nonatomic, retain) NSDate * lastEdited;
@property (nonatomic, retain) Customer *customer;
@property (nonatomic, retain) Employee *employee;

@end
