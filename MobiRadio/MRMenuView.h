//
//  MRMenuView.h
//  MobRecorder
//
//  Created by GarY on 2014/8/22.
//  Copyright (c) 2014年 GarY WanG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "gyDelegate.h"



@interface MRMenuView : UIView
{
    id <gyDelegate> delegate;
    bool contentCreated;
}
@property (nonatomic, assign) id<gyDelegate> gydelegate;
@end
