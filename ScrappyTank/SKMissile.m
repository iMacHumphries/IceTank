//
//  SKMissile.m
//  ScrappyTank
//
//  Created by Benjamin Humphries on 4/8/14.
//  Copyright (c) 2014 Benjamin Humphries. All rights reserved.
//

#import "SKMissile.h"
#import "MyScene.h"


@implementation SKMissile{

}

@synthesize tank;




-(id)initWithImageNamed:(NSString *)name{
    TANKS=0x1<<0;
    MISSLES=0x1<<1;
    MINES=0x1<<2;
    WALLS=0x1<<3;
    HOLES=0x1<<4;
    COINS=0x1<<5;


    self = [super initWithImageNamed:name];
    [self setScreenSize];
    [self setupPhysics];
    [self setScale:screenWidth/320];
    speed = 5;
     fireRate = 0;
    [self updateFireRate];
    
    MyScene *scene = (MyScene *)self.parent;
    tank = [scene getOriginalTank];
    
    return self;
}
-(void)updateFireRate{
    
    SKAction *add = [SKAction customActionWithDuration:1
    actionBlock:^(SKNode *node, CGFloat elapsedTime) {
        fireRate++;
        
    }];
    [self runAction:[SKAction repeatActionForever:add]];
}
-(void)setScreenSize{
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    screenWidth = screenSize.width;
    screenHeight =screenSize.height;
}
-(void)flameEffect{
       if ([[tank getCurrentTankName] isEqualToString:@"tank4"]){
           NSString *emitterPath = [[NSBundle mainBundle] pathForResource:@"flame2" ofType:@"sks"];
           SKEmitterNode *flame1 = [NSKeyedUnarchiver unarchiveObjectWithFile:emitterPath];
           SKEmitterNode *flame2 = [NSKeyedUnarchiver unarchiveObjectWithFile:emitterPath];

           flame1.position = CGPointMake(self.size.width/2.3, self.position.y - self.frame.size.height/2);
           flame2.position = CGPointMake(-self.size.width/2.3, self.position.y - self.frame.size.height/2);
           [self addChild:flame1];
           [self addChild:flame2];

    }
    else {
    NSString *emitterPath = [[NSBundle mainBundle] pathForResource:@"flame2" ofType:@"sks"];
    SKEmitterNode *flame = [NSKeyedUnarchiver unarchiveObjectWithFile:emitterPath];
    flame.position = CGPointMake(self.position.x, self.position.y - self.frame.size.height/2);
    [self addChild:flame];
    }
}


-(void)setupPhysics{
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
    self.physicsBody.dynamic = YES;
    self.physicsBody.affectedByGravity = NO;
    self.physicsBody.mass = 0.2;
    self.physicsBody.categoryBitMask = MISSLES; //this is a missle
    self.physicsBody.contactTestBitMask = MINES | MISSLES | COINS; //missles can hit mines
    self.physicsBody.collisionBitMask = MINES | TANKS;
}
-(void)fireMissile{

   [self flameEffect];
    CGPoint tankPos = [tank getTankPosition];
    CGPoint firePoint = CGPointMake(tankPos.x, tankPos.y+tank.frame.size.height/2+self.frame.size.height/2 +10);
    self.position = firePoint;
    SKAction *move = [SKAction moveBy:CGVectorMake(0, 100 * speed) duration:1];
    SKAction *rem = [SKAction removeFromParent];
    
    [self runAction:[SKAction sequence:@[move,rem]]];
        

}
-(BOOL)isReadyToFire {
    
    if (fireRate > 5){
        return true;
    }
    else{
        
        return false;
    }
}
-(void)setOriginTank:(SKTiltTank *)t{
    tank=t;
}

-(void)update:(CFTimeInterval)currentTime {
  }
-(void)explode{
    NSString *emitterPath = [[NSBundle mainBundle] pathForResource:@"explosion" ofType:@"sks"];
    SKEmitterNode *explode = [NSKeyedUnarchiver unarchiveObjectWithFile:emitterPath];
    explode.position = CGPointMake(self.position.x ,self.position.y);
    [self.parent addChild:explode];
    SKAction *rem = [SKAction removeFromParent];
    [self runAction:rem];
    
}
@end
