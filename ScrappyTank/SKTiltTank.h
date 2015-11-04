//
//  SKTiltTank.h
//  ScrappyTank
//
//  Created by Benjamin Humphries on 4/8/14.
//  Copyright (c) 2014 Benjamin Humphries. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <CoreMotion/CoreMotion.h>
#import "SKbackgroudNode.h"

@interface SKTiltTank : SKSpriteNode{
    CMMotionManager* motionManager;
    CGFloat screenWidth;
    CGFloat screenHeight;
    float speed;
   // SKSpriteNode *tracks;
    uint32_t TANKS;
    uint32_t MISSLES;
    uint32_t MINES;
    uint32_t WALLS;
    uint32_t HOLES;
    uint32_t COINS;
    SKSpriteNode *top;
    NSMutableArray *tankArray;
    NSInteger coinValue;
    NSInteger currentTankIndex;

}
@property (retain, nonatomic)NSMutableArray *tankArray;
@property (retain,nonatomic)SKSpriteNode *top;
//@property (retain,nonatomic)SKSpriteNode *tracks;
@property (strong) CMMotionManager *motionManager;
-(NSMutableArray *)getTankArray;
-(void)addTopOfTank:(NSString *)t;
-(void)addTrackSpark;
-(void)update:(CFTimeInterval)currentTime;
-(CGPoint)getTankPosition;
-(void)fallInHole;
-(void)getOutOfHole;
-(NSInteger)getCoinValueForTank:(NSString *)tankname;
-(SKAction *)changeMissileColorForTank:(NSString *)tankname;
-(void)setCurrenTankIndex:(NSInteger)x;
-(NSInteger)getCurrentTankIndex;
-(NSString *)getCurrentTankName;
@end
