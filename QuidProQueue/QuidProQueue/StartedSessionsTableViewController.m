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

- (IBAction)reploadButtonPressed:(id)sender;

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
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    if (customerAtIndexPath.session.endTime)
    {
        cell.textLabel.textColor = [UIColor grayColor];
        cell.detailTextLabel.textColor = [UIColor grayColor];
        
        cell.detailTextLabel.text = [NSString stringWithFormat:@"Session started by %@ at %@\nSession ended by %@ at %@", customerAtIndexPath.session.employee.name, [customerAtIndexPath.session returnFormattedStartTime], customerAtIndexPath.session.employee.name, [customerAtIndexPath.session returnFormattedEndTime]];

        return cell;
    }
    else
    {
        cell.textLabel.textColor = [UIColor blackColor];
        cell.detailTextLabel.textColor = [UIColor blackColor];
       
        cell.detailTextLabel.text = [NSString stringWithFormat:@"Session started by %@ at %@",customerAtIndexPath.session.employee.name, [customerAtIndexPath.session returnFormattedStartTime]];
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

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a story board-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 
 */

- (IBAction)reploadButtonPressed:(id)sender {
    [self.tableView reloadData];
}
@end
