//
//  MyScene.m
//  ScrappyTank
//
//  Created by Benjamin Humphries on 4/7/14.
//  Copyright (c) 2014 Benjamin Humphries. All rights reserved.
//

#import "MyScene.h"
#import <UIKit/UIKit.h>
#import "StoreTableViewController.h"
#import "ViewController.h"

@implementation MyScene{
     AVAudioPlayer* audioPlayer;
}
@synthesize bg1,bg2;
@synthesize backgroundNode;
@synthesize scoreBoard;
@synthesize menu;
@synthesize gameOverMenu;
@synthesize tank;
@synthesize mine;
@synthesize rain;
@synthesize activityViewController;
@synthesize addMine;
@synthesize iceHole;
@synthesize instructions;
@synthesize topOfTank;
@synthesize leaderboardID; //GAMECENTER//

/*GameCenter*/
- (void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController{
    [gameCenterViewController dismissViewControllerAnimated:YES completion:nil];
    
}
-(void)authenticateLocalPlayer{
    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    
    localPlayer.authenticateHandler = ^(UIViewController *viewController, NSError *error){
        if (viewController != nil) {
            UIViewController *vc = self.view.window.rootViewController;
            [vc presentViewController:viewController animated:YES completion:^{
            }];

        }
        else{
            if ([GKLocalPlayer localPlayer].authenticated) {
                gameCenterEnabled = YES;
                
                // Get the default leaderboard identifier.
                [[GKLocalPlayer localPlayer] loadDefaultLeaderboardIdentifierWithCompletionHandler:^(NSString *leaderboardIdentifier, NSError *error) {
                    
                    if (error != nil) {
                        NSLog(@"%@", [error localizedDescription]);
                    }
                    else{
                        leaderboardID = leaderboardIdentifier;
                    }
                }];
            }
            
            else{
                gameCenterEnabled = NO;
            }
        }
    };
}

-(void)reportScore{
    if (!gameCenterEnabled) {
       // UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Player Not Signed In" message:@"Please sign into Game Center to access the Leaderboards" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
       // [alert show];
        return;
    }
    GKScore *score = [[GKScore alloc] initWithLeaderboardIdentifier:@"highScoreLeaderboard"];
    score.value = [[NSUserDefaults standardUserDefaults]integerForKey:@"highScore"];
    
    [GKScore reportScores:@[score] withCompletionHandler:^(NSError *error) {
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
        }
    }];
    [self updateAchievement];

}
-(void)showLeaderboardAndAchievements:(BOOL)shouldShowLeaderboard{
    
    GKGameCenterViewController *gcViewController = [[GKGameCenterViewController alloc] init];
    
    gcViewController.gameCenterDelegate = self;
    
    if (shouldShowLeaderboard) {
        gcViewController.viewState = GKGameCenterViewControllerStateLeaderboards;
        gcViewController.leaderboardIdentifier = leaderboardID;
    }
    else{
        gcViewController.viewState = GKGameCenterViewControllerStateAchievements;
    }
    
    UIViewController *vc = self.view.window.rootViewController;
    [vc presentViewController:gcViewController animated:YES completion:^{
    }];
}
-(void)updateAchievement{
    
   float progressPercentage500 = 0.0;
    float progressPercentage1000 = 0.0;
    float progressPercentage1500 = 0.0;
    float progressPercentage2000 = 0.0;
    
    
    NSInteger highScore = [[NSUserDefaults standardUserDefaults]integerForKey:@"highScore"];
    
    GKAchievement *score500Ach = nil;
    GKAchievement *score1000Ach = nil;
    GKAchievement *score1500Ach = nil;
    GKAchievement *score2000Ach = nil;
    



        progressPercentage500 = highScore * 100 / 500;
    if (progressPercentage500 > 100.0){
        progressPercentage500 = 100.0;
    }

        progressPercentage1000 = highScore * 100 / 1000;
    
   
    progressPercentage1500 = highScore *100/1500;
    
    progressPercentage2000 = highScore *100 /2000;
    
    

    score500Ach = [[GKAchievement alloc] initWithIdentifier:@"500points"];
    score500Ach.percentComplete = progressPercentage500;
    
    
    score1000Ach = [[GKAchievement alloc]initWithIdentifier:@"1000Points"];
    score1000Ach.percentComplete = progressPercentage1000;
    
    
    score1500Ach = [[GKAchievement alloc] initWithIdentifier:@"1500points"];
    score1500Ach.percentComplete = progressPercentage1500;
    
    
    score2000Ach = [[GKAchievement alloc] initWithIdentifier:@"2000points"];
    score2000Ach.percentComplete = progressPercentage2000;
    
    
    
    NSInteger coins = [[NSUserDefaults standardUserDefaults]integerForKey:@"coins"];
    
    
    float coinProg100 = 0.0;
    float coinProg500 = 0.0;
    float coinProg1000 = 0.0;
    float coinProg5000 = 0.0;
    
    GKAchievement *coin100Ach = nil;
    GKAchievement *coin500Ach = nil;
    GKAchievement *coin1000Ach = nil;
    GKAchievement *coin5000Ach = nil;

    coinProg100 = coins *100 / 100;
    coinProg500 = coins *100 / 500;
    coinProg1000 = coins*100 / 1000;
    coinProg5000 = coins*100 / 5000;
    
    coin100Ach = [[GKAchievement alloc] initWithIdentifier:@"100coins"];
    coin100Ach.percentComplete = coinProg100;
    
    coin500Ach = [[GKAchievement alloc] initWithIdentifier:@"500coins"];
    coin500Ach.percentComplete = coinProg500;
    
    coin1000Ach = [[GKAchievement alloc] initWithIdentifier:@"1000coins"];
    coin1000Ach.percentComplete = coinProg1000;
    
    coin5000Ach = [[GKAchievement alloc] initWithIdentifier:@"5000coins"];
    coin5000Ach.percentComplete = coinProg5000;

    
    
    NSArray *achievements = @[score500Ach,score1000Ach,score1500Ach,score2000Ach,coin100Ach,coin500Ach,coin1000Ach,coin5000Ach];
    
    [GKAchievement reportAchievements:achievements withCompletionHandler:^(NSError *error) {
        if (error != nil) {
                     NSLog(@"%@",[error localizedDescription]);
        }
    }];
   
    
}

