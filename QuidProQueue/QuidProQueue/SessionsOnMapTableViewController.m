//
//  SessionsOnMapTableViewController.m
//  QuidProQueue
//
//  Created by Dare Ryan on 3/22/14.
//  Copyright (c) 2014 Dare Ryan. All rights reserved.
//

#import "SessionsOnMapTableViewController.h"
#import "DataStore.h"
#import "Customer+Methods.h"
#import "Location.h"
#import "CustomerDetailTableViewController.h"
#import "Session+Methods.h"
#import "Employee.h"

@interface SessionsOnMapTableViewController ()

@property (strong, nonatomic) NSArray *customersPresentAtLocationArray;
@property (strong, nonatomic) DataStore *dataStore;

- (IBAction)doneButtonPressed:(id)sender;

@end

@implementation SessionsOnMapTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.dataStore = [DataStore sharedInstance];
    
    self.customersPresentAtLocationArray = [DataStore returnAnArrayOfCurrentlyPresentCustomersForAreaNamed:self.locationArea InContext:self.dataStore.managedObjectContext];
    
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.customersPresentAtLocationArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    Customer *customerAtIndexPath = self.customersPresentAtLocationArray[indexPath.row];
    
    if (!customerAtIndexPath.session.isStarted){
        cell.textLabel.text = customerAtIndexPath.name;
        cell.detailTextLabel.text = [customerAtIndexPath calculateWaitTimeForCustomer];
        
        return cell;
    }
    else{
        cell.textLabel.text = customerAtIndexPath.name;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"Session started by %@ at %@", customerAtIndexPath.session.employee.name, [customerAtIndexPath.session returnFormattedStartTime]];
        
        return cell;
    }
}

- (IBAction)doneButtonPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    CustomerDetailTableViewController *customerDatilTVC = segue.destinationViewController;
    
    Customer *passingCustomer = self.customersPresentAtLocationArray[[self.tableView indexPathForSelectedRow].row];
    customerDatilTVC.passedCustomer = passingCustomer;
}

@end
