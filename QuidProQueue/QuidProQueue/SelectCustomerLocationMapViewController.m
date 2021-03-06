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


@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (strong, nonatomic) DataStore *dataStore;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *mapPins;
- (IBAction)mapPinPressed:(id)sender;

@end

@implementation SelectCustomerLocationMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
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
        //NSLog(@"%f, %f",button.frame.origin.x, button.frame.origin.y);
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self assignPropertiesToButtons:self.mapPins];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    
    self.dataStore = [DataStore sharedInstance];
}

- (IBAction)mapPinPressed:(id)sender
{
    UIButton *selectedButton = sender;
    switch (selectedButton.tag) {
        case 0:
            [DataStore addLocationWithAreaName:@"Ruby instruction tables" toCustomer:self.passedCustomer inManagedObjectContext:self.dataStore.managedObjectContext];
            
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
        case 1:
            [DataStore addLocationWithAreaName:@"iOS instruction tables" toCustomer:self.passedCustomer inManagedObjectContext:self.dataStore.managedObjectContext];
            
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
        case 2:
            [DataStore addLocationWithAreaName:@"Instructor table" toCustomer:self.passedCustomer inManagedObjectContext:self.dataStore.managedObjectContext];
            
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
        case 3:
            [DataStore addLocationWithAreaName:@"Back picnic table" toCustomer:self.passedCustomer inManagedObjectContext:self.dataStore.managedObjectContext];
            
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
        case 4:
            [DataStore addLocationWithAreaName:@"Center table" toCustomer:self.passedCustomer inManagedObjectContext:self.dataStore.managedObjectContext];
            
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
        case 5:
            [DataStore addLocationWithAreaName:@"Kitchen" toCustomer:self.passedCustomer inManagedObjectContext:self.dataStore.managedObjectContext];
           
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
        case 6:
            [DataStore addLocationWithAreaName:@"Left presentation area" toCustomer:self.passedCustomer inManagedObjectContext:self.dataStore.managedObjectContext];
            
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
        case 7:
            [DataStore addLocationWithAreaName:@"Right presentation area" toCustomer:self.passedCustomer inManagedObjectContext:self.dataStore.managedObjectContext];
           
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
        
        default:
            break;
    }
    
}

-(void)assignPropertiesToButtons:(NSArray *)buttons
{
    FAKFontAwesome *mapMarkerIcon = [FAKFontAwesome mapMarkerIconWithSize:30];
    [mapMarkerIcon addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor]];
    UIImage *mapMarkerImage = [mapMarkerIcon imageWithSize:CGSizeMake(30,30)];
    
    for (UIButton *mapPin in buttons){
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
