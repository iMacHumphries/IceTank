//
//  SKInstructions.m
//  ScrappyTank
//
//  Created by Benjamin Humphries on 4/18/14.
//  Copyright (c) 2014 Benjamin Humphries. All rights reserved.
//

#import "SKInstructions.h"
#import "MyScene.h"

@implementation SKInstructions{
    MyScene *scene;
}

-(id)initWithImageNamed:(NSString *)name{
    
    self = [super initWithImageNamed:name];
    
    self.name = @"howTo";
    self.hidden = true;
    
    return self;
}
-(void)update:(CFTimeInterval)currentTime {
    
}
-(void)showInstructions{
    self.hidden = false;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        SKNode *node=[self nodeAtPoint:location];
        scene = (MyScene *)self.parent;
        if ([node.name isEqualToString:@"howTo"]){
            
            [node removeFromParent];
            [scene setIsShowingInstruct:false];
            [scene togglePause];
            [scene startGameAgain];
        }

        
    }
}
@end
