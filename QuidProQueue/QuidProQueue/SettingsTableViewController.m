//
//  SettingsTableViewController.m
//  QuidProQueue
//
//  Created by Dare Ryan on 3/14/14.
//  Copyright (c) 2014 Dare Ryan. All rights reserved.
//

#import "SettingsTableViewController.h"
#import <FAKFontAwesome.h>
#import <FAKIonIcons.h>
#import "DataStore.h"
#import "Employee.h"

@interface SettingsTableViewController ()

@property (strong, nonatomic) DataStore *dataStore;
@property (strong, nonatomic) Employee *employee;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UIButton *logInButton;

- (IBAction)logInButtonPressed:(id)sender;

@end

@implementation SettingsTableViewController

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
    [self.logInButton setTitleColor:[[[[UIApplication sharedApplication] delegate] window] tintColor] forState:UIControlStateNormal];
    [self configureLogInButtonOnLoad];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dataStore = [DataStore sharedInstance];
     [self.logInButton setTitleColor:[[[[UIApplication sharedApplication] delegate] window] tintColor] forState:UIControlStateNormal];
    [self configureLogInButtonOnLoad];
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
     [self.logInButton setTitleColor:[[[[UIApplication sharedApplication] delegate] window] tintColor] forState:UIControlStateNormal];
    [self configureLogInButtonOnLoad];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (IBAction)logInButtonPressed:(id)sender
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Employee"];
    
    //check to see if there is no user logged in
    if ([[self.dataStore.managedObjectContext executeFetchRequest:fetchRequest error:nil] count] == 0)
    {
        [self login];
        [self.userNameTextField resignFirstResponder];
    }
    //check to see if a user is already logged in
    else if ([[self.dataStore.managedObjectContext executeFetchRequest:fetchRequest error:nil] count] != 0)
    {
        [self logout];
        [self.userNameTextField resignFirstResponder];
    }
}

-(UITabBarItem *)tabBarItem
{
    
    FAKIonIcons *tabIcon = [FAKIonIcons gearBIconWithSize:30];
    [tabIcon addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor]];
    UIImage *tabIconImage = [tabIcon imageWithSize:CGSizeMake(30,30)];
    
    
    UITabBarItem *tabBarItem = [[UITabBarItem alloc]initWithTitle:@"Settings" image:tabIconImage selectedImage:tabIconImage];
    
    return tabBarItem;
}

-(void)configureLogInButtonOnLoad

{
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Employee"];
    
    if ([[self.dataStore.managedObjectContext executeFetchRequest:fetchRequest error:nil] count] == 0) {
        [self.logInButton setTitle:@"Log in" forState:UIControlStateNormal];
        self.logInButton.titleLabel.textColor = [[[[UIApplication sharedApplication] delegate] window] tintColor];
        self.userNameTextField.text = @"";
    }
    else
    {
        Employee *loggedInEmployee = [self.dataStore.managedObjectContext executeFetchRequest:fetchRequest error:nil][0];
        [self.logInButton setTitle:@"Log out" forState:UIControlStateNormal];
        [self.logInButton setTitleColor:[UIColor colorWithRed:0.875 green:0.173 blue:0.290 alpha:1] forState:UIControlStateNormal];
        self.userNameTextField.text = loggedInEmployee.name;
    }
}

-(void)login
{
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Employee" inManagedObjectContext:self.dataStore.managedObjectContext];
    self.employee = [[Employee alloc]initWithEntity:entityDescription insertIntoManagedObjectContext:self.dataStore.managedObjectContext];
    self.employee.name = self.userNameTextField.text;
    [self.logInButton setTitle:@"Log out" forState:UIControlStateNormal];
    [self.logInButton setTitleColor:[UIColor colorWithRed:0.875 green:0.173 blue:0.290 alpha:1] forState:UIControlStateNormal];
    [self.dataStore saveContext];
}

-(void)logout
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Employee"];
    Employee *employee = [self.dataStore.managedObjectContext executeFetchRequest:fetchRequest error:nil][0];
    self.userNameTextField.text = @"";
    [self.logInButton setTitle:@"Log in" forState:UIControlStateNormal];
    [self.logInButton setTitleColor:[[[[UIApplication sharedApplication] delegate] window] tintColor] forState:UIControlStateNormal];
    [self.dataStore.managedObjectContext deleteObject:employee];
    [self.dataStore saveContext];
}

-(void)viewWillUnload{
    [super viewWillUnload];
     [self.logInButton setTitleColor:[UIColor colorWithRed:0.875 green:0.173 blue:0.290 alpha:1] forState:UIControlStateNormal];
}

@end
