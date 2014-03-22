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
@property (strong, nonatomic) IBOutlet UITextField *userNameTextField;
@property (strong, nonatomic) IBOutlet UIButton *logInButton;

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
    
    self.dataStore = [DataStore sharedInstance];
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Employee"];
    
    
    if ([[self.dataStore.managedObjectContext executeFetchRequest:fetchRequest error:nil] count] == 0) {
        [self.logInButton setTitle:@"Log in" forState:UIControlStateNormal];
        self.logInButton.titleLabel.textColor = [UIColor blueColor];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
   
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(UITabBarItem *)tabBarItem
{
        
    FAKIonIcons *tabIcon = [FAKIonIcons gearBIconWithSize:30];
    [tabIcon addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor]];
    UIImage *tabIconImage = [tabIcon imageWithSize:CGSizeMake(30,30)];
    
    
    UITabBarItem *tabBarItem = [[UITabBarItem alloc]initWithTitle:@"Settings" image:tabIconImage selectedImage:tabIconImage];
    
    return tabBarItem;
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return 1;
}

- (IBAction)logInButtonPressed:(id)sender
{
    self.dataStore = [DataStore sharedInstance];
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Employee"];
    
    if ([[self.dataStore.managedObjectContext executeFetchRequest:fetchRequest error:nil] count] == 0)
    {
        NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Employee" inManagedObjectContext:self.dataStore.managedObjectContext];
        self.employee = [[Employee alloc]initWithEntity:entityDescription insertIntoManagedObjectContext:self.dataStore.managedObjectContext];
        self.employee.name = self.userNameTextField.text;
        [self.logInButton setTitle:@"Log out" forState:UIControlStateNormal];
        [self.logInButton setTitleColor:[UIColor colorWithRed:0.875 green:0.173 blue:0.290 alpha:1] forState:UIControlStateNormal];
        [self.dataStore saveContext];
        [self.userNameTextField resignFirstResponder];
    }
    else if ([[self.dataStore.managedObjectContext executeFetchRequest:fetchRequest error:nil] count] != 0)
    {
        self.employee = [self.dataStore.managedObjectContext executeFetchRequest:fetchRequest error:nil][0];
        self.userNameTextField.text = @"";
        [self.logInButton setTitle:@"Log in" forState:UIControlStateNormal];
        [self.logInButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [self.dataStore.managedObjectContext deleteObject:self.employee];
        [self.dataStore saveContext];
        [self.userNameTextField resignFirstResponder];
    }
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
