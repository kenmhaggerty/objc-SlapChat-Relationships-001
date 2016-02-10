//
//  FISRecipientsSearchViewController.m
//  slapChat
//
//  Created by Ken M. Haggerty on 2/10/16.
//  Copyright © 2016 Joe Burgess. All rights reserved.
//

#import "FISRecipientsSearchViewController.h"
#import "FISRecipientsTableViewController.h"

@interface FISRecipientsSearchViewController ()
@property (nonatomic, strong) IBOutlet UINavigationBar *navigationBar;
@property (nonatomic, strong) IBOutlet UITextField *nameTextField;
@property (nonatomic, strong) IBOutlet UITextField *emailTextField;
@property (nonatomic, strong) IBOutlet UITextField *phoneTextField;
@property (nonatomic, strong) IBOutlet UITextField *twitterTextField;
- (IBAction)close:(id)sender;
- (IBAction)clearFilters:(id)sender;
- (IBAction)filter:(id)sender;
@end

@implementation FISRecipientsSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)close:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)clearFilters:(id)sender
{
    FISRecipientsTableViewController *recipientsTableViewController = (FISRecipientsTableViewController *)((UINavigationController *)self.presentingViewController).topViewController;
    [recipientsTableViewController setFilter:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)filter:(id)sender
{
    NSMutableArray *predicates = [NSMutableArray array];
    if (self.nameTextField.text && self.nameTextField.text.length) {
        [predicates addObject:[NSPredicate predicateWithFormat:@"name CONTAINS[c] %@", self.nameTextField.text]];
    }
    if (self.emailTextField.text && self.emailTextField.text.length) {
        [predicates addObject:[NSPredicate predicateWithFormat:@"email CONTAINS[c] %@", self.emailTextField.text]];
    }
    if (self.phoneTextField.text && self.phoneTextField.text.length) {
        [predicates addObject:[NSPredicate predicateWithFormat:@"phoneNumber CONTAINS[c] %@", self.phoneTextField.text]];
    }
    if (self.twitterTextField.text && self.twitterTextField.text.length) {
        [predicates addObject:[NSPredicate predicateWithFormat:@"twitterHandle CONTAINS[c] %@", self.twitterTextField.text]];
    }
    
    NSCompoundPredicate *filter;
    if (predicates.count) {
        filter = [NSCompoundPredicate andPredicateWithSubpredicates:predicates];
    }
    FISRecipientsTableViewController *recipientsTableViewController = (FISRecipientsTableViewController *)((UINavigationController *)self.presentingViewController).topViewController;
    [recipientsTableViewController setFilter:filter];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
