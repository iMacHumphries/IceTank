//
//  DetailViewController.m
//  ScrappyTank
//
//  Created by Benjamin Humphries on 4/23/14.
//  Copyright (c) 2014 Benjamin Humphries. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController
@synthesize theDetail;
@synthesize discription;
@synthesize extraDetail;
@synthesize extraImageName;
@synthesize currentProduct;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      
      
      
    }
    return self;
}

- (void)viewDidLoad
{
    [theDetail setText:discription];
   // [theDetail setTextAlignment:NSTextAlignmentCenter];
    [theDetail setTextColor:[UIColor blackColor]];
    [theDetail setFont:[UIFont fontWithName:@"Slant" size:30]];

    extraDetail.image = [UIImage imageNamed:extraImageName];
    
    
    [super viewDidLoad];
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

- (IBAction)buy:(UIButton *)sender {
    [[productIAPHelper sharedInstance] buyProduct:currentProduct];
}
@end
