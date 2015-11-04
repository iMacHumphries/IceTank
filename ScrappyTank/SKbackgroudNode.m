//
//  SKbackgroudNode.m
//  ScrappyTank
//
//  Created by Benjamin Humphries on 4/7/14.
//  Copyright (c) 2014 Benjamin Humphries. All rights reserved.
//

#import "SKbackgroudNode.h"

@implementation SKbackgroudNode
@synthesize bg1,bg2;
@synthesize mine;
@synthesize wall1,wall2,wall3,wall4;

-(id)init{
    TANKS=0x1<<0;
    MISSLES=0x1<<1;
    MINES=0x1<<2;
    WALLS=0x1<<3;
    HOLES=0x1<<4;
    COINS=0x1<<5;
    self = [super init];
    
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    screenWidth = screenSize.width;
    screenHeight =screenSize.height;
    self.position = CGPointMake(0, self.frame.size.height);
    yVelocity = 4;
    [self addBackgroundNodes];
    [self setAlpha:0.8];

    return self;
}

-(void)addBackgroundNodes{
    bg1 = [SKSpriteNode spriteNodeWithImageNamed:@"ice1"];
    bg1.size = CGSizeMake(screenWidth, bg1.size.height);
    if (screenWidth > 500){
        bg1.size = CGSizeMake(screenWidth, screenHeight);
    }
    bg1.anchorPoint = CGPointZero;
    bg1.position = CGPointMake(0, 0);
    wall1 = [self addPhysicsWithPos:CGPointMake(0, bg1.frame.size.height/2)];
    wall2 = [self addPhysicsWithPos:CGPointMake(screenWidth +5, bg1.frame.size.height/2)];
   
    [bg1 addChild:wall1];
    [bg1 addChild:wall2];
    [self addChild:bg1];
    
    
    
    
    bg2 = [SKSpriteNode spriteNodeWithImageNamed:@"ice1"];
    bg2.size = CGSizeMake(screenWidth, bg2.size.height);
    if (screenWidth > 500){
        bg2.size = CGSizeMake(screenWidth, screenHeight);
    }
    bg2.anchorPoint = CGPointZero;
    bg2.position = CGPointMake(0, bg1.frame.size.height);
    
    
    wall3 = [self addPhysicsWithPos:CGPointMake(0, bg2.frame.size.height/2 +1)];
    
    wall4 = [self addPhysicsWithPos:CGPointMake(screenWidth +5, bg2.frame.size.height/2 +1)];
    
    [bg2 addChild:wall3];
    [bg2 addChild:wall4];
    [self addChild:bg2];
    yVelocity = 3;
}
-(SKNode *)addPhysicsWithPos:(CGPoint)pos{
    SKNode *node = [[SKNode alloc] init];
    SKPhysicsBody *bd = [[SKPhysicsBody alloc] init];
    bd = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(10, bg1.frame.size.height)];
    [bd setDynamic:NO];
    [bd setAffectedByGravity:NO];
    [bd setCategoryBitMask:WALLS]; //is a wall
    [bd setCollisionBitMask:TANKS]; //hit tanks
    [bd setContactTestBitMask:TANKS];
    node.position = pos;
    node.physicsBody = bd;
    return node;
}
-(void)update:(CFTimeInterval)currentTime {
    
    bg1.position = CGPointMake(0, bg1.position.y-yVelocity);
    bg2.position = CGPointMake(0, bg2.position.y-yVelocity);
    
    if (bg1.position.y <= -bg1.frame.size.height){
        bg1.position = CGPointMake(0, bg2.position.y + bg2.frame.size.height);
           }
    
    else if (bg2.position.y <= -bg2.frame.size.height) {
        bg2.position = CGPointMake(0, bg1.position.y + bg1.frame.size.height);
    }

    
}

-(SKSpriteNode *)getCurrentBg{
    
    if (bg1.position.y >= -bg1.frame.size.height){
        return bg2;
    }
    
    else  {
        
        return bg1;
    }

}

@end
