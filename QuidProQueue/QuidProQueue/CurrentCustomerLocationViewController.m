//
//  CurrentCustomerLocationViewController.m
//  QuidProQueue
//
//  Created by Dare Ryan on 3/14/14.
//  Copyright (c) 2014 Dare Ryan. All rights reserved.
//

#import "CurrentCustomerLocationViewController.h"
#import <FAKFontAwesome.h>
#import "Location.h"

@interface CurrentCustomerLocationViewController ()

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *contentView;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *mapPins;

@end

@implementation CurrentCustomerLocationViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.scrollView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contentView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self assignPropertiesToButtons:self.mapPins];
    [self.view layoutSubviews];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self assignPropertiesToButtons:self.mapPins];
    
    [self.view layoutSubviews];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    [self.scrollView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contentView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view layoutSubviews];
    
    
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)assignPropertiesToButtons:(NSArray *)buttons
{
    FAKFontAwesome *mapMarkerIcon = [FAKFontAwesome mapMarkerIconWithSize:30];
    [mapMarkerIcon addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor]];
    UIImage *mapMarkerImage = [mapMarkerIcon imageWithSize:CGSizeMake(30,30)];
    
    for (UIButton *mapPin in buttons)
    {
        [mapPin setTranslatesAutoresizingMaskIntoConstraints:NO];
        [mapPin setImage:mapMarkerImage forState:UIControlStateNormal];
    }
    
    for (UIButton *mapPin in buttons) {
        
        switch (mapPin.tag) {
            case 0:
                mapPin.frame = CGRectMake(253, 127, 30, 30);
                
                if ([self.passedCustomer.location.area isEqualToString:@"Ruby instruction tables"])
                {
                    mapPin.tintColor = [UIColor blackColor];
                }
                break;
            case 1:
                mapPin.frame = CGRectMake(81,127, 30, 30);
                if ([self.passedCustomer.location.area isEqualToString:@"iOS instruction tables"])
                {
                    mapPin.tintColor = [UIColor blackColor];
                }
                break;
            case 2:
                mapPin.frame = CGRectMake(71, 260, 30, 30);
                if ([self.passedCustomer.location.area isEqualToString:@"Instructor table"])
                {
                    mapPin.tintColor = [UIColor blackColor];
                }
                break;
            case 3:
                mapPin.frame = CGRectMake(241, 294, 30, 30);
                if ([self.passedCustomer.location.area isEqualToString:@"Back picnic table"])
                {
                    mapPin.tintColor = [UIColor blackColor];
                }
                break;
            case 4:
                mapPin.frame = CGRectMake(81, 391, 30, 30);
                if ([self.passedCustomer.location.area isEqualToString:@"Center table"])
                {
                    mapPin.tintColor = [UIColor blackColor];
                }
                break;
            case 5:
                mapPin.frame = CGRectMake(253, 391, 30, 30);
                if ([self.passedCustomer.location.area isEqualToString:@"Kitchen"])
                {
                    mapPin.tintColor = [UIColor blackColor];
                }
                break;
            case 6:
                mapPin.frame = CGRectMake(44, 544, 30, 30);
                if ([self.passedCustomer.location.area isEqualToString:@"Left presentation area"])
                {
                    mapPin.tintColor = [UIColor blackColor];
                }
                break;
            case 7:
                mapPin.frame = CGRectMake(253, 544, 30, 30);
                if ([self.passedCustomer.location.area isEqualToString:@"Right presentation area"])
                {
                    mapPin.tintColor = [UIColor blackColor];
                }
                break;
            default:
                break;
        }
    }
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

@end
