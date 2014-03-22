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
@property (strong, nonatomic) IBOutlet UIButton *rubyTableLocationButton;
@property (strong, nonatomic) IBOutlet UIButton *iOSTableLocationButton;
@property (strong, nonatomic) IBOutlet UIButton *instructorTableLocationButton;
@property (strong, nonatomic) IBOutlet UIButton *backPicnicTableLocationButton;
@property (strong, nonatomic) IBOutlet UIButton *centerTablesLocationButton;
@property (strong, nonatomic) IBOutlet UIButton *kitchenLocationButton;
@property (strong, nonatomic) IBOutlet UIButton *presentationAreaLeftLocationButton;
@property (strong, nonatomic) IBOutlet UIButton *presentationAreaRightLocationButton;

@end

@implementation CurrentCustomerLocationViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
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
    
    if ([self.passedCustomer.location.area isEqualToString:@"Left presentation area"])
    {
        self.presentationAreaLeftLocationButton.tintColor = [UIColor blackColor];
   
    }else if ([self.passedCustomer.location.area isEqualToString:@"Kitchen"])
    {
        self.kitchenLocationButton.tintColor = [UIColor blackColor];

    }else if ([self.passedCustomer.location.area isEqualToString:@"Ruby instruction tables"])
    {
        self.rubyTableLocationButton.tintColor = [UIColor blackColor];
    
    }else if ([self.passedCustomer.location.area isEqualToString:@"iOS instruction tables"])
    {
        self.iOSTableLocationButton.tintColor = [UIColor blackColor];
    
    }else if ([self.passedCustomer.location.area isEqualToString:@"Instructor table"])
    {
        self.instructorTableLocationButton.tintColor = [UIColor blackColor];
    
    }else if ([self.passedCustomer.location.area isEqualToString:@"Back picnic table"])
    {
        self.backPicnicTableLocationButton.tintColor = [UIColor blackColor];
    
    }else if ([self.passedCustomer.location.area isEqualToString:@"Center table"])
    {
        self.centerTablesLocationButton.tintColor = [UIColor blackColor];
    
    }else if ([self.passedCustomer.location.area isEqualToString:@"Right presentation area"])
    {
        self.presentationAreaRightLocationButton.tintColor = [UIColor blackColor];
    }


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

    // Do any additional setup after loading the view.
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

@end
