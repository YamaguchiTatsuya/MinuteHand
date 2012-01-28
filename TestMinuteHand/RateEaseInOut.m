//
//  RateEaseInOut.m
//  TestMinuteHand
//
//  Created by 山口 達也 on 12/01/12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RateEaseInOut.h"

#define SLOPE_DURATION 0.5f //time for acceleration [sec]
#define MAX_OMEGA 2.50f //max angular velocity [rad/s] 
#define INTERVAL 0.05f //time interval for NSTimer [sec]

@implementation RateEaseInOut

@synthesize intervalSecond = _intervalSecond;


- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code
        self.intervalSecond = INTERVAL;
    }
    return self;
}



- (void)dealloc
{
    [super dealloc];
}

#pragma mark -
-(void)setSttRad:(float)_sttRad endRad:(float)_endRad
{
    //Setting for start
    
    sttRad = _sttRad;
    endRad = _endRad;
    dRad = endRad - sttRad;
    
    if (dRad < SLOPE_DURATION * MAX_OMEGA) {
        isExistFlat = NO;
        time1 = sqrtf(dRad/(MAX_OMEGA/SLOPE_DURATION));//この場合は全体の半分の時間（角速度が最大になる時間）
        totalSecond = time1*2.0f;
        totalStep = totalSecond/INTERVAL;
        
    } else {
        isExistFlat = YES;
        time1 = SLOPE_DURATION;
        time2 = dRad/MAX_OMEGA;
        totalSecond = dRad/MAX_OMEGA+SLOPE_DURATION;//トータルかかる時間
        totalStep = totalSecond/INTERVAL;
    }
    
    

}


-(float)getRadForStep:(NSInteger)step
{
    //★高速化できそう
    float rad;
    float currentTime = step*INTERVAL;
    float omg;
    if (isExistFlat) {
        //flatなところがある場合
        if (currentTime < time1) {//加速時
            omg = MAX_OMEGA/SLOPE_DURATION*currentTime; //現在の角速度[rad/sec]
            rad = sttRad + omg*currentTime/2.f;
            
        } else if (currentTime < time2) {//定速度時
            omg = MAX_OMEGA;
            rad = sttRad + MAX_OMEGA*SLOPE_DURATION/2.f + (currentTime - time1)*MAX_OMEGA;
            
        } else {//減速時
            omg = MAX_OMEGA-(currentTime-time2)*MAX_OMEGA/SLOPE_DURATION;

            rad = sttRad + MAX_OMEGA*SLOPE_DURATION/2.f + MAX_OMEGA*(time2-time1) + (currentTime - time2)*(omg+(MAX_OMEGA-omg)/2.f);

        }
        
    } else {
        //flatなところがない場合
        if (currentTime < time1) {//加速時
            omg = MAX_OMEGA/SLOPE_DURATION*currentTime; //現在の角速度[rad/sec]
            rad = sttRad + omg*currentTime/2.f;
        } else {//減速時
            omg = MAX_OMEGA/SLOPE_DURATION*(time1 - (currentTime-time1));
            rad = sttRad + dRad - (totalSecond-currentTime)*omg/2.f;
        }
    }
    
    //NSLog(@"%f",omg);
    
    return rad;
}

-(BOOL)isEndForStep:(NSInteger)step
{
    BOOL isEnd = NO;
    if (step == totalStep) isEnd = YES;
    
    return isEnd;
}

@end
