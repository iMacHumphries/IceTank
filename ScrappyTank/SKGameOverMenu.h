//
//  SKGameOverMenu.h
//  ScrappyTank
//
//  Created by Benjamin Humphries on 4/10/14.
//  Copyright (c) 2014 Benjamin Humphries. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
    
@interface SKGameOverMenu : SKSpriteNode{
    CGFloat screenWidth;
    CGFloat screenHeight;
    SKLabelNode *highScoreLabel;

    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)setHighScoreText;

@end
