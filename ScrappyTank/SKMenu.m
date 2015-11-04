//
//  SKMenu.m
//  ScrappyTank
//
//  Created by Benjamin Humphries on 4/10/14.
//  Copyright (c) 2014 Benjamin Humphries. All rights reserved.
//

#import "SKMenu.h"
#import "MyScene.h"
#import "ViewController.h"
#import "IAPHelper.h"
#import "productIAPHelper.h"
#import <StoreKit/StoreKit.h>

@implementation SKMenu{
    MyScene *scene;
  
   NSArray *_products;

}
@synthesize start;
@synthesize lockimage;


-(id)initWithImageNamed:(NSString *)name{

    self = [super initWithImageNamed:name];

    tankIndex = 0;
    [self setScreenSize];
    self.position = CGPointMake(screenWidth/2, screenHeight/2);
    self.size = CGSizeMake(screenWidth, screenHeight);
    
    //setup
    [self addTitleAndButtons];
    [self loadTanks];
    return self;
}
-(void)loadTanks{
     coins = [[NSUserDefaults standardUserDefaults]integerForKey:@"coins"];
    tank0Unlocked = true;
    tank1Unlocked =  [[NSUserDefaults standardUserDefaults]boolForKey:@"tank1"];
     tank2Unlocked =  [[NSUserDefaults standardUserDefaults]boolForKey:@"tank2"];
     tank3Unlocked =  [[NSUserDefaults standardUserDefaults]boolForKey:@"tank3"];
     tank4Unlocked =  [[NSUserDefaults standardUserDefaults]boolForKey:@"tank4"];
     tank5Unlocked =  [[NSUserDefaults standardUserDefaults]boolForKey:@"tank5"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(void)setScreenSize{
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    screenWidth = screenSize.width;
    screenHeight =screenSize.height;
}
-(void)addTitleAndButtons{
    
    SKLabelNode *title = [SKLabelNode labelNodeWithFontNamed:@"Slant"];
    [title setFontColor:[UIColor blackColor]];
    title.fontSize = 80;
    title.position = CGPointMake(0, screenHeight/4);
    
    title.text = [NSString stringWithFormat:@"ICE Tank"];

    
    start = [SKSpriteNode spriteNodeWithImageNamed:@"button"];
    start.name = @"start";
    start.position = CGPointMake(-start.frame.size.width/2 -1, 0);
    SKLabelNode *sLabel = [SKLabelNode labelNodeWithFontNamed:@"Slant"];
    sLabel.text = @"Start";
    sLabel.fontColor = [UIColor blackColor];
    sLabel.position = CGPointMake(start.centerRect.origin.x, start.centerRect.origin.y - 10);
    sLabel.name = @"startLabel";

    [start addChild:sLabel];
    
    
    
    [self addChild:start];
    [self addChild:title];
    
    SKSpriteNode *gameCenter = [SKSpriteNode spriteNodeWithImageNamed:@"button"];
    gameCenter.size = CGSizeMake(gameCenter.frame.size.width *2, gameCenter.frame.size.height);
    [gameCenter setPosition:CGPointMake(0,-gameCenter.size.height- 10)];
    gameCenter.name = @"leader";
    SKLabelNode *statsLabel = [SKLabelNode labelNodeWithFontNamed:@"Slant"];
    statsLabel.text = @"Leaderboard";
    statsLabel.fontColor = [UIColor blackColor];
    statsLabel.name = @"leadLabel";
    [statsLabel setPosition:CGPointMake(0, -10)];
    
    [gameCenter addChild:statsLabel];
    [self addChild:gameCenter];

    
    SKSpriteNode *rate = [SKSpriteNode spriteNodeWithImageNamed:@"button"];
    [rate setPosition:CGPointMake(rate.size.width/2 +1, 0)];
    rate.name = @"rate";
    SKLabelNode *l = [SKLabelNode labelNodeWithFontNamed:@"Slant"];
    l.text = @"Rate";
    l.fontColor = [UIColor blackColor];
    l.name = @"l";
    [l setPosition:CGPointMake(0, -10)];
    
    [rate addChild:l];
    [self addChild:rate];
    
    SKLabelNode *versionLabel = [SKLabelNode labelNodeWithFontNamed:@"Slant"];
    versionLabel.text = @"1.2";
    versionLabel.position = CGPointMake(0, title.position.y - 30);
    versionLabel.fontColor = [UIColor blackColor];
    versionLabel.alpha = 0.6;
    [self addChild:versionLabel];

    
    
    
    SKSpriteNode *rightArrow = [[SKSpriteNode alloc] initWithImageNamed:@"rightArrow"];
    [rightArrow setScale:screenWidth *2/320];
    rightArrow.position = CGPointMake(rightArrow.frame.size.width*2, gameCenter.position.y - rightArrow.frame.size.height -10);
    rightArrow.name = @"right";
    [self addChild:rightArrow];
    
    
    SKSpriteNode *leftArrow = [[SKSpriteNode alloc] initWithImageNamed:@"leftArrow"];
    [leftArrow setScale:screenWidth *2/320];
    leftArrow.position = CGPointMake(leftArrow.frame.size.width* -2, gameCenter.position.y - leftArrow.frame.size.height -10);
    leftArrow.name = @"left";
    [self addChild:leftArrow];
    
    lockimage = [SKSpriteNode spriteNodeWithImageNamed:@"unlock"];
    lockimage.zPosition = 10;
    // lockimage.position = CGPointMake(0, gameCenter.position.y - lockimage.size.height/1.5);
    [lockimage setScale:screenWidth/320];
    
    
    
    
    SKSpriteNode *store = [[SKSpriteNode alloc]initWithImageNamed:@"button"];
    [store setPosition:CGPointMake(0, store.size.height+10)];
    store.name = @"store";
    SKLabelNode *storeLabel = [SKLabelNode labelNodeWithFontNamed:@"Slant"];
    storeLabel.text = @"Store";
    storeLabel.fontColor = [UIColor blackColor];
    storeLabel.name = @"store";
    [storeLabel setPosition:CGPointMake(0, -10)];
    
    [store addChild:storeLabel];
    [self addChild:store];

    
    
}
-(void)startGame{
  
    [self removeFromParent];
}
-(void)fadeNode:(SKNode*)node{
    
    SKAction *fade = [SKAction fadeAlphaTo:0.5 duration:0.5];
    [node runAction:fade];
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        SKNode *node=[self nodeAtPoint:location];
        
        
         if ([node.name isEqualToString:@"start"]){
            
        [self fadeNode:node];
             
         }
         else {
             start.alpha = 1.0;
         }
        if ([node.name isEqualToString:@"leader"]){
            scene = (MyScene *)node.parent.parent;
            [scene showLeaderboardAndAchievements:
             YES];
            [scene reportScore];

        }
        else if ([node.name isEqualToString:@"leadLabel"]){
            scene = (MyScene *)node.parent.parent.parent;
            [scene showLeaderboardAndAchievements:YES];
            [scene reportScore];
            
        }
        else if ([node.name isEqualToString:@"l"] ||[node.name isEqualToString:@"rate"]){
          //  scene = (MyScene *)node.parent.parent.parent;
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://userpub.itunes.apple.com/WebObjects/MZUserPublishing.woa/wa/addUserReview?type=Purple+Software&id=862478497"]];
            
        }
        else if ([node.name isEqualToString:@"right"]){
            scene = (MyScene *)self.parent;
            SKTiltTank *tank = [scene getOriginalTank];
            if (tankIndex <  [[tank getTankArray] count]-1){
                tankIndex ++;
            }
            else {
                tankIndex = 0;
            }
                      [self changeTankForIndex:tankIndex];
        }
        else if ([node.name isEqualToString:@"left"]){
            scene = (MyScene *)self.parent;
            SKTiltTank *tank = [scene getOriginalTank];
            if (tankIndex > 0){
                tankIndex --;
            }
            else {
                tankIndex = [[tank getTankArray]count]-1;
            }
            
            [self changeTankForIndex:tankIndex];
        }

        else if ([node.name isEqualToString:@"store"]){
            scene = (MyScene *)self.parent;
            [scene displayStore];


        }

    }
    
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        SKNode *node=[self nodeAtPoint:location];
        
        
        if (![node.name isEqualToString:@"start"]){
            start.alpha = 1.0;
        }
        
    }
    
}
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    start.alpha = 1.0;
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        SKNode *node=[self nodeAtPoint:location];
        
        
        if ([node.name isEqualToString:@"start"]){
            
            if ([self isTankUnlocked]){
            scene = (MyScene *)node.parent.parent;
             [self removeFromParent];
             [scene showInstructions];
                [scene removeAd];
            }
            else {
                [self tankNotUnlocked];
            }
        }
        else if ([node.name isEqualToString:@"startLabel"]){
             if ([self isTankUnlocked]){
            scene = (MyScene *)node.parent.parent.parent;
            [self removeFromParent];
                 [scene removeAd];

            [scene showInstructions];
             }
             else {
                 [self tankNotUnlocked];
             }
        }
        else if ([node.name isEqualToString:@"lockImage"]){
             scene = (MyScene *)node.parent.parent;
            SKTiltTank *tank =  [scene getOriginalTank];
            NSInteger cost =[tank getCoinValueForTank:[NSString stringWithFormat:@"tank%li",(long)tankIndex]];
            if (coins >= cost){
                
                [self buyingTankThatCost:cost];
                
            }
            else {
                [self notEnoughCoinsForCost:cost];
            }
            
        }
        
        
    
    }
    start.alpha = 1.0;

}
-(void)tankNotUnlocked{
    scene = (MyScene *)self.parent;
    SKTiltTank *tank =  [scene getOriginalTank];
    if (coins < [tank getCoinValueForTank:[NSString stringWithFormat:@"tank%li",(long)tankIndex]]){
        UIAlertView *a = [[UIAlertView alloc]initWithTitle:@"Tank Not Unlocked" message:@"Would you like to buy more coins?" delegate:self cancelButtonTitle:@"No Thanks" otherButtonTitles:@"Buy Coins!", nil];
        [a show];
    }
    else {
        UIAlertView *a = [[UIAlertView alloc]initWithTitle:@"Tank Not Unlocked" message:[NSString stringWithFormat:@"Would you like to buy this tank for %li coins?",(long)[tank getCoinValueForTank:[NSString stringWithFormat:@"tank%li",(long)tankIndex]]] delegate:self cancelButtonTitle:@"No Thanks" otherButtonTitles:@"YES!", nil];
        [a show];
    }
}
-(BOOL)isTankUnlocked{
    
    switch (tankIndex) {
        case 0:
            return true;
            break;
        case 1:
            return tank1Unlocked;
            break;
        case 2:
            return tank2Unlocked;
            break;
        case 3:
            return tank3Unlocked;
            break;
        case 4:
            return tank4Unlocked;
            break;
        case 5:
            return tank5Unlocked;
            break;
        
    }
    
    
    return NO;
}

