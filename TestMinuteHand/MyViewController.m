//
//  MyViewController.m
//  TestMinuteHand
//
//  Created by 山口 達也 on 12/01/12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MyViewController.h"

@interface MyViewController ()

@end

//float rateEaseInOut(float targetSecond,float totalSecond);

@implementation MyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        rateController = [[RateEaseInOut alloc] init];
    }
    return self;
}

- (void)dealloc
{
    [rateController release];
    
    [super dealloc];
}

#pragma mark -

- (void)loadView
{
    [super loadView];
    
    float centerX = self.view.frame.size.width/2.f;
    float centerY = self.view.frame.size.height/2.f;
    
    minuteHand = [[TempMinuteHand alloc] initWithFrame:CGRectMake(centerX-100, centerY-100, 200, 200)];
    [self.view addSubview:minuteHand];
    [minuteHand release];

    
    //NSLog(@"rate = %f",rateEaseInOut(0.1, 1.f));
    
    //float totalSecond = 1.f;//[sec]
    //float intervalSec = 0.05f;//[sec]
    //int totalStep = totalSecond/intervalSec;
        
    
    UIButton *button = [UIButton buttonWithType:100];
    [self.view addSubview:button];
    [button setTitle:@"Start" forState:UIControlStateNormal];
    [button setFrame:CGRectMake(160-70, 50, 140, 30) ];
    [button addTarget:self action:@selector(buttonTappedHandler) forControlEvents:UIControlEventTouchUpInside];
    

    sttRad = 0.f;
    
    
    //Start Rotating
    }

-(void)buttonTappedHandler
{
    endRad = sttRad + M_PI/180.f*360.f;
    
    minuteHand.transform = CGAffineTransformMakeRotation(sttRad);//初期設定

    
    step = 0;
    [rateController setSttRad:sttRad endRad:endRad];
    
    [NSTimer scheduledTimerWithTimeInterval:(rateController.intervalSecond) target:self selector:@selector(onTimerAdvanceMinute:) userInfo:nil repeats:YES];

}

- (void)onTimerAdvanceMinute:(NSTimer*)_timer 
{
    step++;
    float rad = [rateController getRadForStep:step];
    minuteHand.transform = CGAffineTransformMakeRotation(rad);
    
    
    //NSLog(@"%f",rad);
    
    //終了判定
    if ([rateController isEndForStep:step]) { 
        [_timer invalidate];
        sttRad = endRad;
    }
}



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
/*
#pragma mark -
#pragma mark 関数
float rateEaseInOut(float targetSecond,float totalSecond)
{
    float rate = 1.f;
    
    return rate;
}*/
