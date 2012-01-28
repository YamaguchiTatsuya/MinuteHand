//
//  MyViewController.h
//  TestMinuteHand
//
//  Created by 山口 達也 on 12/01/12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TempMinuteHand.h"
#import "RateEaseInOut.h"

@interface MyViewController : UIViewController {
    TempMinuteHand *minuteHand;
    float sttRad,endRad;
    
    NSInteger step;
    RateEaseInOut *rateController;
}

@end
