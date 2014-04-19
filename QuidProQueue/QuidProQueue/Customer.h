//
//  Customer.h
//  QuidProQueue
//
//  Created by Dare Ryan on 3/31/14.
//  Copyright (c) 2014 Dare Ryan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Employee, Location, Session;

@interface Customer : NSManagedObject

@property (nonatomic, retain) NSDate * arrivalTime;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSString * uniqueID;
@property (nonatomic, retain) NSDate * lastEdited;
@property (nonatomic, retain) Employee *employee;
@property (nonatomic, retain) Location *location;
@property (nonatomic, retain) Session *session;

@end