/*GameCenter*/

-(void)addFish{
SKAction *custom = [SKAction customActionWithDuration:0 actionBlock:^(SKNode *node, CGFloat elapsedTime) {
    SKFish *fish = [[SKFish alloc] initWithImageNamed:@"fish1"];
    [self addChild:fish];

}];
   
    [self runAction:[SKAction repeatActionForever:[SKAction sequence:@[custom,[SKAction waitForDuration:1]]]]];
  }

-(void)addHoles{
    
    SKAction *custom = [SKAction customActionWithDuration:0 actionBlock:^(SKNode *node, CGFloat elapsedTime) {
        iceHole = [[SKIceHole alloc] initWithImageNamed:@"iceHole"];
        if (!pauseGame){
        [self addChild:iceHole];
        [iceHole addExtras];

        }
    }];
    
    [self runAction:[SKAction repeatActionForever:[SKAction sequence:@[[SKAction waitForDuration:2],custom]]]];
}

-(void)addCoins{
    SKAction *custom = [SKAction customActionWithDuration:0 actionBlock:^(SKNode *node, CGFloat elapsedTime) {
        SKCoin *coin = [[SKCoin alloc] initWithImageNamed:@"coin0"];
        if (!pauseGame){
        [self addChild:coin];
        }
    }];
    
    [self runAction:[SKAction repeatActionForever:[SKAction sequence:@[[SKAction waitForDuration:2.25],custom]]]];
}

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
        /* Setup your scene here */
        isShowingInstruct = false;
        
        [addMine setDuration:0];
    
        [self startBackgroundMusic];
        
        [self authenticateLocalPlayer]; //GameCenter//
        
        isSnowing = false;
        
        activityViewController =
        [[UIActivityViewController alloc] initWithActivityItems:nil
                                          applicationActivities:nil];
        pauseGame = true;
        gameOver = false;
        
        CGRect screenBound = [[UIScreen mainScreen] bounds];
        CGSize screenSize = screenBound.size;
        screenWidth = screenSize.width;
        screenHeight =screenSize.height;
        
        NSLog(@"h:%f W:%f",screenHeight,screenWidth);
        
        TANKS=0x1<<0;
        MISSLES=0x1<<1;
        MINES=0x1<<2;
        WALLS=0x1<<3;
        HOLES=0x1<<4;
        COINS=0x1<<5;
        self.physicsWorld.contactDelegate=self;
        
        self.backgroundColor = [SKColor colorWithRed:0.0 green:0.3 blue:1.0 alpha:1.0];
        backgroundNode = [[SKbackgroudNode alloc]init];
        tank = [[SKTiltTank alloc] initWithImageNamed:@"tank4bot"];
        mine = [[SKMine alloc]initWithImageNamed:@"mine001"];
        [self addChild:backgroundNode];
        scoreBoard = [[SKScoreBoard alloc]init];
        [scoreBoard setPosition:CGPointMake(screenWidth/2, screenHeight/1.3)];
        scoreBoard.zPosition = 10;
        [self addChild:scoreBoard];
        
        instructions = [[SKInstructions alloc]initWithImageNamed:@"howto"];
        instructions.position = CGPointMake(screenWidth/2, screenHeight/2);
        [instructions setScale:screenWidth/320];
        instructions.zPosition = 10;
        menu = [[SKMenu alloc] initWithImageNamed:@"menu"];
        [self addChild:menu];
        [self setTankImage:@"tank0bot" topImage:@"tank0top"];
        [self addSnow];
         
        
           }
        return self;
}
-(void)showMenu{
    gameOver = true;
    [self addChild:menu];
    [menu returnFromGame];
}
-(void)setTankImage:(NSString *)botImage topImage:(NSString *)topImage{
    
    [tank removeFromParent];
    tank = [[SKTiltTank alloc] initWithImageNamed:botImage];
    [self addChild:tank]; //problem here
    [tank addTopOfTank:topImage];
}
-(void)addTankTopImage:(SKSpriteNode *)t{
    
    [topOfTank removeFromParent];
    topOfTank = t;
    [self addChild:topOfTank];
    
}
-(void)addSnow{
    if (!isSnowing){
    int x = arc4random()%5;
    
    if (x == 1){
        NSString *emitterPath = [[NSBundle mainBundle] pathForResource:@"snow" ofType:@"sks"];
        snow = [NSKeyedUnarchiver unarchiveObjectWithFile:emitterPath];
        [snow setScale:screenWidth/320];
        snow.position = CGPointMake(screenWidth/2, screenHeight);
        [self addChild:snow];
        isSnowing = true;
    }
    }
    
    else {
        isSnowing = false;
    }
}
-(void)removeSnow{
    [snow removeFromParent];
    isSnowing = false;
}
-(void)addMines{
    
    addMine = [SKAction customActionWithDuration:addMine.duration actionBlock:^(SKNode *node, CGFloat elapsedTime) {
        mine = [[SKMine alloc] initWithImageNamed:@"mine001"];
        [mine setScale:screenWidth/320];
        [mine setRandomXPosition];
        SKAction *move = [SKAction moveBy:CGVectorMake(0, -screenHeight - mine.frame.size.height) duration:4];
        SKAction *rem = [SKAction removeFromParent];
        SKAction *wait = [SKAction waitForDuration:1];
        
        if (!pauseGame){
            [mine runAction:[SKAction sequence:@[move,wait,rem]]];
            [self addChild:mine];
            [mine blinkAnimation];
        }
        
        
    }];
    SKAction *wait = [SKAction waitForDuration:2];
    SKAction *changeDuration =[SKAction customActionWithDuration:1 actionBlock:^(SKNode *node, CGFloat elapsedTime) {
        [addMine setDuration:[addMine duration]+0.0001];
    }];
    
    
    SKAction *custom = [SKAction customActionWithDuration:0 actionBlock:^(SKNode *node, CGFloat elapsedTime) {
        [self runAction:[SKAction sequence:@[wait,addMine,changeDuration]]];
    }];
    
    [self runAction:[SKAction repeatActionForever:[SKAction sequence:@[[SKAction waitForDuration:2],custom]]]];
    
    
}
-(void)togglePause{
    if (!pauseGame) {
        //pause
        pauseGame = true;
    }else{
        //unpause
        pauseGame = false;
        [scoreBoard clearScore];
    }
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if (!pauseGame){
        [self playSoundNamed:@"shoot2"];
        SKMissile *missile;
        if ([[tank getCurrentTankName]isEqualToString:@"tank4"]){
            missile = [[SKMissile alloc]initWithImageNamed:@"missile2"];
        }
        else {
            missile = [[SKMissile alloc]initWithImageNamed:@"missile1"];
        }
        
            [self addChild:missile];
            [missile setOriginTank:tank];
        [missile runAction:[tank changeMissileColorForTank:[NSString stringWithFormat:@"tank%li",(long)[tank getCurrentTankIndex]]]];
        [missile fireMissile];
    }
    else{
        if (isShowingInstruct){
        [instructions touchesBegan:touches withEvent:event];
        }
        [menu touchesBegan:touches withEvent:event];
        [gameOverMenu touchesBegan:touches withEvent:event];

    }
    }
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
     [menu touchesEnded:touches withEvent:event];
}
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    [menu touchesCancelled:touches withEvent:event];
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [menu touchesMoved:touches withEvent:event];
}
-(void)update:(CFTimeInterval)currentTime {
    

     if (!pauseGame){
    [backgroundNode update:currentTime];
    [tank update:currentTime];
    [iceHole update:currentTime];
    [scoreBoard update:currentTime];
            }
}

