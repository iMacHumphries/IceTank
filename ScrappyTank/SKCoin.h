//
//  SKCoin.h
//  ScrappyTank
//
//  Created by Benjamin Humphries on 4/15/14.
//  Copyright (c) 2014 Benjamin Humphries. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface SKCoin : SKSpriteNode{
    CGFloat screenWidth;
    CGFloat screenHeight;
    uint32_t TANKS;
    uint32_t MISSLES;
    uint32_t MINES;
    uint32_t WALLS;
    uint32_t HOLES;
    uint32_t COINS;

}
-(void)coinIndicator:(NSInteger)x;

@end
