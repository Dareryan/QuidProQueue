//
//  Employee.h
//  QuidProQueue
//
//  Created by Dare Ryan on 3/21/14.
//  Copyright (c) 2014 Dare Ryan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Customer, Session;

@interface Employee : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *customers;
@property (nonatomic, retain) NSSet *sessions;
@end

@interface Employee (CoreDataGeneratedAccessors)

- (void)addCustomersObject:(Customer *)value;
- (void)removeCustomersObject:(Customer *)value;
- (void)addCustomers:(NSSet *)values;
- (void)removeCustomers:(NSSet *)values;

- (void)addSessionsObject:(Session *)value;
- (void)removeSessionsObject:(Session *)value;
- (void)addSessions:(NSSet *)values;
- (void)removeSessions:(NSSet *)values;

@end