-(void)addChild:(SKNode *)node{
    [super addChild:node];
}

-(void)didEndContact:(SKPhysicsContact *)contact{

    [tank removeAllChildren];
}
-(void)didBeginContact:(SKPhysicsContact *)contact{
   
    SKMissile *missile;
    SKIceHole *hole;
    SKCoin *coin;

    if (contact.bodyA.node.physicsBody.categoryBitMask==MINES && contact.bodyB.node.physicsBody.categoryBitMask==MISSLES){
        [self playSoundNamed:@"explode"];
        mine = (SKMine *)contact.bodyA.node;
        missile = (SKMissile *)contact.bodyB.node;
        [mine indicator];
         [scoreBoard addToScore:1];
        [missile removeFromParent];
        [mine explodeMine];
        
            
        }
    else if (contact.bodyA.node.physicsBody.categoryBitMask==MISSLES && contact.bodyB.node.physicsBody.categoryBitMask==MINES){
        [self playSoundNamed:@"explode"];
        mine = (SKMine *)contact.bodyB.node;
        missile = (SKMissile *)contact.bodyA.node;
        [mine indicator];
         [scoreBoard addToScore:1];
        [missile removeFromParent];
        [mine explodeMine];
    }
 /**/  else if (contact.bodyA.node.physicsBody.categoryBitMask==WALLS && contact.bodyB.node.physicsBody.categoryBitMask==TANKS){
        tank = (SKTiltTank *)contact.bodyB.node;
        [tank addTrackSpark];
    }
/**/  else if (contact.bodyA.node.physicsBody.categoryBitMask==TANKS && contact.bodyB.node.physicsBody.categoryBitMask==MINES){
      AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        tank = (SKTiltTank *)contact.bodyA.node;
        mine = (SKMine *)contact.bodyB.node;
                  [mine explodeMine];
        [self gameOver];
    }

else if (contact.bodyA.node.physicsBody.categoryBitMask==TANKS && contact.bodyB.node.physicsBody.categoryBitMask==HOLES){
    [self playSoundNamed:@"fallInIce"];
      AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    tank = (SKTiltTank *)contact.bodyA.node;
    hole = (SKIceHole *)contact.bodyB.node;
    [tank fallInHole];
    [self gameOver];
    
}
else if (contact.bodyA.node.physicsBody.categoryBitMask==HOLES && contact.bodyB.node.physicsBody.categoryBitMask==TANKS){
    [self playSoundNamed:@"fallInIce"];
  AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    tank = (SKTiltTank *)contact.bodyB.node;
    hole = (SKIceHole *)contact.bodyA.node;
    [tank fallInHole];
    [self gameOver];
    
}
else if (contact.bodyA.node.physicsBody.categoryBitMask==TANKS && contact.bodyB.node.physicsBody.categoryBitMask==COINS){
    [self playSoundNamed:@"coin"];
    tank = (SKTiltTank *)contact.bodyA.node;
    coin = (SKCoin *)contact.bodyB.node;
    if (!gameOver){
    
        [coin coinIndicator:10];
    [scoreBoard addToScore:10];
    [scoreBoard addToCoins:1];
    }
    [coin removeFromParent];
    
}
else if (contact.bodyA.node.physicsBody.categoryBitMask==COINS && contact.bodyB.node.physicsBody.categoryBitMask==TANKS){
    [self playSoundNamed:@"coin"];
    tank = (SKTiltTank *)contact.bodyB.node;
    coin = (SKCoin *)contact.bodyA.node;
     if (!gameOver){
         [coin coinIndicator:10];
    [scoreBoard addToScore:10];
    [scoreBoard addToCoins:1];
     }
    [coin removeFromParent];
    
}
else if (contact.bodyA.node.physicsBody.categoryBitMask==COINS && contact.bodyB.node.physicsBody.categoryBitMask==MISSLES){
   
    coin = (SKCoin *)contact.bodyA.node;
    missile = (SKMissile *)contact.bodyB.node;
    NSLog(@" TANK NAME :  %@",[tank getCurrentTankName]);
    if (!gameOver && [[tank getCurrentTankName]isEqualToString:@"tank5"]){
         [self playSoundNamed:@"coin"];
        [coin coinIndicator:20];
        [scoreBoard addToScore:20];
        [scoreBoard addToCoins:2];
        [coin removeFromParent];

    }
    
}
else if (contact.bodyA.node.physicsBody.categoryBitMask==MISSLES && contact.bodyB.node.physicsBody.categoryBitMask==COINS){
    
    coin = (SKCoin *)contact.bodyB.node;
    missile = (SKMissile *)contact.bodyA.node;
   
    if (!gameOver && [[tank getCurrentTankName]isEqualToString:@"tank5"]){
        [self playSoundNamed:@"coin"];
        [coin coinIndicator:20];
        [scoreBoard addToScore:20];
        [scoreBoard addToCoins:2];
        [coin removeFromParent];
        
    }
    
}

    
       }
