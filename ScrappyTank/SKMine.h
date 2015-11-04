//
//  SKMine.h
//  ScrappyTank
//
//  Created by Benjamin Humphries on 4/8/14.
//  Copyright (c) 2014 Benjamin Humphries. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface SKMine : SKSpriteNode{
    CGFloat screenWidth;
    CGFloat screenHeight;
    uint32_t TANKS;
    uint32_t MISSLES;
    uint32_t MINES;
    uint32_t WALLS;
    uint32_t HOLES;
    uint32_t COINS;

}

-(CGPoint)getPosition;
-(void)setRandomXPosition;
-(void)explodeMine;
-(void)blinkAnimation;
-(void)indicator;
@end
