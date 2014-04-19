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
@property (weak, nonatomic) IBOutlet UITableViewCell *customerNameCell;
@property (weak, nonatomic) IBOutlet UITextField *customerNameTextField;
@property (weak, nonatomic) IBOutlet UITableViewCell *customerNotesCell;
@property (weak, nonatomic) IBOutlet UITextField *customerNotesTextField;
@property (weak, nonatomic) IBOutlet UITableViewCell *customerLocationCell;
@property (strong, nonatomic) DataStore *dataStore;
@property (weak, nonatomic) IBOutlet UITextField *customerLocationTextField;


@end

@implementation AddCustomerTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
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
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.customerLocationTextField.text = self.createdCustomer.location.area;
    self.customerNameCell.backgroundColor = [UIColor whiteColor];
    self.customerLocationCell.backgroundColor = [UIColor whiteColor];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"AddNewCustomerLocationSegue"]){
        SelectCustomerLocationMapViewController *mapSegueView = segue.destinationViewController;
        mapSegueView.passedCustomer = self.createdCustomer;
    }
}

- (IBAction)doneButtonWasTapped:(id)sender
{
    self.createdCustomer.name = self.customerNameTextField.text;
    self.createdCustomer.notes = self.customerNotesTextField.text;
    
    if ([self.createdCustomer.name isEqualToString:@""] && !self.createdCustomer.location){
        [UIView animateWithDuration:1 animations:^{
            self.customerNameCell.backgroundColor = [UIColor colorWithRed:0.875 green:0.173 blue:0.290 alpha:1]; }];
        [UIView animateWithDuration:1 animations:^{
            self.customerLocationCell.backgroundColor = [UIColor colorWithRed:0.875 green:0.173 blue:0.290 alpha:1]; }];
    }
    else if (self.createdCustomer.location == nil && ![self.createdCustomer.name isEqualToString:@""]){
        [UIView animateWithDuration:1 animations:^{
            self.customerLocationCell.backgroundColor = [UIColor colorWithRed:0.875 green:0.173 blue:0.290 alpha:1]; }];
        [UIView animateWithDuration:1 animations:^{
            self.customerNameCell.backgroundColor = [UIColor whiteColor]; }];
    }
    else if ([self.createdCustomer.name isEqualToString:@""] && self.createdCustomer.location){
        [UIView animateWithDuration:1 animations:^{
            self.customerLocationCell.backgroundColor = [UIColor whiteColor]; }];
        [UIView animateWithDuration:1 animations:^{
            self.customerNameCell.backgroundColor = [UIColor colorWithRed:0.875 green:0.173 blue:0.290 alpha:1]; }];
    }
    else{
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
    [self.dataStore.managedObjectContext deleteObject:self.createdCustomer];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
