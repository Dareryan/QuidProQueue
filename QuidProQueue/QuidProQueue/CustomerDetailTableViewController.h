//
//  CustomerDetailTableViewController.h
//  QuidProQueue
//
//  Created by Dare Ryan on 3/14/14.
//  Copyright (c) 2014 Dare Ryan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Customer.h"

@interface CustomerDetailTableViewController : UITableViewController

@property (strong, nonatomic) Customer *passedCustomer;

@end
