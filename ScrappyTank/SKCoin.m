//
//  SKCoin.m
//  ScrappyTank
//
//  Created by Benjamin Humphries on 4/15/14.
//  Copyright (c) 2014 Benjamin Humphries. All rights reserved.
//

#import "SKCoin.h"

@implementation SKCoin

-(id)initWithImageNamed:(NSString *)name{
    self = [super initWithImageNamed:name];
    TANKS=0x1<<0;
    MISSLES=0x1<<1;
    MINES=0x1<<2;
    WALLS=0x1<<3;
    HOLES=0x1<<4;
    COINS=0x1<<5;
    [self setScale:0.8];
    [self setScreenSize];
    [self setScale:screenWidth * .8/320];
    [self setupPhysics];
    [self setRandomXPosition];
    [self animate];
    [self moveY];
    return self;
}
-(void)setScreenSize{
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    screenWidth = screenSize.width;
    screenHeight =screenSize.height;
}
-(void)setupPhysics{
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
    self.physicsBody.dynamic = YES;
    self.physicsBody.affectedByGravity = NO;
    self.physicsBody.mass = 0.2;
    self.physicsBody.categoryBitMask = COINS;
    self.physicsBody.contactTestBitMask =  TANKS|MISSLES;
    self.physicsBody.collisionBitMask =  TANKS;
}
-(void)setRandomXPosition{
    int x =( arc4random()%305)+15;
    if (screenWidth >600){
        x =( arc4random()%753)+15;
    }
    CGPoint newCoinLoc = CGPointMake(x, screenHeight+20);
    self.position = newCoinLoc;
}
-(void)animate{
    NSMutableArray *turn = [NSMutableArray array];
    SKTextureAtlas *coinAtlas = [SKTextureAtlas atlasNamed:@"coin"];
    
    NSInteger numImages = coinAtlas.textureNames.count;
    for (int i=0; i < numImages; i++) {
        NSString *textureName = [NSString stringWithFormat:@"coin%i", i];
        SKTexture *temp = [coinAtlas textureNamed:textureName];
        [turn addObject:temp];
        
    }
    NSArray *array = turn;
    
    [self runAction:[SKAction repeatActionForever:
                     [SKAction animateWithTextures:array
                                      timePerFrame:0.06f
                                            resize:NO
                                           restore:YES]]];
}
-(void)moveY{
   
    SKAction *move = [SKAction moveBy:CGVectorMake(0, -screenHeight - self.frame.size.height) duration:4];
    SKAction *remove = [SKAction removeFromParent];
    
    [self runAction:[SKAction sequence:@[move,remove]]];
    
}
-(void)coinIndicator:(NSInteger)x{
    
    SKLabelNode *indicator = [SKLabelNode labelNodeWithFontNamed:@"Slant"];
    indicator.text = [NSString stringWithFormat:@"+%li",(long)x];
    indicator.fontSize = 20;
    indicator.alpha = 0.5;
    indicator.position = self.position;
    indicator.fontColor = [UIColor whiteColor];
    SKAction* fadeIn =[SKAction fadeAlphaTo:1 duration:0.5];
    SKAction *fadeOut = [SKAction fadeAlphaTo:0.0 duration:0.9];
    SKAction *remove = [SKAction removeFromParent];
    
    
    [self.parent addChild:indicator];
    [indicator runAction:[SKAction sequence:@[fadeIn,fadeOut,remove]]];

}
@end
