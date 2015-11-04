//
//  SKTiltTank.m
//  ScrappyTank
//
//  Created by Benjamin Humphries on 4/8/14.
//  Copyright (c) 2014 Benjamin Humphries. All rights reserved.
//

#import "SKTiltTank.h"
#import "MyScene.h"
@implementation SKTiltTank{
    MyScene *scene;
}
@synthesize motionManager;
//@synthesize tracks;
@synthesize top;
@synthesize tankArray;

-(id)init{
    TANKS=0x1<<0;
    MISSLES=0x1<<1;
    MINES=0x1<<2;
    WALLS=0x1<<3;
    HOLES=0x1<<4;
    COINS=0x1<<5;

    self = [super init];
   
    self.motionManager = [[CMMotionManager alloc] init];
    [self.motionManager startAccelerometerUpdates];
    [self setPhysicsBod];
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    screenWidth = screenSize.width;
    screenHeight =screenSize.height;
    self.position = CGPointMake(screenWidth/2, screenHeight/4);
    speed = 10;
       return self;
}
-(NSMutableArray *)getTankArray{
    
    return tankArray;
}
-(void)addTankToTankArray:(NSString *)tname{
    [tankArray addObject:tname];
    [[NSUserDefaults standardUserDefaults] setObject:tankArray forKey:@"tankArray"];
}
-(id)initWithImageNamed:(NSString *)name{
    TANKS=0x1<<0;
    MISSLES=0x1<<1;
    MINES=0x1<<2;
    WALLS=0x1<<3;
    HOLES=0x1<<4;
    COINS=0x1<<5;

    tankArray = [[NSMutableArray alloc]initWithObjects:
                 @"tank0",
                 @"tank1",
                 @"tank2",
                 @"tank3",
              //   @"tank4",
                // @"tank5",
                 nil];
    
    if (tank4Unlocked){
        [self addTankToTankArray:@"tank4"];
    }
    if (tank5Unlocked){
        [self addTankToTankArray:@"tank5"];
    }


    self = [super initWithImageNamed:name];
    self.motionManager = [[CMMotionManager alloc] init];
    [self.motionManager startAccelerometerUpdates];
     [self setPhysicsBod];
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    screenWidth = screenSize.width;
    screenHeight =screenSize.height;
    self.position = CGPointMake(screenWidth/2, screenHeight/4);
   
    [self addTracks];
     [self setScale:screenWidth/320];
   
       speed = 5;
       return self;
}
-(void)addTopOfTank:(NSString *)t{
    scene = (MyScene *)self.parent;
    top = [SKSpriteNode spriteNodeWithImageNamed:t];
    top.position = self.position;
    [top setScale:screenWidth/320];
  //  [self.parent addChild:top];
    [scene addTankTopImage:top];
    
}
-(void)setPhysicsBod{
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
    self.physicsBody.dynamic = YES;
    self.physicsBody.affectedByGravity = NO;
    self.physicsBody.mass = 0.02;
    self.physicsBody.categoryBitMask = TANKS; //this is a tank
    self.physicsBody.collisionBitMask = WALLS | MINES ;
    self.physicsBody.contactTestBitMask = WALLS | MINES | COINS |HOLES; //tanks can hit mines
    

}
-(void)processUserMotionForUpdate:(NSTimeInterval)currentTime {

    CMAccelerometerData* data = self.motionManager.accelerometerData;
        CGVector v = CGVectorMake(40.0 * data.acceleration.x, 0);
       [self.physicsBody applyForce:v];
        self.zRotation = data.acceleration.x /-1;
        top.position = self.position;


}
-(void)rotateTankbyAngle:(CGFloat)angle{
    [self runAction:[SKAction rotateByAngle:angle duration:1]];
}
-(void)update:(CFTimeInterval)currentTime {
     self.position = CGPointMake(self.position.x, screenHeight/4);
    top.position = self.position;
    [self processUserMotionForUpdate:currentTime];
   
    
   }
-(CGPoint)getTankPosition{
    return self.position;
}


