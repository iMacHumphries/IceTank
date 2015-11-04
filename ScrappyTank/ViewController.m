//
//  ViewController.m
//  ScrappyTank
//
//  Created by Benjamin Humphries on 4/7/14.
//  Copyright (c) 2014 Benjamin Humphries. All rights reserved.
//

#import "ViewController.h"
#import "MyScene.h"
#import <iAd/iAd.h>

@implementation ViewController
@synthesize adView;



- (void)viewDidLoad
{
    /*
    removeAds = [[NSUserDefaults standardUserDefaults]integerForKey:@"removeAds"];
    adViewCount = [[NSUserDefaults standardUserDefaults]integerForKey:@"adViewCount"];
    
    [super viewDidLoad];
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = NO;
    skView.showsNodeCount = NO;
    
    // Create and configure the scene.
    SKScene * scene = [MyScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:scene];
    
    [self setScreenSize];
    
    [self loadInterstitial];
    [self levelDidEnd];
     */

  }
-(void)viewWillAppear:(BOOL)animated{
    
    removeAds = [[NSUserDefaults standardUserDefaults]integerForKey:@"removeAds"];
    adViewCount = [[NSUserDefaults standardUserDefaults]integerForKey:@"adViewCount"];

    SKView * skView = (SKView *)self.view;
    skView.showsFPS = NO;
    skView.showsNodeCount = NO;
    
    // Create and configure the scene.
    SKScene * scene = [MyScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:scene];
    
    [self setScreenSize];

    [self loadInterstitial];

    if (!adShowing){
        [self levelDidEnd];
    }
    
}


-(void)increaseAdViewCount{
    adViewCount++;
    if (adViewCount >=11){
        adViewCount = 0;
    }
    [[NSUserDefaults standardUserDefaults]setInteger:adViewCount forKey:@"adViewCount"];
}
-(NSInteger)getAdViewCount{
    adViewCount = [[NSUserDefaults standardUserDefaults]integerForKey:@"adViewCount"];   return adViewCount;
}
- (void)levelDidEnd {
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"removeAds"]){
        adShowing =true;
    adViewCount = [self getAdViewCount];
    if (adViewCount == 10){
    if (self.interstitial.ready){
       
        [self.interstitial showFromViewController:self];
        [self increaseAdViewCount];

    }
        
    }
    else{
        [self increaseAdViewCount];
    }
    
        if (screenWidth > 321){
            self.adView = [[MPAdView alloc] initWithAdUnitId:@"cb977bbab62843499a72990dd7975fc7"
                                                        size:CGSizeMake(screenWidth, 90)];
        }
        else {
            self.adView = [[MPAdView alloc] initWithAdUnitId:@"388063d0934d47849656eedba0cb3f28"
                                                        size:CGSizeMake(320, 50)];

        }
         self.adView.delegate = self;
    CGRect frame = self.adView.frame;
    CGSize size = [self.adView adContentViewSize];
    frame.origin.y = [[UIScreen mainScreen] applicationFrame].size.height - size.height;
    self.adView.frame = frame;
    [self.view addSubview:self.adView];
    [self.adView loadAd];
   
}
    else {
        //ads disabled
          adShowing =false;
        [self removeAd];
    }
    
}
-(void)setScreenSize{
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    screenWidth = screenSize.width;
    screenHeight =screenSize.height;
}
-(void)removeAd{
    [self.adView removeFromSuperview];
}
#pragma mark - <MPAdViewDelegate>
- (UIViewController *)viewControllerForPresentingModalView {
    return self;
}


- (void)loadInterstitial {
    // Instantiate the interstitial using the class convenience method.
    self.interstitial = [MPInterstitialAdController
                         interstitialAdControllerForAdUnitId:@"b5e87b47a060405180663398f9fb92b1"];
    self.interstitial.delegate = self;
    // Fetch the interstitial ad.
    [self.interstitial loadAd];
}


-(void)viewWillDisappear:(BOOL)animated{
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = NO;
    skView.showsNodeCount = NO;
    
    SKScene * scene = [MyScene sceneWithSize:skView.bounds.size];
    MyScene *s = (MyScene *)scene;
    
    [s disappear];
    [self removeAd];
    adShowing = false;
}
- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    NSLog(@"MEMORY WARNING!");
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}
- (BOOL)prefersStatusBarHidden
{
    return YES;
}


@end
