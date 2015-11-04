//
//  StoreTableViewController.h
//  ScrappyTank
//
//  Created by Benjamin Humphries on 4/22/14.
//  Copyright (c) 2014 Benjamin Humphries. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreTableViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate>{
IBOutlet UITableView *tableView;

}
- (IBAction)cancel:(UIBarButtonItem *)sender;
@property (retain,nonatomic) IBOutlet UITableView *tableView;
@end
