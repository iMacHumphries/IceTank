//
//  SKGameOverMenu.m
//  ScrappyTank
//
//  Created by Benjamin Humphries on 4/10/14.
//  Copyright (c) 2014 Benjamin Humphries. All rights reserved.
//

#import "SKGameOverMenu.h"
#import "SKScoreBoard.h"
#import "MyScene.h"
#import "ViewController.h"
#import "AppDelegate.h"

@implementation SKGameOverMenu{
    MyScene *scene;
    SKScoreBoard *scoreBoard;
}


-(id)initWithImageNamed:(NSString *)name{
    self= [super initWithImageNamed:name];
    scene = (MyScene *)self.parent;
    
     scoreBoard = [[SKScoreBoard alloc]init];
    scoreBoard = (SKScoreBoard*)[scoreBoard getScoreBoard];
    [self setScreenSize];
    self.position = CGPointMake(screenWidth/2 ,screenHeight/1.7);
    
    [self addTitleAndButtons];
    
    return self;
}
-(void)setScreenSize{
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    screenWidth = screenSize.width;
    screenHeight =screenSize.height;
}
-(void)addTitleAndButtons{
    SKLabelNode *gameOver = [SKLabelNode labelNodeWithFontNamed:@"Slant"];
    gameOver.text = @"Game Over";
    gameOver.fontColor = [UIColor blackColor];
    [self addChild:gameOver];
    
    
    SKSpriteNode *replay = [SKSpriteNode spriteNodeWithImageNamed:@"gameoverButton"];
    [replay setScale:1.2];
    replay.name = @"replay";
    replay.position = CGPointMake(-replay.frame.size.width/2,-self.frame.size.height);
    SKLabelNode *reLabel = [SKLabelNode labelNodeWithFontNamed:@"Slant"];
    reLabel.fontColor = [UIColor blackColor];
    reLabel.fontSize = 30;
    reLabel.text = @"Replay";
    reLabel.name = @"r";
    reLabel.position = CGPointMake(0, -reLabel.frame.size.height/2);
    [replay addChild:reLabel];
    
    [self addChild:replay];
    
    
    SKSpriteNode *share = [SKSpriteNode spriteNodeWithImageNamed:@"gameoverButton"];
    [share setScale:1.2];
    share.name = @"share";
    share.position = CGPointMake(share.frame.size.width/2,-self.frame.size.height);
    SKLabelNode *stLabel = [SKLabelNode labelNodeWithFontNamed:@"Slant"];
    stLabel.fontColor = [UIColor blackColor];
    stLabel.fontSize = 30;
    stLabel.text = @"Share";
    stLabel.name = share.name;
    stLabel.position = CGPointMake(0, -stLabel.frame.size.height/2);
    [share addChild:stLabel];
    
    [self addChild:share];
    
    highScoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Slant"];
    highScoreLabel.text = [NSString stringWithFormat:@"Best: "];
    highScoreLabel.position = CGPointMake(0, gameOver.position.y - highScoreLabel.frame.size.height);
    highScoreLabel.fontColor = [UIColor blackColor];
    
    [self addChild:highScoreLabel];
    SKSpriteNode *gameCenter = [SKSpriteNode spriteNodeWithImageNamed:@"button"];
    gameCenter.size = CGSizeMake(gameCenter.frame.size.width *2, gameCenter.frame.size.height);
    [gameCenter setPosition:CGPointMake(0,screenHeight/3)];
    gameCenter.name = @"leader";
    SKLabelNode *statsLabel = [SKLabelNode labelNodeWithFontNamed:@"Slant"];
    statsLabel.text = @"Leaderboard";
    statsLabel.fontColor = [UIColor whiteColor];
    statsLabel.name = gameCenter.name;
    [statsLabel setPosition:CGPointMake(0, -10)];
    
    [gameCenter addChild:statsLabel];
    [self addChild:gameCenter];

    SKSpriteNode *menu = [SKSpriteNode spriteNodeWithImageNamed:@"gameoverButton"];
    menu.position = CGPointMake(0, share.position.y - menu.size.height -10);
    menu.name = @"menu";
    [menu setScale:1.2];
    [self addChild:menu];
    
    SKLabelNode *menuL = [SKLabelNode labelNodeWithFontNamed:@"Slant"];
    menuL.text = @"Menu";
    menuL.fontColor = [UIColor blackColor];
    menuL.name = menuL.text;
    menuL.fontSize = 30;
    [menuL setPosition:CGPointMake(0, -10)];
    [menu addChild:menuL];
    
    
}
-(void)setHighScoreText{
      NSInteger highScore = [[NSUserDefaults standardUserDefaults]integerForKey:@"highScore"];

     highScoreLabel.text = [NSString stringWithFormat:@"Best: %li",(long)highScore];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        SKNode *node=[self nodeAtPoint:location];
        
        if ([node.name isEqualToString:@"replay"]){
            scene = (MyScene *)node.parent.parent;
            [scene setGameOver:false];
            [self removeAllChildren];
            [self removeFromParent];
            [scene togglePause];
             [scene startGameAgain];
            scoreBoard = [scoreBoard getScoreBoard];
            SKLabelNode *scoreLabel = [scoreBoard getScoreLabel];
            SKLabelNode *theNewHighScoreLabel = [scoreBoard getTheNewHighScoreLabel];
            int score = [scoreBoard getScore];
            scoreLabel.text = @"0";
            score = 0;
            [theNewHighScoreLabel removeFromParent];
            SKTiltTank*t = [scene getOriginalTank];
            [t getOutOfHole];
            if (![scene getIsSnowing]){
                [scene addSnow];
            }
        }
        else if ([node.name isEqualToString:@"r"]){
            scene = (MyScene *)node.parent.parent.parent;
             [scene setGameOver:false];
            [self removeAllChildren];
            [self removeFromParent];
            [scene togglePause];
             [scene startGameAgain];
            scoreBoard = [scoreBoard getScoreBoard];
            SKLabelNode *scoreLabel = [scoreBoard getScoreLabel];
            SKLabelNode *theNewHighScoreLabel = [scoreBoard getTheNewHighScoreLabel];
            int score = [scoreBoard getScore];

            scoreLabel.text = @"0";
            score = 0;
            [theNewHighScoreLabel removeFromParent];
            SKTiltTank*t = [scene getOriginalTank];
            [t getOutOfHole];
            if (![scene getIsSnowing]){
                [scene addSnow];
            }
        }
        else if ([node.name isEqualToString:@"share"]){
            
            scene = (MyScene *)self.parent;
            [scene presentShareView];
            
        }
        else if ([node.name isEqualToString:@"leader"]){
            
            scene = (MyScene *)self.parent;
            [scene reportScore];
            [scene showLeaderboardAndAchievements:YES];
            
        }
        else if ([node.name isEqualToString:@"Menu"]){
            scene = (MyScene *)self.parent;
            [self removeAllChildren];
            [self removeFromParent];
            [scene showMenu];
            [scene hideScoreLabel];
            
        }
        else if ([node.name isEqualToString:@"menu"]){
            scene = (MyScene *)self.parent;
            [self removeAllChildren];
            [self removeFromParent];
             [scene showMenu];
             [scene hideScoreLabel];
        }
    }
    

}

@end