-(void)hideScoreLabel{
    [scoreBoard hideScorelabel];
}
-(void)startGameAgain{
    [self removeAd];
    [scoreBoard unhideScoreLabel];
     [tank getOutOfHole];
    [menu removeFromParent];
    [addMine setDuration:0];
    [gameOverMenu removeFromParent];
    [scoreBoard clearScore];
        [self addHoles];
        [self addCoins];
        [self addMines];
        [self addFish];
    pauseGame = false;
    gameOver = false;

}
-(void)gameOver{
    if (!gameOver){
        [audioPlayer stop];

        [self displayAd];
        [self removeAllActions];
        [iceHole.extra removeFromParent];
        [mine removeFromParent];
        [iceHole removeFromParent];
        
        if (gameCenterEnabled){
            [self reportScore];
        }
        
        [self removeSnow];
        [scoreBoard stopCounting];
        [addMine setDuration:0];
    pauseGame = true;
     gameOver = true;
      [scoreBoard checkScore:[scoreBoard getScore]];
     gameOverMenu = [[SKGameOverMenu alloc]initWithImageNamed:@"gameOverbg"];
    [gameOverMenu setHighScoreText];
    [self addChild:gameOverMenu];
    [self playSoundNamed:@"GameOver"];
    }
}
-(void)showInstructions{

    if (!isShowingInstruct){
    [self addChild:instructions];
    instructions.hidden = false;
        isShowingInstruct = true;
    }
}
-(void)presentShareView{
    
    UIImage *saveImage = [self snapshot];
    UIGraphicsEndImageContext();
    NSData *imageData = UIImagePNGRepresentation(saveImage);
    
    
    NSString *link =@"https://userpub.itunes.apple.com/WebObjects/MZUserPublishing.woa/wa/addUserReview?type=Purple+Software&id=862478497";
    NSArray* dataToShare = [NSArray arrayWithObjects: [NSString stringWithFormat:@"I just scored %i in Ice Tank! \n Check it out here: %@ ",[scoreBoard getScore],link],[UIImage imageWithData:imageData], nil];
    activityViewController =
    [[UIActivityViewController alloc] initWithActivityItems:dataToShare
                                      applicationActivities:nil];
    
   UIViewController *vc = self.view.window.rootViewController;
    [vc presentViewController:activityViewController animated:YES completion:^{
    }];
    
}
-(UIImage*)snapshot
{
    // Captures SpriteKit content!
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [UIScreen mainScreen].scale/4);
    [self.view drawViewHierarchyInRect:self.frame afterScreenUpdates:NO];
    UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snapshotImage;
}
-(SKTiltTank *)getOriginalTank{
    return tank;
}

