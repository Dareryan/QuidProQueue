//
//  StartedSessionsTableViewController.m
//  QuidProQueue
//
//  Created by Dare Ryan on 3/8/14.
//  Copyright (c) 2014 Dare Ryan. All rights reserved.
//

#import "StartedSessionsTableViewController.h"
#import <FontAwesomeKit.h>
#import "DataStore.h"
#import "Customer.h"
#import "Location.h"
#import "Session+Methods.h"
#import "CustomerDetailTableViewController.h"
#import "Employee.h"

@interface StartedSessionsTableViewController ()

@property (strong, nonatomic) DataStore *dataStore;
@property (strong, nonatomic) NSArray *customersWithSessions;

@end

@implementation StartedSessionsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
   
}

-(void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    
    self.dataStore = [DataStore sharedInstance];
  
    self.customersWithSessions = [self sortOpenAndEndedSessionsAndOrganizeByStartTime];
    
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.customersWithSessions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Customer *customerAtIndexPath = self.customersWithSessions[indexPath.row];
    
    cell.textLabel.text = customerAtIndexPath.name;
    
    if ([customerAtIndexPath.session.isStarted boolValue] == NO && [customerAtIndexPath.session.isEnded boolValue] == YES){
        cell.textLabel.textColor = [UIColor grayColor];
        cell.detailTextLabel.textColor = [UIColor grayColor];
        
        cell.detailTextLabel.text = [NSString stringWithFormat:@"Session started by %@ at %@\nSession ended by %@ at %@", customerAtIndexPath.session.employeeNameForSessionStart, [customerAtIndexPath.session returnFormattedStartTime], customerAtIndexPath.session.employeeNameForSessionEnd, [customerAtIndexPath.session returnFormattedEndTime]];

        return cell;
    }
    else{
        cell.textLabel.textColor = [UIColor blackColor];
        cell.detailTextLabel.textColor = [UIColor blackColor];
       
        cell.detailTextLabel.text = [NSString stringWithFormat:@"Session started by %@ at %@",customerAtIndexPath.session.employeeNameForSessionStart, [customerAtIndexPath.session returnFormattedStartTime]];
        
        return cell;
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    CustomerDetailTableViewController *customerDetailVC = segue.destinationViewController;
    
    Customer *passingCustomer = self.customersWithSessions[[self.tableView indexPathForSelectedRow].row];
    
    customerDetailVC.passedCustomer = passingCustomer;
}

-(UITabBarItem *)tabBarItem
{
    FAKFontAwesome *tabIcon = [FAKFontAwesome tachometerIconWithSize:30];
    [tabIcon addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor]];
    UIImage *tabIconImage = [tabIcon imageWithSize:CGSizeMake(30,30)];
    UITabBarItem *tabBarItem = [[UITabBarItem alloc]initWithTitle:@"Sessions" image:tabIconImage selectedImage:tabIconImage];
    
    return tabBarItem;
}

#pragma mark custom methods

-(NSArray *)sortOpenAndEndedSessionsAndOrganizeByStartTime
{
    NSArray *customersWithOpenSessions = [DataStore returnCustomersWithStartedSessionsInContext:self.dataStore.managedObjectContext];
    
    NSSortDescriptor *endedSessionsSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"session.isStarted" ascending:NO];
    NSSortDescriptor *startTimeSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"session.startTime" ascending:NO];
   
    NSArray *sortDescriptorsArray = @[endedSessionsSortDescriptor, startTimeSortDescriptor];
    
    return [customersWithOpenSessions sortedArrayUsingDescriptors:sortDescriptorsArray];
}

@end
