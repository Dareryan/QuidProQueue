//
//  Location.h
//  QuidProQueue
//
//  Created by Dare Ryan on 3/31/14.
//  Copyright (c) 2014 Dare Ryan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Customer;

@interface Location : NSManagedObject

@property (nonatomic, retain) NSString * area;
@property (nonatomic, retain) NSString * uniqueID;
@property (nonatomic, retain) NSDate * lastEdited;
@property (nonatomic, retain) NSSet *customers;
@end

@interface Location (CoreDataGeneratedAccessors)

- (void)addCustomersObject:(Customer *)value;
- (void)removeCustomersObject:(Customer *)value;
- (void)addCustomers:(NSSet *)values;
- (void)removeCustomers:(NSSet *)values;

@end
