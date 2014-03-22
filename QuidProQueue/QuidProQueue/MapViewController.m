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
#import "SessionsOnMapViewController.h"

@interface MapViewController ()

@property (strong, nonatomic) IBOutlet UIButton *rubyTableLocationButton;
@property (strong, nonatomic) IBOutlet UIButton *iOSTableLocationButton;
@property (strong, nonatomic) IBOutlet UIButton *instructorTableLocationButton;
@property (strong, nonatomic) IBOutlet UIButton *backPicnicTableLocationButton;
@property (strong, nonatomic) IBOutlet UIButton *centerTablesLocationButton;
@property (strong, nonatomic) IBOutlet UIButton *kitchenLocationButton;
@property (strong, nonatomic) IBOutlet UIButton *presentationAreaLeftLocationButton;
@property (strong, nonatomic) IBOutlet UIButton *presentationAreaRightLocationButton;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) DataStore *dataStore;

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
    
    [self.rubyTableLocationButton setImage:mapMarkerImage forState:UIControlStateNormal];
    [self.iOSTableLocationButton setImage:mapMarkerImage forState:UIControlStateNormal];
    [self.instructorTableLocationButton setImage:mapMarkerImage forState:UIControlStateNormal];
    [self.backPicnicTableLocationButton setImage:mapMarkerImage forState:UIControlStateNormal];
    [self.centerTablesLocationButton setImage:mapMarkerImage forState:UIControlStateNormal];
    [self.kitchenLocationButton setImage:mapMarkerImage forState:UIControlStateNormal];
    [self.presentationAreaLeftLocationButton setImage:mapMarkerImage forState:UIControlStateNormal];
    [self.presentationAreaRightLocationButton setImage:mapMarkerImage forState:UIControlStateNormal];
    
    [self configureMapPin:self.rubyTableLocationButton forNumberOfCustomersForAreaName:@"Ruby instruction tables"];
    [self configureMapPin:self.iOSTableLocationButton forNumberOfCustomersForAreaName:@"iOS instruction tables"];
    [self configureMapPin:self.instructorTableLocationButton forNumberOfCustomersForAreaName:@"Instructor table"];
    [self configureMapPin:self.backPicnicTableLocationButton forNumberOfCustomersForAreaName:@"Back picnic table"];
    [self configureMapPin:self.centerTablesLocationButton forNumberOfCustomersForAreaName:@"Center table"];
    [self configureMapPin:self.kitchenLocationButton forNumberOfCustomersForAreaName:@"Kitchen"];
    [self configureMapPin:self.presentationAreaLeftLocationButton forNumberOfCustomersForAreaName:@"Left presentation area"];
    [self configureMapPin:self.presentationAreaRightLocationButton forNumberOfCustomersForAreaName:@"Right presentation area"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.scrollView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contentView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    
    
    
	// Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.presentationAreaLeftLocationButton.frame = CGRectMake(44, 544, 30, 30);
    self.presentationAreaRightLocationButton.frame = CGRectMake(253, 544, 30, 30);
    self.kitchenLocationButton.frame = CGRectMake(253, 391, 30, 30);
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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    SessionsOnMapViewController *sessionsOnMapVC = [segue destinationViewController];
    
    if ([segue.identifier isEqualToString:@"presentationAreaLeftLocationSegue"])
    {
        sessionsOnMapVC.locationArea = @"Left presentation area";
    }
    else if ([segue.identifier isEqualToString:@"kitchenLocationSegue"])
    {
        sessionsOnMapVC.locationArea = @"Kitchen";
    }
    else if ([segue.identifier isEqualToString:@"rubyTableLocationSegue"])
    {
        sessionsOnMapVC.locationArea = @"Ruby instruction tables";
    }
    else if ([segue.identifier isEqualToString:@"iOSTableLocationSegue"])
    {
        sessionsOnMapVC.locationArea = @"iOS instruction tables";
    }
    else if ([segue.identifier isEqualToString:@"instructorTableLocationSegue"])
    {
        sessionsOnMapVC.locationArea = @"Instructor table";
    }
    else if ([segue.identifier isEqualToString:@"backPicnicTableLocationSegue"])
    {
        sessionsOnMapVC.locationArea = @"Back picnic table";
    }
    else if ([segue.identifier isEqualToString:@"centerTablesLocationSegue"])
    {
        sessionsOnMapVC.locationArea = @"Center table";
    }
    else if ([segue.identifier isEqualToString:@"presentationAreaRightLocationSegue"])
    {
        sessionsOnMapVC.locationArea = @"Right presentation area";
    }
    
    
}

#pragma mark configuration methods

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
