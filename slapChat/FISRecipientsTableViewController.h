//
//  FISRecipientsTableViewController.h
//  slapChat
//
//  Created by Ken M. Haggerty on 2/10/16.
//  Copyright © 2016 Joe Burgess. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FISRecipientsTableViewController : UITableViewController
@property (nonatomic, strong) NSPredicate *filter;
@end
