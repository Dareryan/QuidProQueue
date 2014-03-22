//
//  MapViewController.m
//  QuidProQueue
//
//  Created by Dare Ryan on 3/8/14.
//  Copyright (c) 2014 Dare Ryan. All rights reserved.
//

#import "MapViewController.h"
#import <FAKFontAwesome.h>

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

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:NO];
   
    
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
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.scrollView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contentView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    
   
	// Do any additional setup after loading the view.
}

-(UITabBarItem *)tabBarItem
{
  
    
    FAKFontAwesome *tabIcon = [FAKFontAwesome mapMarkerIconWithSize:30];
    [tabIcon addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor]];
    UIImage *tabIconImage = [tabIcon imageWithSize:CGSizeMake(30,30)];
    UITabBarItem *tabBarItem = [[UITabBarItem alloc]initWithTitle:@"Area Map" image:tabIconImage selectedImage:tabIconImage];
  
    return tabBarItem;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
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


@end
