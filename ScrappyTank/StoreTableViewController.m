//
//  StoreTableViewController.m
//  ScrappyTank
//
//  Created by Benjamin Humphries on 4/22/14.
//  Copyright (c) 2014 Benjamin Humphries. All rights reserved.
//

#import "StoreTableViewController.h"

#import "productIAPHelper.h"
#import <StoreKit/StoreKit.h>
#import "DetailViewController.h"


@interface StoreTableViewController () {
    NSArray *_products;
    NSMutableArray *images;
    NSMutableArray *extraImages;
}
@end

@implementation StoreTableViewController
@synthesize tableView;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    images = [[NSMutableArray alloc]initWithObjects:
              @"coin250",
              @"coin250",
              @"tankpack1",
              nil];
    extraImages = [[NSMutableArray alloc]initWithObjects:
                   @"",
                   @"",
                   @"extratankpack",
                   nil];

    tableView.delegate = self;
    tableView.dataSource = self;
    
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menu"]];
    [tempImageView setFrame:self.tableView.frame];
    
    self.tableView.backgroundView = tempImageView;
    
    self.title = @"ICE Tank Store";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Restore" style:UIBarButtonItemStyleBordered target:self action:@selector(restoreTapped:)];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(reload) forControlEvents:UIControlEventValueChanged];
    [self reload];
    [self.refreshControl beginRefreshing];
    
    
    
}
- (void)restoreTapped:(id)sender {
    [[productIAPHelper sharedInstance] restoreCompletedTransactions];
}

// 4
- (void)reload {
    _products = nil;
    [self.tableView reloadData];
    [[productIAPHelper sharedInstance] requestProductsWithCompletionHandler:^(BOOL success, NSArray *products) {
        if (success) {
            _products = products;
            [self.tableView reloadData];
        }
        [self.refreshControl endRefreshing];
    }];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

// 5
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _products.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableview cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    
    SKProduct * product = (SKProduct *) _products[indexPath.row];
    cell.textLabel.text = product.localizedTitle;
   // cell.detailTextLabel.text = product.localizedDescription;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"$%@",product.price];
    cell.imageView.image = [UIImage imageNamed:[images objectAtIndex:indexPath.row]];
    if (indexPath.row == 1){
               cell.imageView.alpha = 0.0;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
     SKProduct *product = _products[indexPath.row];
    //[[productIAPHelper sharedInstance] buyProduct:product];

    [self performSegueWithIdentifier:@"detail" sender:product];

    
}

- (IBAction)cancel:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([[segue identifier] isEqualToString:@"detail"]){
        DetailViewController *detail = [segue destinationViewController];
        SKProduct * product = (SKProduct *)sender;
        detail.navigationItem.title = product.localizedTitle;
        detail.discription = product.localizedDescription;
        NSInteger x = tableView.indexPathForSelectedRow.row;
        detail.extraImageName = [extraImages objectAtIndex:x];
        detail.currentProduct = product;
    }
    
}
@end