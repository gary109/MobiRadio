//
//  MRStoreView.h
//  MobiRecorder
//
//  Created by GarY on 2014/10/14.
//  Copyright (c) 2014年 gyhouse. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MRPlist.h"
#import "gyDelegate.h"
#import "MBProgressHUD.h"

@interface MRStoreView : UIView <UIAlertViewDelegate>
{
    bool contentCreated;
    id <gyDelegate> delegate;
}
@property (nonatomic, assign) id<gyDelegate> gydelegate;
- (void) updateAll;
- (void) hidden:(UIView*)view;
- (void) show:(UIView*)view;
@end
