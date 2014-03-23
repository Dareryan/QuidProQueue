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

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *containerView;
@property (strong, nonatomic) DataStore *dataStore;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *mapPins;

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

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    for (UIButton *button in self.mapPins) {
        [button removeFromSuperview];
        [button setTranslatesAutoresizingMaskIntoConstraints:YES];
        [self.containerView addSubview:button];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self assignPropertiesToButtons:self.mapPins];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    
    self.dataStore = [DataStore sharedInstance];
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



//- (IBAction)presentationAreaRightLocationButtonTapped:(id)sender
//{
//    [DataStore addLocationWithAreaName:@"Right presentation area" toCustomer:self.passedCustomer inManagedObjectContext:self.dataStore.managedObjectContext];
//
//    [self dismissViewControllerAnimated:YES completion:nil];
//}
//
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
                break;
            case 1:
                mapPin.frame = CGRectMake(81,127, 30, 30);
                break;
            case 2:
                mapPin.frame = CGRectMake(71, 260, 30, 30);
                break;
            case 3:
                mapPin.frame = CGRectMake(241, 294, 30, 30);
                break;
            case 4:
                mapPin.frame = CGRectMake(81, 391, 30, 30);
                break;
            case 5:
                mapPin.frame = CGRectMake(253, 391, 30, 30);
                break;
            case 6:
                mapPin.frame = CGRectMake(44, 544, 30, 30);
                break;
            case 7:
                mapPin.frame = CGRectMake(253, 544, 30, 30);
                break;
            default:
                break;
        }
    }
}


@end
