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
    
    if ([self.passedCustomer.session.isStarted boolValue] == NO && [self.passedCustomer.session.isEnded boolValue] == NO){
        [self.startSessionButton setTitle:@"Start Session" forState:UIControlStateNormal];
        [self.startSessionButton setTitleColor:nil forState:UIControlStateNormal];
    }
    else if ([self.passedCustomer.session.isStarted boolValue] == YES){
        [self.startSessionButton setTitle:@"End Session" forState:UIControlStateNormal];
        [self.startSessionButton setTitleColor:[UIColor colorWithRed:0.875 green:0.173 blue:0.290 alpha:1] forState:UIControlStateNormal];
    }
    else if ([self.passedCustomer.session.isStarted boolValue] == NO && [self.passedCustomer.session.isEnded boolValue] == YES){
        [self.startSessionButton setTitle:@"Restart Session" forState:UIControlStateNormal];
        [self.startSessionButton setTitleColor:nil forState:UIControlStateNormal];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dataStore = [DataStore sharedInstance];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

#pragma mark - custom methods

- (IBAction)startSessionButtonPressed:(id)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (![defaults objectForKey:@"User"]){
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Please log-in to start and end sessions" message:@"In order to start or end a session, you must log-in in the settings tab" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
    else{
        NSFetchRequest *employeeFetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Employee"];
        NSPredicate *userNamePreidcate = [NSPredicate predicateWithFormat:@"name = %@", [defaults objectForKey:@"User"]];
        employeeFetchRequest.predicate = userNamePreidcate;
        
        if ([[self.dataStore.managedObjectContext executeFetchRequest:employeeFetchRequest error:nil]count] == 0){
            NSEntityDescription *employeeDescription = [NSEntityDescription entityForName:@"Employee" inManagedObjectContext:self.dataStore.managedObjectContext];
            
            Employee *newEmployee = [[Employee alloc]initWithEntity:employeeDescription insertIntoManagedObjectContext:self.dataStore.managedObjectContext];
            
            newEmployee.name = [defaults objectForKey:@"User"];
        }
        if (!self.passedCustomer.session || ([self.passedCustomer.session.isStarted boolValue] == NO && [self.passedCustomer.session.isEnded boolValue] == NO)){
            NSEntityDescription *sessionEntityDescription = [NSEntityDescription entityForName:@"Session" inManagedObjectContext:self.dataStore.managedObjectContext];
            
            Session *newSession = [[Session alloc]initWithEntity:sessionEntityDescription insertIntoManagedObjectContext:self.dataStore.managedObjectContext];
            
            newSession.isStarted = @1;
            newSession.isEnded = @0;
            
            Employee *employee = [self.dataStore.managedObjectContext executeFetchRequest:employeeFetchRequest error:nil][0];
            [employee addSessionsObject:newSession];
            
            self.passedCustomer.session = newSession;
            self.passedCustomer.session.startTime = [NSDate date];
            self.passedCustomer.session.employeeNameForSessionStart = employee.name;
            self.passedCustomer.lastEdited = [NSDate date];
            
            [self.dataStore saveContext];
            
            [self.startSessionButton setTitle:@"End Session" forState:UIControlStateNormal];
            [self.startSessionButton setTitleColor:[UIColor colorWithRed:0.875 green:0.173 blue:0.290 alpha:1] forState:UIControlStateNormal];
        }
        else if ([self.passedCustomer.session.isStarted boolValue] == NO && [self.passedCustomer.session.isEnded boolValue] == YES){
            Employee *employee = [self.dataStore.managedObjectContext executeFetchRequest:employeeFetchRequest error:nil][0];
            
            self.passedCustomer.session.isStarted = @1;
            self.passedCustomer.session.isEnded = @0;
            [self.startSessionButton setTitleColor:[UIColor colorWithRed:0.875 green:0.173 blue:0.290 alpha:1] forState:UIControlStateNormal];
            [self.startSessionButton setTitle:@"End Session" forState:UIControlStateNormal];
            
            self.passedCustomer.session.startTime = [NSDate date];
            self.passedCustomer.session.employeeNameForSessionStart = employee.name;
            self.passedCustomer.lastEdited = [NSDate date];
            [self.dataStore saveContext];
        }
        else if ([self.passedCustomer.session.isStarted boolValue] == YES && [self.passedCustomer.session.isEnded boolValue] == NO){
            
            Employee *employee = [self.dataStore.managedObjectContext executeFetchRequest:employeeFetchRequest error:nil][0];
            
            [self.startSessionButton setTitleColor:nil forState:UIControlStateNormal];
            [self.startSessionButton setTitle:@"Restart Session" forState:UIControlStateNormal];
            
            self.passedCustomer.session.isStarted = @0;
            self.passedCustomer.session.isEnded = @1;
            self.passedCustomer.session.employeeNameForSessionEnd = employee.name;
            self.passedCustomer.session.endTime = [NSDate date];
            self.passedCustomer.lastEdited = [NSDate date];
            
            [self.dataStore saveContext];
        }
    }
}


@end
