//
//  SKScoreBoard.m
//  ScrappyTank
//
//  Created by Benjamin Humphries on 4/10/14.
//  Copyright (c) 2014 Benjamin Humphries. All rights reserved.
//

#import "SKScoreBoard.h"
#import "SKGameOverMenu.h"
#import "MyScene.h"
@implementation SKScoreBoard{
    SKSpriteNode *coin;

}
@synthesize theNewHighScoreLabel;
@synthesize xCoins;


-(id)init{
    self = [super init];
   
    [self setScreenSize];
    isCountingScore = false;
    score = 0;
    coins = [[NSUserDefaults standardUserDefaults] integerForKey:@"coins"];
    scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Slant"];
    [scoreLabel setFontSize:60];
    [scoreLabel setFontColor:[UIColor whiteColor]];
    scoreLabel.text = @"0";
    [self addChild:scoreLabel];
    [self setupForNewHighScore];
    [self increaseScoreByTime];
    [self coinCountLabel];
    scoreLabel.hidden = true;
    return self;
}
-(void)setScreenSize{
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    screenWidth = screenSize.width;
    screenHeight =screenSize.height;
}
-(void)coinCountLabel{
    coin = [[SKSpriteNode alloc] initWithImageNamed:@"coin1"];
   // coin.position = CGPointMake(-screenWidth/2 +20, screenHeight/4.2 );
          //y -1.37
    //.56
    coin.position = CGPointMake(screenWidth/-2 +20, screenHeight/-1.37);
    xCoins = [SKLabelNode labelNodeWithFontNamed:@"Slant"];
    xCoins.text = [NSString stringWithFormat:@"x %li",(long)coins];
    xCoins.position = CGPointMake(coin.position.x + xCoins.frame.size.width, coin.position.y - xCoins.frame.size.height/2);
   
    [self addChild:xCoins];
    [self addChild:coin];

    if (![[NSUserDefaults standardUserDefaults]boolForKey:@"removeAds"]){
        //there are adds
        [self moveUp];
    }

    
}
-(void)hideScorelabel{
    scoreLabel.hidden = true;
}
-(void)unhideScoreLabel{
    scoreLabel.hidden = false;
}
-(void)increaseScoreByTime{

    MyScene *scene = (MyScene *)self.parent;
    
    SKAction *addScore = [SKAction customActionWithDuration:0 actionBlock:^(SKNode *node, CGFloat elapsedTime) {
        score++;
        [scoreLabel setText:[NSString stringWithFormat:@"%i",score]];
        
    }];
    if (![scene getGamePaused]){
    [self runAction:[SKAction repeatActionForever:[SKAction sequence:@[[SKAction waitForDuration:.1],addScore]]]];
        isCountingScore = true;

    }else{
        isCountingScore = false;

    }
}
-(void)stopCounting{
    [self removeAllActions];
    isCountingScore = false;
}
-(void)setupForNewHighScore{
    theNewHighScoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Slant"];
    theNewHighScoreLabel.text = @"NEW HIGH SCORE!";
    theNewHighScoreLabel.position = CGPointMake(0, scoreLabel.frame.origin.y + theNewHighScoreLabel.frame.size.height + 10);
    theNewHighScoreLabel.hidden = true;
    [self addChild:theNewHighScoreLabel];
}
-(void)addToScore:(int)x{
    score = score + x;
    scoreLabel.text = [NSString stringWithFormat:@"%i",score];
    [[NSUserDefaults standardUserDefaults]setInteger:score forKey:@"score"];
    
}
-(void)addToCoins:(int)x{
   

    SKAction *scaleUp = [SKAction scaleTo:1.3 duration:0.1];
    SKAction *scaleDown = [SKAction scaleTo:1 duration:0.1];
    
    [xCoins runAction:[SKAction sequence:@[scaleUp,scaleDown]]];
    coins = coins +x;
    xCoins.text = [NSString stringWithFormat:@"x %li",(long)coins];
    [[NSUserDefaults standardUserDefaults]setInteger:coins forKey:@"coins"];
}

-(int)getScore{
    return score;
}

-(void)checkScore:(int)lastScore{
    NSInteger high = [[NSUserDefaults standardUserDefaults]integerForKey:@"highScore"];
   
    if (lastScore > high) {
        highScore = lastScore;
        [[NSUserDefaults standardUserDefaults]setInteger:highScore forKey:@"highScore"];
        theNewHighScoreLabel.hidden = false;
        [self blink];

    }
    else {
    theNewHighScoreLabel.hidden = true;
    }
}
-(void)clearScore{
    score = 0;
    scoreLabel.text = @"0";
   
}
-(void)blink{
    
    SKAction *fade = [SKAction fadeAlphaTo:0.4 duration:.1];
    SKAction *back = [SKAction fadeAlphaTo:1.0 duration:.1];
    [theNewHighScoreLabel runAction:[SKAction repeatAction:[SKAction sequence:@[fade,back]] count:10]completion:^{
        [theNewHighScoreLabel setHidden:true];
    }];
    
}
-(void)updatexCoinLabel{

    coins = [[NSUserDefaults standardUserDefaults]integerForKey:@"coins"];
    [self addToCoins:0];
}
-(void)update:(CFTimeInterval)currentTime {
    
    [self unhideScoreLabel];
    
    if (!isCountingScore){
        [self increaseScoreByTime];
    }
    
}
-(void)moveDown{
    
    CGPoint point =CGPointMake(screenWidth/-2 +20, screenHeight/-1.37);
    
    [coin runAction:[SKAction moveTo:point duration:0.2]];
    [xCoins runAction:[SKAction moveTo:CGPointMake(coin.position.x + xCoins.frame.size.width, point.y - xCoins.frame.size.height/2) duration:0.1]];
  
}
-(void)moveUp{
    
    CGPoint point =CGPointMake(screenWidth/-2 +20, screenHeight/-1.56);

    
    [coin runAction:[SKAction moveTo:point duration:0.2]];
    [xCoins runAction:[SKAction moveTo:CGPointMake(coin.position.x + xCoins.frame.size.width, point.y - xCoins.frame.size.height/2) duration:0.1]];
    
}
-(SKLabelNode *)getScoreLabel{
    return scoreLabel;
}
-(SKLabelNode *)getTheNewHighScoreLabel{
    return theNewHighScoreLabel;
}
-(SKScoreBoard *)getScoreBoard{
    return self;
}
@end
