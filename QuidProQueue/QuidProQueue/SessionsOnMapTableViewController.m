//
//  SessionsOnMapTableViewController.m
//  QuidProQueue
//
//  Created by Dare Ryan on 3/22/14.
//  Copyright (c) 2014 Dare Ryan. All rights reserved.
//

#import "SessionsOnMapTableViewController.h"
#import "DataStore.h"
#import "Customer.h"
#import "Location.h"
#import "CustomerDetailTableViewController.h"

@interface SessionsOnMapTableViewController ()

@property (strong, nonatomic) NSArray *customersAtLocationArray;
@property (strong, nonatomic) DataStore *dataStore;

- (IBAction)doneButtonPressed:(id)sender;

@end

@implementation SessionsOnMapTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.dataStore = [DataStore sharedInstance];
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Location"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"area = %@",self.locationArea];
    fetchRequest.predicate = predicate;
    Location *location = [self.dataStore.managedObjectContext executeFetchRequest:fetchRequest error:nil][0];
    self.customersAtLocationArray = [location.customers allObjects];
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
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



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.customersAtLocationArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    Customer *customerAtIndexPath = self.customersAtLocationArray[indexPath.row];
    
    NSDate *currentTime= [NSDate date];
    NSTimeInterval timeElapsed = [currentTime timeIntervalSinceDate:customerAtIndexPath.arrivalTime];
    cell.textLabel.text = customerAtIndexPath.name;
    
    //Correct grammar for a single minute vs multiple minute wait time
    
    if ([[NSString stringWithFormat:@"%.0f",timeElapsed/60]integerValue] == 1)
    {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"Wait time: %.0f minute\nNotes: %@", timeElapsed/60.0, customerAtIndexPath.notes];
    }
    
    else
    {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"Wait time: %.0f minutes\nNotes: %@", timeElapsed/60.0, customerAtIndexPath.notes];
    }

    return cell;
}

- (IBAction)doneButtonPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    CustomerDetailTableViewController *customerDatilTVC = segue.destinationViewController;
    Customer *passingCustomer = self.customersAtLocationArray[[self.tableView indexPathForSelectedRow].row];
    customerDatilTVC.passedCustomer = passingCustomer;
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
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
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

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
