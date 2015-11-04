//
//  MyScene.h
//  ScrappyTank
//

//  Copyright (c) 2014 Benjamin Humphries. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "SKbackgroudNode.h"
#import "SKTiltTank.h"
#import "SKMissile.h"
#import "SKMine.h"
#import "SKScoreBoard.h"
#import "SKMenu.h"
#import "SKGameOverMenu.h"
#import "AppDelegate.h"
#import "SKFish.h"
#import "SKIceHole.h"
#import "SKCoin.h"
#import "SKInstructions.h"

#import <GameKit/GameKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>



@interface MyScene : SKScene<SKPhysicsContactDelegate,GKGameCenterControllerDelegate,AVAudioPlayerDelegate>{
    
    
    /*GameCenter*/
    BOOL gameCenterEnabled;
    NSString *leaderboardID;
    /*GameCenter*/
   
    SKInstructions *instructions;
    
    uint32_t TANKS;
    uint32_t MISSLES;
    uint32_t MINES;
    uint32_t WALLS;
    uint32_t HOLES;
    uint32_t COINS;
    
      SKSpriteNode *bg1;
    SKSpriteNode *bg2;
     float yVelocity;
    SKbackgroudNode *backgroundNode;
   SKTiltTank *tank;
    SKMine *mine;
    SKMenu *menu;
    SKGameOverMenu *gameOverMenu;
    SKEmitterNode *rain;
    CGFloat screenWidth;
    CGFloat screenHeight;
    UIActivityViewController* activityViewController;
    SKAction *addMine;
    SKIceHole *iceHole;
    SKEmitterNode *snow;
    SKSpriteNode *topOfTank;

    BOOL pauseGame;
    BOOL gameOver;
    BOOL msg;
    BOOL isSnowing;
    BOOL isShowingInstruct;
    BOOL backgroundMusicIsPlaying;
    SKScoreBoard *scoreBoard;
    }

/*GameCenter*/
@property (retain,nonatomic) NSString *leaderboardID;
-(void)authenticateLocalPlayer;
-(void)reportScore;
-(void)showLeaderboardAndAchievements:(BOOL)shouldShowLeaderboard;
-(void)updateAchievement;
/*GameCenter*/

-(void)showMenu;
-(void)hideScoreLabel;
-(void)addTankTopImage:(SKSpriteNode *)t;
-(void)addChild:(SKNode *)node;
-(void)togglePause;
-(void)presentShareView;
-(SKTiltTank *)getOriginalTank;
-(void)addSnow;
-(void)showInstructions;
-(void)startGameAgain;
-(void)setTankImage:(NSString *)botImage topImage:(NSString *)topImage;
-(void)displayStore;
-(void)appeared;
-(void)disappear;
-(void)displayAd;
-(void)removeAd;
-(void)updateCoinAmount;
-(BOOL)getIsGameOver;
-(void)setGameOver:(BOOL)game;
-(BOOL)getIsSnowing;
-(BOOL)getGamePaused;
-(void)setIsSnowing:(BOOL)snow;
-(void)setIsShowingInstruct:(BOOL)isShow;

@property (retain,nonatomic)SKSpriteNode *topOfTank;
@property (retain, nonatomic) SKIceHole *iceHole;
@property (retain, nonatomic)SKAction *addMine;
@property (retain,nonatomic)UIActivityViewController* activityViewController;
@property (retain, nonatomic) SKInstructions *instructions;
@property (retain, nonatomic)SKEmitterNode *rain;
@property (retain, nonatomic)SKMine *mine;
@property (retain, nonatomic)SKTiltTank *tank;
@property (retain, nonatomic)SKbackgroudNode *backgroundNode;
@property (retain, nonatomic)SKScoreBoard *scoreBoard;
@property (retain, nonatomic)SKMenu *menu;
@property (retain, nonatomic)SKGameOverMenu *gameOverMenu;
@property (retain, nonatomic)SKSpriteNode *bg1;
@property (retain, nonatomic)SKSpriteNode *bg2;


@end
