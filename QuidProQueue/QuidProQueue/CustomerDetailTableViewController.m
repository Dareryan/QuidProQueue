//
//  CustomerDetailTableViewController.m
//  QuidProQueue
//
//  Created by Dare Ryan on 3/14/14.
//  Copyright (c) 2014 Dare Ryan. All rights reserved.
//

#import "CustomerDetailTableViewController.h"
#import "Location.h"

#import "Session.h"
#import "DataStore.h"
#import "Employee.h"
#import "Customer+Methods.h"

@interface CustomerDetailTableViewController ()
@property (weak, nonatomic) IBOutlet UILabel *customerNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *customerNotesLabel;
@property (weak, nonatomic) IBOutlet UILabel *customerWaitTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *customerLocationLabel;
@property (strong, nonatomic) DataStore *dataStore;
@property (weak, nonatomic) IBOutlet UIButton *startSessionButton;

- (IBAction)startSessionButtonPressed:(id)sender;

@end

@implementation CustomerDetailTableViewController

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
    [super viewWillAppear:animated];
    
    self.customerNameLabel.text = [NSString stringWithFormat:@"Name: %@",self.passedCustomer.name];
    self.customerNotesLabel.text = [NSString stringWithFormat:@"Notes: %@",self.passedCustomer.notes];
    self.customerWaitTimeLabel.text = [self.passedCustomer calculateWaitTimeForCustomer];
    self.customerLocationLabel.text = [NSString stringWithFormat:@"Location: %@",self.passedCustomer.location.area];
    
    if (!self.passedCustomer.session)
    {
        [self.startSessionButton setTitle:@"Start Session" forState:UIControlStateNormal];
        [self.startSessionButton setTitleColor:[[[[UIApplication sharedApplication] delegate] window] tintColor]forState:UIControlStateNormal];
    }
    else if ([self.passedCustomer.session.isStarted boolValue] == YES)
    {
        [self.startSessionButton setTitle:@"End Session" forState:UIControlStateNormal];
        [self.startSessionButton setTitleColor:[UIColor colorWithRed:0.875 green:0.173 blue:0.290 alpha:1] forState:UIControlStateNormal];
        
    }
    else if ([self.passedCustomer.session.isStarted boolValue] == NO)
    {
        [self.startSessionButton setTitle:@"Restart Session" forState:UIControlStateNormal];
        [self.startSessionButton setTitleColor:[[[[UIApplication sharedApplication] delegate] window] tintColor]forState:UIControlStateNormal];
        
    }
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dataStore = [DataStore sharedInstance];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return 1;
}



/*
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
 {
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
 
 // Configure the cell...
 
 return cell;
 }
 */

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


#pragma mark - custom methods


- (IBAction)startSessionButtonPressed:(id)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (![defaults objectForKey:@"User"])
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Please log-in to start and end sessions" message:@"In order to start or end a session, you must log-in in the settings tab" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
    else
    {
       
       NSFetchRequest *employeeFetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Employee"];
        NSPredicate *userNamePreidcate = [NSPredicate predicateWithFormat:@"name = %@", [defaults objectForKey:@"User"]];
        employeeFetchRequest.predicate = userNamePreidcate;
        
        if ([[self.dataStore.managedObjectContext executeFetchRequest:employeeFetchRequest error:nil]count] == 0)
        {
            NSEntityDescription *employeeDescription = [NSEntityDescription entityForName:@"Employee" inManagedObjectContext:self.dataStore.managedObjectContext];
            Employee *newEmployee = [[Employee alloc]initWithEntity:employeeDescription insertIntoManagedObjectContext:self.dataStore.managedObjectContext];
            newEmployee.name = [defaults objectForKey:@"User"];
        }
        
        
        if (!self.passedCustomer.session)
        {
            NSEntityDescription *sessionEntityDescription = [NSEntityDescription entityForName:@"Session" inManagedObjectContext:self.dataStore.managedObjectContext];
            Session *newSession = [[Session alloc]initWithEntity:sessionEntityDescription insertIntoManagedObjectContext:self.dataStore.managedObjectContext];
            
            newSession.isStarted = @1;
            
            Employee *employee = [self.dataStore.managedObjectContext executeFetchRequest:employeeFetchRequest error:nil][0];
            [employee addSessionsObject:newSession];
            
            self.passedCustomer.session = newSession;
            self.passedCustomer.session.startTime = [NSDate date];
            self.passedCustomer.session.employeeNameForSessionStart = employee.name;
            
            [self.dataStore saveContext];
            
            [self.startSessionButton setTitle:@"End Session" forState:UIControlStateNormal];
            [self.startSessionButton setTitleColor:[UIColor colorWithRed:0.875 green:0.173 blue:0.290 alpha:1] forState:UIControlStateNormal];
        }
        else if ([self.passedCustomer.session.isStarted boolValue] == YES)
        {
            Employee *employee = [self.dataStore.managedObjectContext executeFetchRequest:employeeFetchRequest error:nil][0];
                    
            self.passedCustomer.session.isStarted = @0;
            [self.startSessionButton setTitle:@"Restart Session" forState:UIControlStateNormal];
            [self.startSessionButton setTitleColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
            self.passedCustomer.session.endTime = [NSDate date];
            self.passedCustomer.session.employeeNameForSessionEnd = employee.name;
            [self.dataStore saveContext];
            
        }
        else if ([self.passedCustomer.session.isStarted boolValue] == NO)
        {
            self.passedCustomer.session.isStarted = @1;
            [self.startSessionButton setTitle:@"End Session" forState:UIControlStateNormal];
            [self.startSessionButton setTitleColor:[UIColor colorWithRed:0.875 green:0.173 blue:0.290 alpha:1] forState:UIControlStateNormal];
            self.passedCustomer.session.startTime = [NSDate date];
            self.passedCustomer.session.endTime = nil;
            [self.dataStore saveContext];
        }
    }
}


@end
