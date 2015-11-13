//
//  ViewController.h
//  MobiRadio
//
//  Created by GarY on 2014/10/28.
//  Copyright (c) 2014年 gyhouse. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "gyDelegate.h"
#import "MRPlist.h"

#import "MRMenuView.h"

#import "MRSettingView.h"
#import "MRTableView.h"

#import "GADBannerView.h"
#import "MRStoreView.h"
#import "MBProgressHUD.h"
#import "LBScreenLockView.h"


#include "libavformat/avformat.h"
#include "libswscale/swscale.h"
#import "AudioPacketQueue.h"
#import "AudioPlayer.h"
#import "AudioUtilities.h"

#import "MRJSON.h"

@interface ViewController : UIViewController  <gyDelegate>
{
    // 將其中一個宣告為執行個體變數
    GADBannerView *bannerView_;
    
    NSString *channelAddr;
}

@property (strong,nonatomic) GADBannerView *bannerView_;


- (float) getVolumeLevel;

@end

