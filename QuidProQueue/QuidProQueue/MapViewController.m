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

@interface MapViewController ()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *mapPinButtons;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) DataStore *dataStore;

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

-(void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    
    self.dataStore = [DataStore sharedInstance];
    
    FAKFontAwesome *mapMarkerIcon = [FAKFontAwesome mapMarkerIconWithSize:30];
    [mapMarkerIcon addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor]];
    UIImage *mapMarkerImage = [mapMarkerIcon imageWithSize:CGSizeMake(30,30)];
    
    //Set Image For Buttons
    
    for (UIButton *mapPin in self.mapPinButtons) {
        [mapPin setImage:mapMarkerImage forState:UIControlStateNormal];
    }
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
    
    //Assign Frame, Color, And Location To Buttons
    
    for (UIButton *mapPin in self.mapPinButtons) {
        
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
            default:
                break;
        }
    }
}

- (IBAction)mapPinPressed:(id)sender
{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SessionsOnMapTableViewController *sessionsOnMapTVC = [storyBoard instantiateViewControllerWithIdentifier:@"SessionsOnMapTableViewController"];
    
    switch (((UIButton *)sender).tag)
    {
        case 0:
            sessionsOnMapTVC.locationArea = @"Ruby instruction tables";
            break;
        case 1:
            sessionsOnMapTVC.locationArea = @"iOS instruction tables";
            break;
        case 2:
            sessionsOnMapTVC.locationArea = @"Instructor table";
            break;
        case 3:
            sessionsOnMapTVC.locationArea = @"Back picnic table";
            break;
        case 4:
            sessionsOnMapTVC.locationArea = @"Center table";
            break;
        case 5:
            sessionsOnMapTVC.locationArea = @"Kitchen";
            break;
        case 6:
            sessionsOnMapTVC.locationArea = @"Left presentation area";
            break;
        case 7:
            sessionsOnMapTVC.locationArea = @"Right presentation area";
        default:
            break;
    }
    
    [self presentViewController:[[UINavigationController alloc]initWithRootViewController:sessionsOnMapTVC] animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark configuration methods for tabBar and buttons

-(UITabBarItem *)tabBarItem
{
    FAKFontAwesome *tabIcon = [FAKFontAwesome mapMarkerIconWithSize:30];
    [tabIcon addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor]];
    UIImage *tabIconImage = [tabIcon imageWithSize:CGSizeMake(30,30)];
    UITabBarItem *tabBarItem = [[UITabBarItem alloc]initWithTitle:@"Area Map" image:tabIconImage selectedImage:tabIconImage];
    
    return tabBarItem;
}

-(void)configureMapPin:(UIButton *)mapPin forNumberOfCustomersForAreaName:(NSString *)areaName
{
    NSFetchRequest *locationFetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Location"];
    NSArray *locationsArray = [self.dataStore.managedObjectContext executeFetchRequest:locationFetchRequest error:nil];
    NSInteger customerCount = 0;
    
    for (Location *location in locationsArray) {
        if ([location.area isEqualToString:areaName]) {
            customerCount = [[location.customers allObjects]count];
        }
    }
    if (customerCount == 0) {
        mapPin.tintColor = [UIColor grayColor];
        mapPin.enabled = NO;
    }
    else if (customerCount > 0 &&  customerCount < 5)
    {
        mapPin.tintColor = [UIColor blackColor];
        mapPin.enabled = YES;
    }
    else if (customerCount > 5)
    {
        mapPin.tintColor = [UIColor colorWithRed:0.875 green:0.173 blue:0.290 alpha:1];
        mapPin.enabled = YES;
    }
}





@end
