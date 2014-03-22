//
//  SessionsOnMapViewController.m
//  
//
//  Created by Dare Ryan on 3/14/14.
//
//

#import "SessionsOnMapViewController.h"
#import "DataStore.h"
#import "Customer.h"
#import "Location.h"

@interface SessionsOnMapViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *customersAtLocationArray;
@property (strong, nonatomic) DataStore *dataStore;

@end

@implementation SessionsOnMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.dataStore = [DataStore sharedInstance];
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Location"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"area = %@",self.locationArea];
    fetchRequest.predicate = predicate;
    Location *location = [self.dataStore.managedObjectContext executeFetchRequest:fetchRequest error:nil][0];
    self.customersAtLocationArray = [location.customers allObjects];
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.customersAtLocationArray count];
}


 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
 {
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
 
     Customer *customerAtIndexPath = self.customersAtLocationArray[indexPath.row];
     
     NSDate *currentTime= [NSDate date];
     NSTimeInterval timeElapsed = [currentTime timeIntervalSinceDate:customerAtIndexPath.arrivalTime];
     cell.textLabel.text = customerAtIndexPath.name;
     if ([[NSString stringWithFormat:@"%.0f",timeElapsed/60]integerValue] == 1)
     {
         cell.detailTextLabel.text = [NSString stringWithFormat:@"Wait time: %.0f minute\nNotes: %@", timeElapsed/60.0, customerAtIndexPath.notes];
     }
     
     else
     {
         cell.detailTextLabel.text = [NSString stringWithFormat:@"Wait time: %.0f minutes\nNotes: %@", timeElapsed/60.0, customerAtIndexPath.notes];
     }

     
 return cell;
 }


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

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
