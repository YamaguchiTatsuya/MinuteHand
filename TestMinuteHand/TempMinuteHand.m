//
//  TempMinuteHand.m
//  FamiClock
//
//  Created by 山口 達也 on 11/12/12.
//  Copyright (c) 2011 ringsbell.net. All rights reserved.
//

#import "TempMinuteHand.h"

@implementation TempMinuteHand

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

#pragma mark -

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetRGBStrokeColor(context, 0.5, 0.7, 0.5, 0.5);
	CGContextSetLineWidth(context, 7.0);
	CGContextMoveToPoint(context, 100.f, 0);
	CGContextAddLineToPoint(context, 100.f, 100.f);
	CGContextStrokePath(context);
    
    
    //center point
    float centerX = self.frame.size.width/2.f;
    float centerY = self.frame.size.height/2.f;
	float rCenter = 4.0;
	CGContextSetRGBFillColor(context, 0.0, 0.0, 1.0, 0.5);
	CGContextFillEllipseInRect(context, CGRectMake(centerX-rCenter, centerY-rCenter, rCenter*2, rCenter*2));
    
}
@end
