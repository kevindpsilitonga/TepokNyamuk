//
//  MyScene.m
//  Tepok Nyamuk
//
//  Created by Kevin Daniel Pantasdo Silitonga on 6/25/14.
//  Copyright (c) 2014 Kevin. All rights reserved.
//

#import "MyScene.h"
#define kTaskLabel @"tasklab"
#define kMyLabel @"mylab"
#define kScoreLabel @"myscore"
#define kHighScoreLabel @"highscore"

@implementation MyScene
@synthesize colorList,targetColor;


//Initialize random number and score
int randomWord=0;
int randomColor =0;
int score=0;
int highscore=0;
int currentclick=0;


-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        colorList=[NSArray arrayWithObjects:@"Black",@"Dark Gray",@"Light Gray",@"White",@"Gray",
                   @"Red",@"Green",@"Blue",@"Cyan",@"Yellow",
                   @"Magenta",@"Orange",@"Purple",@"Brown",nil];
        
        //Initialize target color
        targetColor=[NSString stringWithFormat:@"%@",colorList[(arc4random()%(12)+1)%(14)]];
        
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"HelveticaNeue-UltraLight"];
        
        myLabel.text = [NSString stringWithFormat:@"Find ''%@''",targetColor];
        myLabel.name=kMyLabel;
        myLabel.fontSize = 30;
        myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetMidY(self.frame));
        //myLabel.fontColor=[UIColor blackColor];
        [self addChild:myLabel];
        
        SKLabelNode *taskLabel =[SKLabelNode labelNodeWithFontNamed:@"HelveticaNeue"];
        
        taskLabel.text=@"Click to Play!";
        taskLabel.name=kTaskLabel;
        taskLabel.fontSize = 30;
        taskLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetMidY(self.frame)-40);
        //taskLabel.fontColor=[SKColor ]
        [self addChild:taskLabel];
        
        
        
        //Timer
        float x=100/(100+score/2);
        [NSTimer scheduledTimerWithTimeInterval:x target:self selector:@selector(changeColorandWord) userInfo:nil repeats:YES];
        
        //  [broTimer invalidate];
        
        //Score Label
        SKLabelNode *scoreLabel =[SKLabelNode labelNodeWithFontNamed:@"HelveticaNeue"];
        
        scoreLabel.text = @"Score: 0";
        scoreLabel.name=kScoreLabel;
        scoreLabel.fontSize = 30;
        scoreLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetMidY(self.frame)-90);
        //myLabel.fontColor=[UIColor blackColor];
        [self addChild:scoreLabel];
        
        SKLabelNode *highscoreLabel =[SKLabelNode labelNodeWithFontNamed:@"HelveticaNeue"];
        
        highscoreLabel.text = @"High Score: 0";
        highscoreLabel.name=kHighScoreLabel;
        highscoreLabel.fontSize = 30;
        highscoreLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                          CGRectGetMidY(self.frame)+30);
        //myLabel.fontColor=[UIColor blackColor];
        [self addChild:highscoreLabel];

    }
    return self;
}
-(void)changeColorandWord{
    SKLabelNode* taskLab=(SKLabelNode*)[self childNodeWithName:kTaskLabel];

    //Generate random word that will never be the same with the previous word
    [self generateRandomColorandWord];
    
    
    //Change randomWord
    //randomWord++;
    taskLab.text=[NSString stringWithFormat:@"%@",colorList[randomWord]];
    
    randomColor=(randomColor+ arc4random()%(12)+1)%(14);
    //NSString *nowColor=[NSString stringWithFormat:@"%@",colorList[randomColor]];
    switch (randomColor) {
        case 0:
            taskLab.fontColor=[SKColor blackColor];
            break;
        case 1:
            taskLab.fontColor=[SKColor darkGrayColor];
            break;
        case 2:
            taskLab.fontColor=[SKColor lightGrayColor];
            break;
        case 3:
            taskLab.fontColor=[SKColor whiteColor];
            break;
        case 4:
            taskLab.fontColor=[SKColor grayColor];
            break;
        case 5:
            taskLab.fontColor=[SKColor redColor];
            break;
        case 6:
            taskLab.fontColor=[SKColor greenColor];
            break;
        case 7:
            taskLab.fontColor=[SKColor blueColor];
            break;
        case 8:
            taskLab.fontColor=[SKColor cyanColor];
            break;
        case 9:
            taskLab.fontColor=[SKColor yellowColor];
            break;
        case 10:
            taskLab.fontColor=[SKColor magentaColor];
            break;
        case 11:
            taskLab.fontColor=[SKColor orangeColor];
            break;
        case 12:
            taskLab.fontColor=[SKColor purpleColor];
            break;
        default:
            taskLab.fontColor=[SKColor brownColor];
            break;
    }
    
    
}
-(void)generateRandomColorandWord{
    
    //Generate random count and color that will never be the same with the previous count and color
    
    if([colorList[randomColor] isEqualToString:targetColor]){
        if(self.currentclick==0){
            [self adjustScoreBy:131313];
        }
    }
    
    self.currentclick=0;
    randomWord=(randomWord+ arc4random()%(12)+1)%(14);
    
    randomColor=(randomColor+ arc4random()%(12)+1)%(14);
    
}
-(void)adjustScoreBy:(int)points {
    if(points==131313){
        self.score=0;
    }else{
        self.score += points;
    }
    if(self.highscore<self.score){
        self.highscore=self.score;
    }
    SKLabelNode* thescore = (SKLabelNode*)[self childNodeWithName:kScoreLabel];
    
    thescore.text = [NSString stringWithFormat:@"Score: %i", self.score];
    
    SKLabelNode* thehighscore =(SKLabelNode*)[self childNodeWithName:kHighScoreLabel];
    
    thehighscore.text = [NSString stringWithFormat:@"High Score: %i", self.highscore];
    

}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    /* Called when a touch begins */
    
    if([colorList[randomColor] isEqualToString:targetColor]){
        [self adjustScoreBy:100];
        self.currentclick++;
    }else{
        [self adjustScoreBy:131313];
    }
    
    //if ([self generateRandomColorandWord]==targetColor) {
    
    //}
    /*for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
        
        sprite.position = location;
        
        SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
        
        [sprite runAction:[SKAction repeatActionForever:action]];
        
        [self addChild:sprite];
    }*/
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
