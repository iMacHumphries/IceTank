//
//  SKFish.m
//  ScrappyTank
//
//  Created by Benjamin Humphries on 4/13/14.
//  Copyright (c) 2014 Benjamin Humphries. All rights reserved.
//

#import "SKFish.h"

@implementation SKFish

-(id)initWithImageNamed:(NSString *)name{
    
    self = [super initWithImageNamed:name];
    [self setScreenSize];
    [self randomScale];
    self.zPosition = - 0.1;
    [self setRandomXPosition];
    [self animate];
    [self moveY];
    
    return self;
}
-(void)randomScale{
    int rand = arc4random()%2;
    
    [self setScale:(screenWidth/320) +rand];
}
-(void)setScreenSize{
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    screenWidth = screenSize.width;
    screenHeight =screenSize.height;
}
-(void)setRandomXPosition{
        int x =( arc4random()%305)+15;
    if (screenWidth >600){
        x =( arc4random()%753)+15;
    }
    CGPoint newFishLoc = CGPointMake(x, screenHeight+20);
    self.position = newFishLoc;
}

-(void)animate{
    NSMutableArray *swim = [NSMutableArray array];
    SKTextureAtlas *fishAtlas = [SKTextureAtlas atlasNamed:@"fish"];
    
    NSInteger numImages = fishAtlas.textureNames.count;
    for (int i=0; i < numImages; i++) {
        NSString *textureName = [NSString stringWithFormat:@"fish%i", i];
        SKTexture *temp = [fishAtlas textureNamed:textureName];
        [swim addObject:temp];
        
    }
    NSArray *array = swim;
    
    [self runAction:[SKAction repeatActionForever:
                     [SKAction animateWithTextures:array
                                      timePerFrame:0.1f
                                            resize:NO
                                           restore:YES]]];
}
-(void)moveY{
    int dur = (arc4random()%4) +5;
    SKAction *move = [SKAction moveBy:CGVectorMake(0, -screenHeight - self.frame.size.height) duration:dur];
    SKAction *remove = [SKAction removeFromParent];

    [self runAction:[SKAction sequence:@[move,remove]]];
   
}
@end
