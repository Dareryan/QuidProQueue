//
//  AddCustomerTableViewController.m
//  QuidProQueue
//
//  Created by Dare Ryan on 3/8/14.
//  Copyright (c) 2014 Dare Ryan. All rights reserved.
//

#import "AddCustomerTableViewController.h"
#import "Customer.h"
#import "DataStore.h"
#import "SelectCustomerLocationMapViewController.h"

@interface AddCustomerTableViewController ()<UITextFieldDelegate>

- (IBAction)doneButtonWasTapped:(id)sender;
- (IBAction)cancelButtonWasTapped:(id)sender;
@property (strong, nonatomic) IBOutlet UITableViewCell *customerNameCell;
@property (strong, nonatomic) IBOutlet UITextField *customerNameTextField;
@property (strong, nonatomic) IBOutlet UITableViewCell *customerNotesCell;
@property (strong, nonatomic) IBOutlet UITextField *customerNotesTextField;
@property (strong, nonatomic) IBOutlet UITableViewCell *customerLocationCell;
@property (strong, nonatomic) DataStore *dataStore;
@property (strong, nonatomic) IBOutlet UITextField *customerLocationTextField;


@end

@implementation AddCustomerTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dataStore = [DataStore sharedInstance];
    self.customerNameTextField.delegate = self;
    self.customerNotesTextField.delegate = self;
    self.customerLocationTextField.enabled = NO;
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Customer" inManagedObjectContext:self.dataStore.managedObjectContext];
    self.createdCustomer = [[Customer alloc]initWithEntity:entityDescription insertIntoManagedObjectContext:self.dataStore.managedObjectContext];
    
    
    //    self.customerLocationCell.backgroundColor = [UIColor colorWithRed:0.875 green:0.173 blue:0.290 alpha:1];
    //    self.customerNotesCell.backgroundColor = [UIColor colorWithRed:0.875 green:0.173 blue:0.290 alpha:1];
    //    self.customerNameCell.backgroundColor = [UIColor colorWithRed:0.875 green:0.173 blue:0.290 alpha:1];
    
    
    
    
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.customerLocationTextField.text = self.createdCustomer.location.area;
    
    self.customerNameCell.backgroundColor = [UIColor whiteColor];
    self.customerLocationCell.backgroundColor = [UIColor whiteColor];
    
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
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return 1;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"AddNewCustomerLocationSegue"])
    {
        SelectCustomerLocationMapViewController *mapSegueView = segue.destinationViewController;
        mapSegueView.passedCustomer = self.createdCustomer;
    }
}
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
//
//    // Configure the cell...
//
//    return cell;
//}

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

- (IBAction)doneButtonWasTapped:(id)sender
{
    self.createdCustomer.name = self.customerNameTextField.text;
    self.createdCustomer.notes = self.customerNotesTextField.text;
    
    if ([self.createdCustomer.name isEqualToString:@""] && !self.createdCustomer.location)
    {
        [UIView animateWithDuration:1 animations:^{
            self.customerNameCell.backgroundColor = [UIColor colorWithRed:0.875 green:0.173 blue:0.290 alpha:1]; }];
        [UIView animateWithDuration:1 animations:^{
            self.customerLocationCell.backgroundColor = [UIColor colorWithRed:0.875 green:0.173 blue:0.290 alpha:1]; }];
    }
    else if (self.createdCustomer.location == nil && ![self.createdCustomer.name isEqualToString:@""])
    {
        [UIView animateWithDuration:1 animations:^{
            self.customerLocationCell.backgroundColor = [UIColor colorWithRed:0.875 green:0.173 blue:0.290 alpha:1]; }];
        [UIView animateWithDuration:1 animations:^{
            self.customerNameCell.backgroundColor = [UIColor whiteColor]; }];
    }
    else if ([self.createdCustomer.name isEqualToString:@""] && self.createdCustomer.location)
    {
        [UIView animateWithDuration:1 animations:^{
            self.customerLocationCell.backgroundColor = [UIColor whiteColor]; }];
        [UIView animateWithDuration:1 animations:^{
            self.customerNameCell.backgroundColor = [UIColor colorWithRed:0.875 green:0.173 blue:0.290 alpha:1]; }];
    }
    else
    {
        self.createdCustomer.arrivalTime = [NSDate date];
        [self.dataStore saveContext];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    self.createdCustomer.name = self.customerNameTextField.text;
    self.createdCustomer.notes = self.customerNotesTextField.text;
    
    [textField resignFirstResponder];
    
    return YES;
}

- (IBAction)cancelButtonWasTapped:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.dataStore.managedObjectContext deleteObject:self.createdCustomer];
}
@end
