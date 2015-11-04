//
//  SKScoreBoard.h
//  ScrappyTank
//
//  Created by Benjamin Humphries on 4/10/14.
//  Copyright (c) 2014 Benjamin Humphries. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>



@interface SKScoreBoard : SKSpriteNode{
    
    int highScore;
    NSInteger coins;
    CGFloat screenWidth;
    CGFloat screenHeight;
    SKLabelNode *xCoins;

    BOOL isCountingScore;
    int score;
    SKLabelNode *scoreLabel;
    SKLabelNode *theNewHighScoreLabel;
    
}
@property (retain, nonatomic)SKLabelNode *xCoins;
@property (retain,nonatomic)SKLabelNode *theNewHighScoreLabel;
-(void)clearScore;
-(void)addToScore:(int)x;
-(void)addToCoins:(int)x;
-(int)getScore;
-(void)checkScore:(int)lastScore;
-(void)stopCounting;
-(void)increaseScoreByTime;
-(void)update:(CFTimeInterval)currentTime;
-(void)unhideScoreLabel;
-(void)hideScorelabel;
-(void)updatexCoinLabel;
-(void)moveDown;
-(void)moveUp;
-(SKLabelNode *)getScoreLabel;
-(SKScoreBoard *)getScoreBoard;
-(SKLabelNode *)getTheNewHighScoreLabel;
@end
