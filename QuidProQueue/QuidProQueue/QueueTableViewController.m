//
//  QueueTableViewController.m
//
//
//  Created by Dare Ryan on 3/7/14.
//
//

#import "QueueTableViewController.h"
#import <FontAwesomeKit.h>
#import "DataStore.h"
#import "Customer+Methods.h"
#import "Location.h"
#import "CustomerDetailTableViewController.h"
#import "ParseSync.h"


@interface QueueTableViewController ()
@property (strong,nonatomic) DataStore *dataStore;
- (IBAction)refreshButtonPressed:(id)sender;

@end

@implementation QueueTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dataStore = [DataStore sharedInstance];
    self.dataStore.fetchedResultsController.delegate = self;
}

-(void)viewDidAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

-(UITabBarItem *)tabBarItem
{
    FAKFontAwesome *tabIcon = [FAKFontAwesome usersIconWithSize:30];
    [tabIcon addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor]];
    
    UIImage *tabIconImage = [tabIcon imageWithSize:CGSizeMake(30,30)];
    
    UITabBarItem *tabBarItem = [[UITabBarItem alloc]initWithTitle:@"Queue" image:tabIconImage selectedImage:tabIconImage];
    
    return tabBarItem;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.dataStore.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataStore.fetchedResultsController.sections[section] numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"QueueCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    Customer *customer = [self.dataStore.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.textLabel.text = customer.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@\nLocation: %@", [customer calculateWaitTimeForCustomer], customer.location.area];
}


-(void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"customerDetailSegue"])
    {
        NSIndexPath *selectedCell = [self.tableView indexPathForSelectedRow];
        CustomerDetailTableViewController *customerDetailVC = [segue destinationViewController];
        Customer *selectedCustomer = [self.dataStore.fetchedResultsController objectAtIndexPath:selectedCell];
        
        customerDetailVC.passedCustomer = selectedCustomer;
    }
}

- (IBAction)refreshButtonPressed:(id)sender
{
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    [queue addOperationWithBlock:^{
    [self.tableView reloadData];
    [ParseSync syncLocalDataToDataStore:self.dataStore];
    [ParseSync syncOnlineDataToDataStore:self.dataStore];
    [ParseSync updateLocalDataInDataStore:self.dataStore];
    }];
}

#pragma mark - NSFetchedResultsControllerDelegate Methods

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath]
                    atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}


@end
