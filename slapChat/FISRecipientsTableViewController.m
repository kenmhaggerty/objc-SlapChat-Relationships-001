//
//  FISRecipientsTableViewController.m
//  slapChat
//
//  Created by Ken M. Haggerty on 2/10/16.
//  Copyright © 2016 Joe Burgess. All rights reserved.
//

#import "FISRecipientsTableViewController.h"
#import "Recipient.h"
#import "FISTableViewController.h"
#import "FISDataStore.h"

@interface FISRecipientsTableViewController ()
@property (nonatomic, strong) FISDataStore *store;
@property (nonatomic, strong) NSArray *recipients;
@end

@implementation FISRecipientsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.store = [FISDataStore sharedDataStore];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.store fetchData];
    [self setRecipients:self.filter ? [self.store.recipients filteredArrayUsingPredicate:self.filter] : self.store.recipients];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.recipients.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"recipientCell" forIndexPath:indexPath];
    
    Recipient *recipient = [self.recipients objectAtIndex:indexPath.row];
    [cell.textLabel setText:recipient.name];
    [cell.detailTextLabel setText:[NSString stringWithFormat:@"%@ • %@ • %@", recipient.email ? recipient.email : @"(email)", recipient.phoneNumber ? recipient.phoneNumber : @"(phone)", recipient.twitterHandle ? recipient.twitterHandle : @"(twitter)"]];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
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
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if (![segue.identifier isEqualToString:@"showMessages"]) return;
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    Recipient *recipient = self.recipients[indexPath.row];
    
    FISTableViewController *tableViewController = (FISTableViewController *)segue.destinationViewController;
    [tableViewController setManagedMessageObjects:recipient.messages.allObjects];
}

@end
