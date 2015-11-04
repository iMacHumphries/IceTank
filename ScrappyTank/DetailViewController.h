//
//  DetailViewController.h
//  ScrappyTank
//
//  Created by Benjamin Humphries on 4/23/14.
//  Copyright (c) 2014 Benjamin Humphries. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreTableViewController.h"
#import  <StoreKit/StoreKit.h>
#import "productIAPHelper.h"

@class StoreTableViewController;
@interface DetailViewController : UIViewController{
    NSInteger selectedIndex;

    NSString *discription;
    NSString *extraImageName;
    SKProduct *currentProduct;

}
- (IBAction)buy:(UIButton *)sender;
@property (retain, nonatomic)SKProduct *currentProduct;
@property (retain, nonatomic) IBOutlet UITextView *theDetail;
@property (retain, nonatomic) IBOutlet UIImageView *extraDetail;
@property (retain, nonatomic) NSString *discription;
@property (retain, nonatomic) NSString *extraImageName;
@end
