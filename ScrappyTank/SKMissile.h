//
//  SKMissile.h
//  ScrappyTank
//
//  Created by Benjamin Humphries on 4/8/14.
//  Copyright (c) 2014 Benjamin Humphries. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "SKTiltTank.h"


@interface SKMissile : SKSpriteNode{
    SKTiltTank *tank;
    float speed;
    uint32_t TANKS;
    uint32_t MISSLES;
    uint32_t MINES;
    uint32_t WALLS;
    uint32_t HOLES;
    uint32_t COINS;
    CGFloat screenWidth;
    CGFloat screenHeight;
    int fireRate;
}

@property (retain, nonatomic)SKTiltTank *tank;
-(void)update:(CFTimeInterval)currentTime;
-(void)fireMissile;
-(BOOL)isReadyToFire;
-(void)setOriginTank:(SKTiltTank *)t;
-(void)explode;
@end