-(void)playSoundNamed:(NSString *)sound{

    SKAction *snd = [SKAction playSoundFileNamed:[NSString stringWithFormat:@"%@.wav",sound] waitForCompletion:YES];
    [self runAction:snd];
}
-(void)startBackgroundMusic
{
    if (!backgroundMusicIsPlaying){
       audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"gameSong" ofType:@"wav"]] error:nil];
        [audioPlayer stop];
        audioPlayer.numberOfLoops = -1;
        [audioPlayer setVolume:0.4];
        [audioPlayer prepareToPlay];
        [audioPlayer play];
        backgroundMusicIsPlaying = true;
    }
    backgroundMusicIsPlaying = true;
}

-(void)displayStore{
    UIViewController *vc = self.view.window.rootViewController;
    [vc performSegueWithIdentifier:@"store" sender:nil];
}
-(void)appeared{
    
}
-(void)displayAd{
   
    [audioPlayer stop];
    ViewController *vc = (ViewController *)self.view.window.rootViewController;
    [vc levelDidEnd];
    [self moveCoinLabelUp];
}
-(void)removeAd{
    ViewController *vc = (ViewController *)self.view.window.rootViewController;
    [vc removeAd];
    [self moveCoinLabelDown];
   
}
-(void)disappear{
    [audioPlayer stop];
    [self removeAllActions];
    [self removeAllChildren];
    [self removeFromParent];
    
}
-(void)moveCoinLabelUp{
    if (![[NSUserDefaults standardUserDefaults]boolForKey:@"removeAds"])
    [scoreBoard moveUp];
}
-(void)moveCoinLabelDown{
    if (![[NSUserDefaults standardUserDefaults]boolForKey:@"removeAds"])
    [scoreBoard moveDown];
}
-(void)updateCoinAmount{
     [scoreBoard updatexCoinLabel];
}
-(BOOL)getIsGameOver{
    return gameOver;
}
-(void)setGameOver:(BOOL)game{
    gameOver = game;
}
-(BOOL)getIsSnowing{
    return isSnowing;
}
-(void)setIsSnowing:(BOOL)snowing{
    isSnowing = snowing;
}
-(BOOL)getGamePaused{
    return pauseGame;
}
-(void)setIsShowingInstruct:(BOOL)isShow{
    isShowingInstruct = isShow;
}
@end