-(void)buyingTankThatCost:(NSInteger)cost{

    UIAlertView *a = [[UIAlertView alloc]initWithTitle:@"Buy Tank?" message:[NSString stringWithFormat:@"Would you like to by this tank for %li coins?",(long)cost] delegate:self cancelButtonTitle:@"No Thanks" otherButtonTitles:@"YES!", nil];
    
    [a show];
}
-(void)notEnoughCoinsForCost:(NSInteger)cost{
    coins = [[NSUserDefaults standardUserDefaults]integerForKey:@"coins"];
    UIAlertView *a = [[UIAlertView alloc]initWithTitle:@"Cannot Buy Tank" message:[NSString stringWithFormat:@"You do not have enough coins to buy this tank. %li/%li \n you need %i more coins!",(long)coins,(long)cost,cost-coins] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Buy Coins!", nil];
    
    [a show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if ([title isEqualToString:@"YES!"]){
        //buy tank with coins//
        [self buyTankNamed:[NSString stringWithFormat:@"tank%li",(long)tankIndex]];
    }
    else if ([title isEqualToString:@"Buy Coins!"]){
        scene = (MyScene *)self.parent;
        [scene displayStore];
        
    }
    
    }


-(void)buyTankNamed:(NSString *)tname{
    scene = (MyScene *)self.parent;
    SKTiltTank *tank =  [scene getOriginalTank];
    NSInteger newCoinAmount;
    
    if ([tname isEqualToString:@"tank1"]){
        tank1Unlocked = true;
    }
    else if ([tname isEqualToString:@"tank2"]){
        tank2Unlocked = true;
    }
    else if ([tname isEqualToString:@"tank3"]){
        tank3Unlocked = true;
    }
    else if ([tname isEqualToString:@"tank4"]){
        tank4Unlocked = true;
    }
    else if ([tname isEqualToString:@"tank5"]){
        tank5Unlocked = true;
    }
    newCoinAmount = coins - [tank getCoinValueForTank:tname];
     coins = newCoinAmount;
    [[NSUserDefaults standardUserDefaults]synchronize];
   [[NSUserDefaults standardUserDefaults]setInteger:coins forKey:@"coins"];

   
    [[NSUserDefaults standardUserDefaults]setBool:tank1Unlocked forKey:@"tank1"];
     [[NSUserDefaults standardUserDefaults]setBool:tank2Unlocked forKey:@"tank2"];
     [[NSUserDefaults standardUserDefaults]setBool:tank3Unlocked forKey:@"tank3"];
     [[NSUserDefaults standardUserDefaults]setBool:tank4Unlocked forKey:@"tank4"];
     [[NSUserDefaults standardUserDefaults]setBool:tank5Unlocked forKey:@"tank5"];
    
    [lockimage removeAllChildren];
    [lockimage removeFromParent];
    scene = (MyScene *)self.parent;
    [scene updateCoinAmount];
}
-(void)changeTankForIndex:(NSInteger)x{
    scene = (MyScene *)self.parent;
    SKTiltTank *tank = [scene getOriginalTank];
    NSMutableArray *array = [tank getTankArray];
    NSString *tankImage = [NSString stringWithFormat:@"%@bot",[array objectAtIndex:x]];
    NSString *tankTop = [NSString stringWithFormat:@"%@top",[array objectAtIndex:x]];
    [scene setTankImage:tankImage topImage:tankTop];
    
    [tank setCurrenTankIndex:x];
    
    [lockimage removeAllChildren];
    [lockimage removeFromParent];
    
    if ([[array objectAtIndex:x] isEqualToString:@"tank1"]){
        if  (!tank1Unlocked) {
            [self addLockimageWithAmount:[tank getCoinValueForTank:@"tank1"]];

        }
    }
    else if ([[array objectAtIndex:x] isEqualToString:@"tank2"]){
        if  (!tank2Unlocked) {
            [self addLockimageWithAmount:[tank getCoinValueForTank:@"tank2"]];
        }
    }
    else if ([[array objectAtIndex:x] isEqualToString:@"tank3"]){
        if  (!tank3Unlocked) {
            [self addLockimageWithAmount:[tank getCoinValueForTank:@"tank3"]];

        }
    }
    else if ([[array objectAtIndex:x] isEqualToString:@"tank4"]){
        if  (!tank4Unlocked) {
            [self addLockimageWithAmount:[tank getCoinValueForTank:@"tank4"]];

        }
    }
    else if ([[array objectAtIndex:x] isEqualToString:@"tank5"]){
        if  (!tank5Unlocked) {
            [self addLockimageWithAmount:[tank getCoinValueForTank:@"tank5"]];

        }
    }

}


-(void)addLockimageWithAmount:(NSInteger)x{
    lockimage.name = @"lockImage";
    lockimage.position = CGPointMake(0, -screenHeight/4);
    SKLabelNode *amount = [SKLabelNode labelNodeWithFontNamed:@"Slant"];
    amount.text = [NSString stringWithFormat:@"x %li",(long)x];
    amount.fontSize = 15;
    amount.position = CGPointMake(10, -lockimage.size.height/2 + amount.frame.size.height/2);
    [lockimage addChild:amount];
    [self addChild:lockimage];

}

-(void)returnFromGame{
    scene = (MyScene *)self.parent;
    SKTiltTank *tank = [scene getOriginalTank];
    [tank getOutOfHole];
    [self changeTankForIndex:0];
}
@end
