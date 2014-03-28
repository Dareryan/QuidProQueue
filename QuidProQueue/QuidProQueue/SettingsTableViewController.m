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


@interface SettingsTableViewController ()

@property (strong, nonatomic) DataStore *dataStore;
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
    [self configureLogInButtonOnLoad];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dataStore = [DataStore sharedInstance];
   
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
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
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    
    //check to see if there is no user logged in
    if (![defaults objectForKey:@"User"])
    {
        [self login];
        [self.userNameTextField resignFirstResponder];
    }
    //check to see if a user is already logged in
    else
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
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (![defaults objectForKey:@"User"]) {
        [self.logInButton setTitle:@"Log in" forState:UIControlStateNormal];
        [self.logInButton setTitleColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
        self.userNameTextField.text = @"";
    }
    else
    {
        [self.logInButton setTitle:@"Log out" forState:UIControlStateNormal];
        [self.logInButton setTitleColor:[UIColor colorWithRed:0.875 green:0.173 blue:0.290 alpha:1] forState:UIControlStateNormal];
        NSLog(@"%@", [defaults objectForKey:@"User"]);
        self.userNameTextField.text = [defaults objectForKey:@"User"];
    }
}

-(void)login
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [self.logInButton setTitle:@"Log out" forState:UIControlStateNormal];
    [self.logInButton setTitleColor:[UIColor colorWithRed:0.875 green:0.173 blue:0.290 alpha:1] forState:UIControlStateNormal];
    [defaults setObject:self.userNameTextField.text forKey:@"User"];
    [defaults synchronize];
    NSLog(@"%@", [defaults objectForKey:@"User"]);
}

-(void)logout
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.userNameTextField.text = @"";
    [self.logInButton setTitle:@"Log in" forState:UIControlStateNormal];
    [self.logInButton setTitleColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
    [defaults removeObjectForKey:@"User"];
    [defaults synchronize];
    
}

-(void)viewWillUnload{
    [super viewWillUnload];
    [self.logInButton setTitleColor:[UIColor colorWithRed:0.875 green:0.173 blue:0.290 alpha:1] forState:UIControlStateNormal];
}

@end
