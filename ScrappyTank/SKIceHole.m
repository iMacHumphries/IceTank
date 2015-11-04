//
//  SKIceHole.m
//  ScrappyTank
//
//  Created by Benjamin Humphries on 4/13/14.
//  Copyright (c) 2014 Benjamin Humphries. All rights reserved.
//

#import "SKIceHole.h"

@implementation SKIceHole
@synthesize extra;

-(id)initWithImageNamed:(NSString *)name{
    self = [super initWithImageNamed:name];
    TANKS=0x1<<0;
    MISSLES=0x1<<1;
    MINES=0x1<<2;
    WALLS=0x1<<3;
    HOLES=0x1<<4;
    COINS=0x1<<5;
     extra =[SKSpriteNode spriteNodeWithImageNamed:@"iceHoleExtras"];
     extra.position = self.position;
    [self setupPhysics];
    [self setScreenSize];
       [self randomScale];
    [self setRandomXPosition];
    [self moveY];
    [self setAlpha:0.65];

    return self;
}
-(void)addExtras{
    extra =[SKSpriteNode spriteNodeWithImageNamed:@"iceHoleExtras"];
    extra.position = self.position;
    //extra.zPosition = self.zPosition -0.1;
   // extra.zRotation = self.zRotation;
    [self.parent addChild:extra];
    SKAction *move = [SKAction moveBy:CGVectorMake(0, -screenHeight - self.frame.size.height) duration:4];
    SKAction *remove = [SKAction removeFromParent];
    [extra runAction:[SKAction sequence:@[move,remove]]];

}
-(void)setupPhysics{
    CGSize size = CGSizeMake(self.frame.size.width -35 , self.frame.size.height - 30);
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:size];
    self.physicsBody.dynamic = NO;
    self.physicsBody.affectedByGravity = NO;
    self.physicsBody.mass = 0.2;
    self.physicsBody.categoryBitMask = HOLES;
    self.physicsBody.contactTestBitMask =  TANKS | MINES;
    self.physicsBody.collisionBitMask = MINES | TANKS| HOLES;
}
-(void)setScreenSize{
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    screenWidth = screenSize.width;
    screenHeight =screenSize.height;
}
-(void)randomScale{
    int rand = arc4random()%2;
    scale =(screenWidth/320) +rand;
    [self setScale:scale];
    [extra setScale:scale];

}
-(void)setRandomXPosition{
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    screenWidth = screenSize.width;
    screenHeight =screenSize.height;
    int x =( arc4random()%305)+15;
    if (screenWidth >600){
        x =( arc4random()%753)+15;
    }
    CGPoint newTurretLoc = CGPointMake(x, screenHeight+20);
    self.position = newTurretLoc;
}
-(void)moveY{
    SKAction *move = [SKAction moveBy:CGVectorMake(0, -screenHeight - self.frame.size.height) duration:4];
    SKAction *remove = [SKAction removeFromParent];
    
    [self runAction:[SKAction sequence:@[move,remove]]];
     [extra runAction:[SKAction sequence:@[move,remove]]];
    
}
-(void)update:(CFTimeInterval)currentTime {
    [extra setScale:scale];
}
@end
