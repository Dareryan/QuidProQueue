//
//  MapViewController.m
//  QuidProQueue
//
//  Created by Dare Ryan on 3/8/14.
//  Copyright (c) 2014 Dare Ryan. All rights reserved.
//

#import "MapViewController.h"
#import <FAKFontAwesome.h>
#import "DataStore.h"
#import "SessionsOnMapTableViewController.h"
#import "Session.h"

@interface MapViewController ()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *mapPinButtons;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) DataStore *dataStore;
@property (strong, nonatomic) NSMutableArray *arrayWithCustomersWithEndedSessionsRemoved;
@property (strong, nonatomic) NSString *locationArea;

- (IBAction)mapPinPressed:(id)sender;

@end

@implementation MapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    for (UIButton *button in self.mapPinButtons) {
        [button removeFromSuperview];
        //        [button setTranslatesAutoresizingMaskIntoConstraints:YES];
        [self.contentView addSubview:button];
    }
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    
    self.dataStore = [DataStore sharedInstance];
    
    [self assignPropertiesToButtons:self.mapPinButtons];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.scrollView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.contentView setTranslatesAutoresizingMaskIntoConstraints:NO];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self assignPropertiesToButtons:self.mapPinButtons];
}

- (IBAction)mapPinPressed:(id)sender
{
    
    
    switch (((UIButton *)sender).tag)
    {
        case 0:
            self.locationArea = @"Ruby instruction tables";
            break;
        case 1:
            self.locationArea = @"iOS instruction tables";
            break;
        case 2:
            self.locationArea = @"Instructor table";
            break;
        case 3:
            self.locationArea = @"Back picnic table";
            break;
        case 4:
            self.locationArea = @"Center table";
            break;
        case 5:
            self.locationArea = @"Kitchen";
            break;
        case 6:
            self.locationArea = @"Left presentation area";
            break;
        case 7:
            self.locationArea = @"Right presentation area";
        default:
            break;
    }
    
    [self performSegueWithIdentifier:@"CustomersAtLocationSegue" sender:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"CustomersAtLocationSegue"])
    {
        if ([segue.destinationViewController isKindOfClass:[UINavigationController class]]) {
            UINavigationController *navController = segue.destinationViewController;
            if ([navController.topViewController isKindOfClass:[SessionsOnMapTableViewController class]])
            {
                SessionsOnMapTableViewController *sessionsOnMapTVC = (SessionsOnMapTableViewController *)navController.topViewController;
                NSLog(@"%@", self.locationArea);
                sessionsOnMapTVC.locationArea = self.locationArea;
            }
            else
            {
                NSLog(@"Destination is not a SessionsOnMapTableViewController. Abort Segue.");
            }
        }
    }
}
#pragma mark configuration method for tabBarButton

-(UITabBarItem *)tabBarItem
{
    FAKFontAwesome *tabIcon = [FAKFontAwesome mapMarkerIconWithSize:30];
    [tabIcon addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor]];
    UIImage *tabIconImage = [tabIcon imageWithSize:CGSizeMake(30,30)];
    UITabBarItem *tabBarItem = [[UITabBarItem alloc]initWithTitle:@"Area Map" image:tabIconImage selectedImage:tabIconImage];
    
    return tabBarItem;
}

#pragma mark custom methods

//Determine color of buttons based on number of customers in a location

-(void)configureMapPin:(UIButton *)mapPin forNumberOfCustomersForAreaName:(NSString *)areaName
{
    NSFetchRequest *locationFetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Location"];
    NSArray *locationsArray = [self.dataStore.managedObjectContext executeFetchRequest:locationFetchRequest error:nil];
    NSInteger customerCount = 0;
    NSMutableArray *arrayWithEndedSessionsRemoved = [[NSMutableArray alloc]init];
    
    
    for (Location *location in locationsArray) {
        if ([location.area isEqualToString:areaName]) {
            //customerCount = [[location.customers allObjects]count];
            for (Customer *presentCustomer in location.customers)
            {
                if (!presentCustomer.session || [presentCustomer.session.isStarted boolValue] == YES)
                {
                    [arrayWithEndedSessionsRemoved addObject:presentCustomer];
                }
            }
            customerCount = [arrayWithEndedSessionsRemoved count];
        }
    }
    if (customerCount < 1) {
        mapPin.tintColor = [UIColor grayColor];
        mapPin.enabled = NO;
    }
    else if (customerCount > 0 && customerCount < 5)
    {
        mapPin.tintColor = [UIColor blackColor];
        mapPin.enabled = YES;
    }
    else if (customerCount >= 5)
    {
        mapPin.tintColor = [UIColor colorWithRed:0.875 green:0.173 blue:0.290 alpha:1];
        mapPin.enabled = YES;
    }
}

//Assign frame, location, icon, and color to all buttons.

-(void)assignPropertiesToButtons:(NSArray *)buttons
{
    FAKFontAwesome *mapMarkerIcon = [FAKFontAwesome mapMarkerIconWithSize:30];
    [mapMarkerIcon addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor]];
    UIImage *mapMarkerImage = [mapMarkerIcon imageWithSize:CGSizeMake(30,30)];
    
    for (UIButton *mapPin in buttons)
    {
        [mapPin setImage:mapMarkerImage forState:UIControlStateNormal];
    }
    
    for (UIButton *mapPin in buttons) {
        
        switch (mapPin.tag) {
            case 0:
                mapPin.frame = CGRectMake(253, 127, 30, 30);
                [self configureMapPin:mapPin forNumberOfCustomersForAreaName:@"Ruby instruction tables"];
                break;
            case 1:
                mapPin.frame = CGRectMake(81,127, 30, 30);
                [self configureMapPin:mapPin forNumberOfCustomersForAreaName:@"iOS instruction tables"];
                break;
            case 2:
                mapPin.frame = CGRectMake(71, 260, 30, 30);
                [self configureMapPin:mapPin forNumberOfCustomersForAreaName:@"Instructor table"];
                break;
            case 3:
                mapPin.frame = CGRectMake(241, 294, 30, 30);
                [self configureMapPin:mapPin forNumberOfCustomersForAreaName:@"Back picnic table"];
                break;
            case 4:
                mapPin.frame = CGRectMake(81, 391, 30, 30);
                [self configureMapPin:mapPin forNumberOfCustomersForAreaName:@"Center table"];
                break;
            case 5:
                mapPin.frame = CGRectMake(253, 391, 30, 30);
                [self configureMapPin:mapPin forNumberOfCustomersForAreaName:@"Kitchen"];
                break;
            case 6:
                mapPin.frame = CGRectMake(44, 544, 30, 30);
                [self configureMapPin:mapPin forNumberOfCustomersForAreaName:@"Left presentation area"];
                break;
            case 7:
                mapPin.frame = CGRectMake(253, 544, 30, 30);
                [self configureMapPin:mapPin forNumberOfCustomersForAreaName:@"Right presentation area"];
                break;
            default:
                break;
        }
    }
}



@end
