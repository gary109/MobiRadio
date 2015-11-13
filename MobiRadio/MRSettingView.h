//
//  MRSettingView.h
//  MobRecorder
//
//  Created by GarY on 2014/8/24.
//  Copyright (c) 2014年 GarY WanG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "gyDelegate.h"
#import "ALDisk.h"
#import "MRPlist.h"
#import "GADBannerView.h"

@interface MRSettingView : UIView
{
    id <gyDelegate> delegate;
    bool contentCreated;

}


@property (nonatomic, assign) id<gyDelegate> gydelegate;

- (void) updateSettingViewFrame;
- (void) updateAll;
- (void) hidden:(UIView*)view;
- (void) show:(UIView*)view;

@end
