//
//  SKbackgroudNode.h
//  ScrappyTank
//
//  Created by Benjamin Humphries on 4/7/14.
//  Copyright (c) 2014 Benjamin Humphries. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "SKMine.h"
@interface SKbackgroudNode : SKNode{
    uint32_t TANKS;
    uint32_t MISSLES;
    uint32_t MINES;
    uint32_t WALLS;
    uint32_t HOLES;
    uint32_t COINS;
    CGFloat screenWidth;
    CGFloat screenHeight;
    float yVelocity;
    SKSpriteNode *bg1;
    SKSpriteNode *bg2;
    SKMine *mine;
    

    
    SKNode *wall1;
    SKNode *wall2;
    SKNode *wall3;
    SKNode *wall4;
}
@property (retain, nonatomic) SKNode *wall1;
@property (retain, nonatomic) SKNode *wall2;
@property (retain, nonatomic) SKNode *wall3;
@property (retain, nonatomic) SKNode *wall4;
@property (retain, nonatomic)SKMine *mine;
@property (retain, nonatomic)SKSpriteNode *bg1;
@property (retain, nonatomic)SKSpriteNode *bg2;
-(void)addBackgroundNodes;
-(void)update:(CFTimeInterval)currentTime;

@end
