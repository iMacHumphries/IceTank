//
//  SKIceHole.h
//  ScrappyTank
//
//  Created by Benjamin Humphries on 4/13/14.
//  Copyright (c) 2014 Benjamin Humphries. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface SKIceHole : SKSpriteNode{
    uint32_t TANKS;
    uint32_t MISSLES;
    uint32_t MINES;
    uint32_t WALLS;
    uint32_t HOLES;
    uint32_t COINS;
    
    CGFloat screenWidth;
    CGFloat screenHeight;
    SKSpriteNode *extra;
    float scale;

}
@property (retain, nonatomic)SKSpriteNode *extra;
-(void)addExtras;
-(void)update:(CFTimeInterval)currentTime;
@end
