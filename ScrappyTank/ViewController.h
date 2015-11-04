//
//  ViewController.h
//  ScrappyTank
//

//  Copyright (c) 2014 Benjamin Humphries. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import "AppDelegate.h"

#import "MPAdView.h"
#import "MPInterstitialAdController.h"


@interface ViewController : UIViewController<MPAdViewDelegate,MPInterstitialAdControllerDelegate>{
    
    MPAdView *adView;
    NSInteger adViewCount;
    BOOL removeAds;
    CGFloat screenWidth;
    CGFloat screenHeight;
    BOOL adShowing;
}
- (UIViewController *)viewControllerForPresentingModalView;
@property (nonatomic, retain) MPAdView *adView;
 @property (nonatomic, retain) MPInterstitialAdController *interstitial;
- (void)levelDidEnd;
-(void)removeAd;

@end