-(void)addTracks{
   
/*
       SKAction *addTracks = [SKAction runBlock:^{
           __block SKSpriteNode *tracks = [[SKSpriteNode alloc] initWithImageNamed:@"track"];
           [tracks setScale:screenWidth/320];
           tracks.position = CGPointMake(self.position.x, self.position.y - self.frame.size.height/2 + 5);
           tracks.alpha = 0.3;
           tracks.zRotation=self.zRotation;
           
        scene = (MyScene *)self.parent;
        BOOL gameOver = [scene getIsGameOver];
        if (!gameOver) {
            [self.parent insertChild:tracks atIndex:[self.parent.children count]-1];
        }
        [tracks runAction:[SKAction sequence:@[[SKAction moveToY:-screenHeight/4 duration:.5],[SKAction fadeAlphaBy:-.1 duration:.1],[SKAction removeFromParent]]]completion:^{
            
                   }];
        
                }];
    
    SKAction *wait = [SKAction waitForDuration:1];
    SKAction *seq = [SKAction sequence:@[addTracks,wait]];
    [self runAction:[SKAction repeatActionForever:seq]];
    */
    
}
-(void)addTrackSpark{
    
    NSString *emitterPath = [[NSBundle mainBundle] pathForResource:@"spark" ofType:@"sks"];
    SKEmitterNode *spark = [NSKeyedUnarchiver unarchiveObjectWithFile:emitterPath];
   
    if (self.position.x < 50){
    spark.position = CGPointMake( -1 * self.frame.size.width/2,0);
    }
    else {
        spark.position = CGPointMake(self.frame.size.width/2,0);
    }
    [self addChild:spark];
    
}

-(void)fallInHole{
   
        self.zPosition =  -0.1;
        top.zPosition = -0.1;
    }
-(void)getOutOfHole{
    self.zPosition = 20;
    top.zPosition = 20;
}
-(NSInteger)getCoinValueForTank:(NSString *)tankname{
    
    if ([tankname isEqualToString:@"tank1"]){
        coinValue = 250;
    }
    else  if ([tankname isEqualToString:@"tank2"]){
        coinValue = 250;
    }
    else  if ([tankname isEqualToString:@"tank3"]){
        coinValue = 250;
    }
    else  if ([tankname isEqualToString:@"tank4"]){
        coinValue = 0;
    }
    else  if ([tankname isEqualToString:@"tank5"]){
        coinValue = 0;
    }
    
    return coinValue;
}
-(SKAction *)changeMissileColorForTank:(NSString *)tankname{
    SKAction*changeColor = [SKAction colorizeWithColor:[UIColor whiteColor] colorBlendFactor:1.0 duration:0];
    
    
    if ([tankname isEqualToString:@"tank0"]){
         changeColor = [SKAction colorizeWithColor:[UIColor greenColor] colorBlendFactor:1.0 duration:0];
    }
    
    else  if ([tankname isEqualToString:@"tank1"]){
       changeColor = [SKAction colorizeWithColor:[UIColor blueColor] colorBlendFactor:1.0 duration:0];
    }
    else  if ([tankname isEqualToString:@"tank2"]){
         changeColor = [SKAction colorizeWithColor:[UIColor blueColor] colorBlendFactor:1.0 duration:0];
    }
    else  if ([tankname isEqualToString:@"tank3"]){
         changeColor = [SKAction colorizeWithColor:[UIColor redColor] colorBlendFactor:1.0 duration:0];
    }
    else  if ([tankname isEqualToString:@"tank4"]){
         changeColor = [SKAction colorizeWithColor:[UIColor greenColor] colorBlendFactor:1.0 duration:0];
    }
    else  if ([tankname isEqualToString:@"tank5"]){
     changeColor = [SKAction colorizeWithColor:[UIColor yellowColor] colorBlendFactor:1.0 duration:0];
    }
    //NSLog(@" : %@",tankname);
    return changeColor;
    
}
-(void)setCurrenTankIndex:(NSInteger)x{
    currentTankIndex = x;
    [[NSUserDefaults standardUserDefaults ]setInteger:currentTankIndex forKey:@"currentTankIndex"];
}
-(NSInteger)getCurrentTankIndex{
    currentTankIndex = [[NSUserDefaults standardUserDefaults]integerForKey:@"currentTankIndex"];
    return currentTankIndex;
}
-(NSString *)getCurrentTankName{
    
    currentTankIndex = [[NSUserDefaults standardUserDefaults]integerForKey:@"currentTankIndex"];
    NSString *tankName =[NSString stringWithFormat:@"tank%li",(long)currentTankIndex];
    return tankName;
}
@end
