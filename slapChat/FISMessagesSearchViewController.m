//
//  FISMessagesSearchViewController.m
//  slapChat
//
//  Created by Ken M. Haggerty on 2/10/16.
//  Copyright © 2016 Joe Burgess. All rights reserved.
//

#import "FISMessagesSearchViewController.h"
#import "FISTableViewController.h"

@interface FISMessagesSearchViewController ()
@property (nonatomic, strong) IBOutlet UITextField *contentTextField;
@property (nonatomic, strong) IBOutlet UISwitch *buttonSwitch;
@property (nonatomic, strong) IBOutlet UIDatePicker *datePicker;
- (IBAction)enableSearchByDate:(UISwitch *)switchButton;
- (IBAction)close:(id)sender;
- (IBAction)clearFilters:(id)sender;
- (IBAction)filter:(id)sender;
@end

@implementation FISMessagesSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.buttonSwitch setOn:NO];
    [self enableSearchByDate:self.buttonSwitch];
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

- (IBAction)enableSearchByDate:(UISwitch *)switchButton
{
    [self.datePicker setUserInteractionEnabled:switchButton.on];
    [self.datePicker setAlpha:switchButton.on ? 1.0f : 0.33f];
}

- (IBAction)close:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)clearFilters:(id)sender
{
    FISTableViewController *tableViewController = (FISTableViewController *)((UINavigationController *)self.presentingViewController).topViewController;
    [tableViewController setFilter:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)filter:(id)sender
{
    NSMutableArray *predicates = [NSMutableArray array];
    if (self.contentTextField.text && self.contentTextField.text.length) {
        [predicates addObject:[NSPredicate predicateWithFormat:@"content CONTAINS[c] %@", self.contentTextField.text]];
    }
    if (self.datePicker.userInteractionEnabled) {
        [predicates addObject:[NSPredicate predicateWithFormat:@"creationDate == %@", [[NSCalendar currentCalendar] startOfDayForDate:self.datePicker.date]]];
    }
    
    NSCompoundPredicate *filter;
    if (predicates.count) {
        filter = [NSCompoundPredicate andPredicateWithSubpredicates:predicates];
    }
    FISTableViewController *tableViewController = (FISTableViewController *)((UINavigationController *)self.presentingViewController).topViewController;
    [tableViewController setFilter:filter];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
