//
//  SelectCustomerLocationMapViewController.m
//  QuidProQueue
//
//  Created by Dare Ryan on 3/14/14.
//  Copyright (c) 2014 Dare Ryan. All rights reserved.
//

#import "SelectCustomerLocationMapViewController.h"
#import <FAKFontAwesome.h>
#import "DataStore.h"
#import "Location.h"
#import "AddCustomerTableViewController.h"

@interface SelectCustomerLocationMapViewController ()
@property (strong, nonatomic) DataStore *dataStore;
@property (strong, nonatomic) IBOutlet UIButton *rubyTableLocationButton;
@property (strong, nonatomic) IBOutlet UIButton *iOSTableLocationButton;
@property (strong, nonatomic) IBOutlet UIButton *instructorTableLocationButton;
@property (strong, nonatomic) IBOutlet UIButton *backPicnicTableLocationButton;
@property (strong, nonatomic) IBOutlet UIButton *centerTablesLocationButton;
@property (strong, nonatomic) IBOutlet UIButton *kitchenLocationButton;
@property (strong, nonatomic) IBOutlet UIButton *presentationAreaLeftLocationButton;
@property (strong, nonatomic) IBOutlet UIButton *presentationAreaRightLocationButton;
@property (strong, nonatomic) NSArray *locationsArray;

- (IBAction)presentationAreaLeftLocationButtonTapped:(id)sender;
- (IBAction)kitchenLocationButtonTapped:(id)sender;
- (IBAction)rubyTableLocationButtonTapped:(id)sender;
- (IBAction)iOSTableLocationButtonTapped:(id)sender;
- (IBAction)instructorTableLocationButtonTapped:(id)sender;
- (IBAction)backPicnicTableLocationButtonTapped:(id)sender;
- (IBAction)centerTablesLocationButtonTapped:(id)sender;
- (IBAction)presentationAreaRightLocationButtonTapped:(id)sender;


@end

