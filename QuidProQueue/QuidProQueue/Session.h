//
//  Session.h
//  QuidProQueue
//
//  Created by Dare Ryan on 3/21/14.
//  Copyright (c) 2014 Dare Ryan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Customer, Employee;

@interface Session : NSManagedObject

@property (nonatomic, retain) NSDate * endTime;
@property (nonatomic, retain) NSNumber * isStarted;
@property (nonatomic, retain) NSDate * startTime;
@property (nonatomic, retain) Employee *employee;
@property (nonatomic, retain) Customer *customer;

@end
