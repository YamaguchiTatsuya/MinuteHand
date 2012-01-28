//
//  RateEaseInOut.h
//  TestMinuteHand
//
//  Created by 山口 達也 on 12/01/12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//



#import <Foundation/Foundation.h>

@interface RateEaseInOut : NSObject {
    float _intervalSecond;
    float totalSecond;
    NSInteger totalStep;
    
    BOOL isExistFlat;
    float sttRad,endRad , dRad;
    float time1,time2;
}
@property(nonatomic,assign) float intervalSecond;


-(void)setSttRad:(float)_sttRad endRad:(float)_endRad;
-(float)getRadForStep:(NSInteger)step;
-(BOOL)isEndForStep:(NSInteger)step;


@end