@implementation SelectCustomerLocationMapViewController




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Location"];
    self.locationsArray = [self.dataStore.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dataStore = [DataStore sharedInstance];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    
    
    FAKFontAwesome *mapMarkerIcon = [FAKFontAwesome mapMarkerIconWithSize:30];
    [mapMarkerIcon addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor]];
    UIImage *mapMarkerImage = [mapMarkerIcon imageWithSize:CGSizeMake(30,30)];
    
    [self.rubyTableLocationButton setImage:mapMarkerImage forState:UIControlStateNormal];
    [self.iOSTableLocationButton setImage:mapMarkerImage forState:UIControlStateNormal];
    [self.instructorTableLocationButton setImage:mapMarkerImage forState:UIControlStateNormal];
    [self.backPicnicTableLocationButton setImage:mapMarkerImage forState:UIControlStateNormal];
    [self.centerTablesLocationButton setImage:mapMarkerImage forState:UIControlStateNormal];
    [self.kitchenLocationButton setImage:mapMarkerImage forState:UIControlStateNormal];
    [self.presentationAreaLeftLocationButton setImage:mapMarkerImage forState:UIControlStateNormal];
    [self.presentationAreaRightLocationButton setImage:mapMarkerImage forState:UIControlStateNormal];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
    self.presentationAreaLeftLocationButton.frame = CGRectMake(44, 544, 30, 30);
    //self.presentationAreaLeftLocationButton.backgroundColor = [UIColor colorWithRed:0.298 green:0.792 blue:0.871 alpha:1];
    self.presentationAreaRightLocationButton.frame = CGRectMake(253, 544, 30, 30);
    //self.presentationAreaRightLocationButton.backgroundColor = [UIColor colorWithRed:0.875 green:0.173 blue:0.290 alpha:1];
    self.kitchenLocationButton.frame = CGRectMake(253, 391, 30, 30);
    //self.kitchenLocationButton.backgroundColor = [UIColor colorWithRed:0.039 green:0.259 blue:0.722 alpha:1];
    self.centerTablesLocationButton.frame = CGRectMake(81, 391, 30, 30);
    self.backPicnicTableLocationButton.frame = CGRectMake(241, 294, 30, 30);
    self.instructorTableLocationButton.frame = CGRectMake(71, 260, 30, 30);
    self.iOSTableLocationButton.frame = CGRectMake(81,127, 30, 30);
    self.rubyTableLocationButton.frame = CGRectMake(253, 127, 30, 30);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)presentationAreaLeftLocationButtonTapped:(id)sender {
    
    if ([self.locationsArray count]==0)
    {
        NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Location" inManagedObjectContext:self.dataStore.managedObjectContext];
        
        Location *newLocation = [[Location alloc]initWithEntity:entityDescription insertIntoManagedObjectContext:self.dataStore.managedObjectContext];
        
        newLocation.area = @"Left presentation area";
        
        self.passedCustomer.location = newLocation;
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }else{
        
        for (Location *location in self.locationsArray) {
            if ([location.area isEqualToString:@"Left presentation area"])
            {
                [location addCustomersObject:self.passedCustomer];
                
                [self dismissViewControllerAnimated:YES completion:nil];
                
            }else{
                
                NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Location" inManagedObjectContext:self.dataStore.managedObjectContext];
                
                Location *newLocation = [[Location alloc]initWithEntity:entityDescription insertIntoManagedObjectContext:self.dataStore.managedObjectContext];
                
                newLocation.area = @"Left presentation area";
                
                self.passedCustomer.location = newLocation;
                
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }
    }
}

- (IBAction)kitchenLocationButtonTapped:(id)sender {
    
    if ([self.locationsArray count]==0)
    {
        NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Location" inManagedObjectContext:self.dataStore.managedObjectContext];
        
        Location *newLocation = [[Location alloc]initWithEntity:entityDescription insertIntoManagedObjectContext:self.dataStore.managedObjectContext];
        
        newLocation.area = @"Kitchen";
        
        self.passedCustomer.location = newLocation;
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }else{
        
        for (Location *location in self.locationsArray) {
            if ([location.area isEqualToString:@"Kitchen"])
            {
                [location addCustomersObject:self.passedCustomer];
                
                [self dismissViewControllerAnimated:YES completion:nil];
                
            }else{
                
                NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Location" inManagedObjectContext:self.dataStore.managedObjectContext];
                
                Location *newLocation = [[Location alloc]initWithEntity:entityDescription insertIntoManagedObjectContext:self.dataStore.managedObjectContext];
                
                newLocation.area = @"Kitchen";
                
                self.passedCustomer.location = newLocation;
                
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }
    }
}

- (IBAction)rubyTableLocationButtonTapped:(id)sender {
    
    if ([self.locationsArray count]==0)
    {
        NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Location" inManagedObjectContext:self.dataStore.managedObjectContext];
        
        Location *newLocation = [[Location alloc]initWithEntity:entityDescription insertIntoManagedObjectContext:self.dataStore.managedObjectContext];
        
        newLocation.area = @"Ruby instruction tables";
        
        self.passedCustomer.location = newLocation;
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }else{
        
        for (Location *location in self.locationsArray) {
            if ([location.area isEqualToString:@"Ruby instruction tables"])
            {
                [location addCustomersObject:self.passedCustomer];
                
                [self dismissViewControllerAnimated:YES completion:nil];
                
            }else{
                
                NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Location" inManagedObjectContext:self.dataStore.managedObjectContext];
                
                Location *newLocation = [[Location alloc]initWithEntity:entityDescription insertIntoManagedObjectContext:self.dataStore.managedObjectContext];
                
                newLocation.area = @"Ruby instruction tables";
                
                self.passedCustomer.location = newLocation;
                
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }
    }
}

- (IBAction)iOSTableLocationButtonTapped:(id)sender {
    
    if ([self.locationsArray count]==0)
    {
        NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Location" inManagedObjectContext:self.dataStore.managedObjectContext];
        
        Location *newLocation = [[Location alloc]initWithEntity:entityDescription insertIntoManagedObjectContext:self.dataStore.managedObjectContext];
        
        newLocation.area = @"iOS instruction tables";
        
        self.passedCustomer.location = newLocation;
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }else{
        
        for (Location *location in self.locationsArray) {
            if ([location.area isEqualToString:@"iOS instruction tables"])
            {
                [location addCustomersObject:self.passedCustomer];
                
                [self dismissViewControllerAnimated:YES completion:nil];
                
            }else{
                
                NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Location" inManagedObjectContext:self.dataStore.managedObjectContext];
                
                Location *newLocation = [[Location alloc]initWithEntity:entityDescription insertIntoManagedObjectContext:self.dataStore.managedObjectContext];
                
                newLocation.area = @"iOS instruction tables";
                
                self.passedCustomer.location = newLocation;
                
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }
    }
    
}

- (IBAction)instructorTableLocationButtonTapped:(id)sender {
    
    if ([self.locationsArray count]==0)
    {
        NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Location" inManagedObjectContext:self.dataStore.managedObjectContext];
        
        Location *newLocation = [[Location alloc]initWithEntity:entityDescription insertIntoManagedObjectContext:self.dataStore.managedObjectContext];
        
        newLocation.area = @"Instructor table";
        
        self.passedCustomer.location = newLocation;
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }else{
        
        for (Location *location in self.locationsArray) {
            if ([location.area isEqualToString:@"Instructor table"])
            {
                [location addCustomersObject:self.passedCustomer];
                
                [self dismissViewControllerAnimated:YES completion:nil];
                
            }else{
                
                NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Location" inManagedObjectContext:self.dataStore.managedObjectContext];
                
                Location *newLocation = [[Location alloc]initWithEntity:entityDescription insertIntoManagedObjectContext:self.dataStore.managedObjectContext];
                
                newLocation.area = @"Instructor table";
                
                self.passedCustomer.location = newLocation;
                
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }
    }
}

- (IBAction)backPicnicTableLocationButtonTapped:(id)sender {
    
    if ([self.locationsArray count]==0)
    {
        NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Location" inManagedObjectContext:self.dataStore.managedObjectContext];
        
        Location *newLocation = [[Location alloc]initWithEntity:entityDescription insertIntoManagedObjectContext:self.dataStore.managedObjectContext];
        
        newLocation.area = @"Back picnic table";
        
        self.passedCustomer.location = newLocation;
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }else{
        
        for (Location *location in self.locationsArray) {
            if ([location.area isEqualToString:@"Back picnic table"])
            {
                [location addCustomersObject:self.passedCustomer];
                
                [self dismissViewControllerAnimated:YES completion:nil];
                
            }else{
                
                NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Location" inManagedObjectContext:self.dataStore.managedObjectContext];
                
                Location *newLocation = [[Location alloc]initWithEntity:entityDescription insertIntoManagedObjectContext:self.dataStore.managedObjectContext];
                
                newLocation.area = @"Back picnic table";
                
                self.passedCustomer.location = newLocation;
                
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }
    }
}

- (IBAction)centerTablesLocationButtonTapped:(id)sender {
    
    if ([self.locationsArray count]==0)
    {
        NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Location" inManagedObjectContext:self.dataStore.managedObjectContext];
        
        Location *newLocation = [[Location alloc]initWithEntity:entityDescription insertIntoManagedObjectContext:self.dataStore.managedObjectContext];
        
        newLocation.area = @"Center table";
        
        self.passedCustomer.location = newLocation;
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }else{
        
        for (Location *location in self.locationsArray) {
            
            if ([location.area isEqualToString:@"Center table"])
            {
                [location addCustomersObject:self.passedCustomer];
                
                [self dismissViewControllerAnimated:YES completion:nil];
                
            }else{
                
                NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Location" inManagedObjectContext:self.dataStore.managedObjectContext];
                
                Location *newLocation = [[Location alloc]initWithEntity:entityDescription insertIntoManagedObjectContext:self.dataStore.managedObjectContext];
                
                newLocation.area = @"Center table";
                
                self.passedCustomer.location = newLocation;
                
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }
    }
}

- (IBAction)presentationAreaRightLocationButtonTapped:(id)sender {
    
    if ([self.locationsArray count]==0)
    {
        NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Location" inManagedObjectContext:self.dataStore.managedObjectContext];
        
        Location *newLocation = [[Location alloc]initWithEntity:entityDescription insertIntoManagedObjectContext:self.dataStore.managedObjectContext];
        
        newLocation.area = @"Right presentation area";
        
        self.passedCustomer.location = newLocation;
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }else{
        
        for (Location *location in self.locationsArray) {
            if ([location.area isEqualToString:@"Right presentation area"])
            {
                [location addCustomersObject:self.passedCustomer];
                
                [self dismissViewControllerAnimated:YES completion:nil];
                
            }else{
                NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Location" inManagedObjectContext:self.dataStore.managedObjectContext];
                
                Location *newLocation = [[Location alloc]initWithEntity:entityDescription insertIntoManagedObjectContext:self.dataStore.managedObjectContext];
                
                newLocation.area = @"Right presentation area";
                
                self.passedCustomer.location = newLocation;
                
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }
    }
}
@end
