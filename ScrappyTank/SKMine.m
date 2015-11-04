//
//  SKMine.m
//  ScrappyTank
//
//  Created by Benjamin Humphries on 4/8/14.
//  Copyright (c) 2014 Benjamin Humphries. All rights reserved.
//

#import "SKMine.h"
#import "SKbackgroudNode.h"
#import "MyScene.h"
#import "SKScoreBoard.h"

@implementation SKMine{
}


-(id)initWithImageNamed:(NSString *)name{
    self = [super initWithImageNamed:name];
    TANKS=0x1<<0;
    MISSLES=0x1<<1;
    MINES=0x1<<2;
    WALLS=0x1<<3;
    HOLES=0x1<<4;
    COINS=0x1<<5;

    [self setupPhysics];

        return self;
}

-(void)setupPhysics{
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
    //self.physicsBody.dynamic = YES;
    self.physicsBody.affectedByGravity = NO;
    self.physicsBody.mass = 0.02;
    self.physicsBody.categoryBitMask = MINES; //this is a mine
    self.physicsBody.contactTestBitMask = TANKS | MISSLES | HOLES; //tanks can hit mines
    self.physicsBody.collisionBitMask = TANKS | MISSLES | MINES |HOLES;
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
    CGPoint newMineLoc = CGPointMake(x, screenHeight+20);
    self.position = newMineLoc;
}
-(CGPoint)getPosition{
    [self setRandomXPosition];
    return self.position;
}
-(void)explodeMine{
    NSString *emitterPath = [[NSBundle mainBundle] pathForResource:@"explosion" ofType:@"sks"];
    SKEmitterNode *explode = [NSKeyedUnarchiver unarchiveObjectWithFile:emitterPath];
    explode.position = CGPointMake(self.position.x ,self.position.y);
    [self.parent addChild:explode];
    SKAction *rem = [SKAction removeFromParent];
    [self runAction:rem];
    
    
}
-(void)moveY{
    SKAction *move = [SKAction moveBy:CGVectorMake(0, -screenHeight - self.frame.size.height) duration:4];
    SKAction *remove = [SKAction removeFromParent];
    
    [self runAction:[SKAction sequence:@[move,remove]]];
    
}

-(void)blinkAnimation{

    SKAction *light = [SKAction colorizeWithColor:[UIColor yellowColor] colorBlendFactor:0.9 duration:0.5];
    SKAction *normal = [SKAction colorizeWithColor:[UIColor blackColor] colorBlendFactor:0.9 duration:0.5];
    
    [self runAction:[SKAction repeatActionForever:[SKAction sequence:@[light,normal]]]];
}
-(void)indicator{
    
    SKLabelNode *indicator = [SKLabelNode labelNodeWithFontNamed:@"Slant"];
    indicator.text = @"+1";
    indicator.fontSize = 25;
    indicator.alpha = 0.7;
    indicator.position = self.position;
    indicator.fontColor = [UIColor whiteColor];
    SKAction* fadeIn =[SKAction fadeAlphaTo:1 duration:0.5];
    SKAction *fadeOut = [SKAction fadeAlphaTo:0.0 duration:0.9];
    SKAction *remove = [SKAction removeFromParent];
    
    
    [self.parent addChild:indicator];
    [indicator runAction:[SKAction sequence:@[fadeIn,fadeOut,remove]]];
    
}
@end
