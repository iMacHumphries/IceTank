//
//  SKMenu.h
//  ScrappyTank
//
//  Created by Benjamin Humphries on 4/10/14.
//  Copyright (c) 2014 Benjamin Humphries. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
BOOL tank0Unlocked;
BOOL tank1Unlocked;
BOOL tank2Unlocked;
BOOL tank3Unlocked;
BOOL tank4Unlocked;
BOOL tank5Unlocked;
@interface SKMenu : SKSpriteNode{
    CGFloat screenWidth;
    CGFloat screenHeight;
    SKSpriteNode *start;
    NSInteger tankIndex;
    SKSpriteNode *lockimage;
    NSInteger coins;

    
}

@property (retain, nonatomic) SKSpriteNode *start;
@property (retain,nonatomic) SKSpriteNode *lockimage;


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)returnFromGame;
@end
