//
//  LBScreenLockView.h
//  LightingBomb
//
//  Created by GarY on 2014/10/18.
//  Copyright (c) 2014年 gyhouse. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "gyDelegate.h"
#import "MBSliderView.h"
#import "ViewController.h"


@interface LBScreenLockView : UIView <MBSliderViewDelegate>
{
    id <gyDelegate> delegate;
    bool contentCreated;
}
@property (nonatomic, assign) id<gyDelegate> gydelegate;

- (void) updateAll;
- (void) hidden:(UIView*)view;
- (void) show:(UIView*)view;

- (BOOL) isScreenLock;
- (void) setScreenLock:(BOOL)sw;


@end
