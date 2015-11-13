//
//  MRMenuView.m
//  MobRecorder
//
//  Created by GarY on 2014/8/22.
//  Copyright (c) 2014年 GarY WanG. All rights reserved.
//

#import "MRMenuView.h"
#import "MRPlist.h"

@interface MRMenuView ()
@property bool isHiddenDashboard;
@end

@implementation MRMenuView
@synthesize isHiddenDashboard;

float test_angle;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        
        if(!contentCreated)
        {
            isHiddenDashboard = NO;
            
            // 將圖層的邊框設置為圓腳
            self.layer.cornerRadius = 5;
            self.layer.masksToBounds = YES;
            
            // 給圖層添加一個有色邊框
            self.layer.borderWidth = 2;
            self.layer.borderColor = [[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:0.5] CGColor];
            
            contentCreated = YES;
            
            UIImageView * backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BG"]];
            backgroundImageView.frame =  [[self layer] bounds];
            backgroundImageView.alpha = 0.8;
            
            [self addSubview:backgroundImageView];
            
            [self createStoreBtn];
            [self createMonitorBtn];
            [self createFolderBtn];
            [self createSettingBtn];
            [self createRadioBtn];
            
            
//            [NSTimer scheduledTimerWithTimeInterval:0.05
//                                                           target:self
//                                                         selector:@selector(updateView:)
//                                                         userInfo:nil
//                                                          repeats:YES];
//            
//            //[updateTimer invalidate];
//            //[updateTimer fire];
        }
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
//-(void) updateView:(NSTimer *)theTimer
//{
//    //NSLog(@"Menu updateView..");
//    
//    btnSetting.transform = CGAffineTransformMakeRotation(degreesToRadians(test_angle));
//    test_angle+=3;
//}


#pragma mark - 螢幕觸控
//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    //    //UITouch *touch = [touches anyObject];
//    //    //    CGPoint location = [touch locationInNode:self];
//    //    //SKNode *node = [self nodeAtPoint:location];
//    //    if(BrightnessSwitch == NO)
//    //    {
//    //        BrightnessSwitch = YES;
//    //        currentStartData = [NSDate date];
//    //        //[[UIScreen mainScreen] setBrightness:[[MRPlist readPlist:@"Setting" forkey:@"BrightnessSys"] floatValue]];
//    //        [[UIScreen mainScreen] setBrightness:1.0f];
//    //        [MRPlist writePlist:@"Setting" forkey:@"BrightnessMob" content:[[NSString alloc] initWithFormat:@"%f",
//    //                                                                        [[UIScreen mainScreen] brightness]]];
//    //    }
//    //    else
//    //    {
//    //        currentStartData = [NSDate date];
//    //        [self.gydelegate hiddenScene];
//    //    }
//    //
//    //
//    //    //    for (UITouch *touch in touches)
//    //    //    {
//    //    //        CGPoint location = [touch locationInNode:self];
//    //    //    }
//    
//    NSLog(@"Touches Began - MRCameraview");
//    //[super touchesEnded: touches withEvent: event];
//}
//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    NSLog(@"Touches Moved - MRCameraview");
//    //[self logTouches: event];
//    
//    //[super touchesEnded: touches withEvent: event];
//}
//
//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    NSLog(@"Touches Ended - MRCameraview");
//    //[self logTouches: event];
//    
//    //[super touchesEnded: touches withEvent: event];
//}

#pragma mark - 按鍵宣告
- (void) handleBtnClicked:(id)sender {
    if(_TAG_MENU_DASHBOARD_BTN_ == ((UIButton *)sender).tag)
    {
        NSLog(@"handleDashboardBtnClicked...");
      
        if(isHiddenDashboard){
            [((UIButton *)sender) setImage:[UIImage imageNamed:@"dashboard-off"] forState:UIControlStateNormal];
            
            isHiddenDashboard = NO;
        }
        else{
            [((UIButton *)sender) setImage:[UIImage imageNamed:@"dashboard-on"] forState:UIControlStateNormal];
            
            isHiddenDashboard = YES;
        }
    }
    else if(_TAG_MENU_MONITOR_BTN_ == ((UIButton *)sender).tag)
    {
        NSLog(@"handleMapBtnClicked...");
        
        NSString * mainScreen = [NSString stringWithFormat:@"%@",[MRPlist readPlist:@"Setting" forkey:@"MainScreen"]];
        
        if([mainScreen isEqualToString:@"Map"])
        {
            [MRPlist writePlist:@"Setting"
                         forkey:@"MainScreen"
                        content:[NSString stringWithFormat:@"%@", @"Hybrid"]];
        }
        else if([mainScreen isEqualToString:@"Hybrid"])
        {
            [MRPlist writePlist:@"Setting"
                         forkey:@"MainScreen"
                        content:[NSString stringWithFormat:@"%@", @"Video"]];
        }
        else
        {
            [MRPlist writePlist:@"Setting"
                         forkey:@"MainScreen"
                        content:[NSString stringWithFormat:@"%@", @"Map"]];
        }
        
        [self.gydelegate exchangeView:YES];
        
        // Lauch Apple Map
        //     // Check for iOS 6
        //     Class mapItemClass = [MKMapItem class];
        //     if (mapItemClass && [mapItemClass respondsToSelector:@selector(openMapsWithItems:launchOptions:)])
        //     {
        //     // Create an MKMapItem to pass to the Maps app
        //     CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([self.gydelegate GetLatitude] , [self.gydelegate GetLongitude]);
        //     MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:coordinate addressDictionary:nil];
        //     MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
        //     [mapItem setName:@"My Place"];
        //     // Pass the map item to the Maps app
        //     [mapItem openInMapsWithLaunchOptions:nil];
        //     }
        
        
        //*/
        
        // 打個電話
        //        NSURL *url = [NSURL URLWithString:@"telprompt://123-4567-890"];
        //        [[UIApplication  sharedApplication] openURL:url];
        
    }
    else if(_TAG_MENU_FOLDER_BTN_ == ((UIButton *)sender).tag)
    {
        NSLog(@"handleFolderBtnClicked...");
    }
    else if(_TAG_MENU_SETTING_BTN_ == ((UIButton *)sender).tag)
    {
        NSLog(@"handleSettingBtnClicked...");
        //[NSThread sleepForTimeInterval:0.3];
        [self.gydelegate showSettingView];
    }
    else if(_TAG_MENU_STORE_BTN_ == ((UIButton *)sender).tag)
    {
        NSLog(@"handleStoreBtnClicked...");
        //[MRPlist writePlist:@"Setting" forkey:@"WeAreRecording" content:[NSString stringWithFormat:@"%d",0]];
        [self.gydelegate showStoreView];
    }
    else if(_TAG_MENU_RADIO_BTN_ == ((UIButton *)sender).tag)
    {
        
    }
}

- (void)createMonitorBtn
{
    UIButton * btnMonitor = [[UIButton alloc] initWithFrame: CGRectMake(_Menu_Icon_W_*1,
                                                                        [[self layer] bounds].size.height/2-_Menu_Icon_H_/2,
                                                                        _Menu_Icon_W_,
                                                                        _Menu_Icon_H_)];
    [btnMonitor setImage:[UIImage imageNamed:@"yellow-monitor-icon"] forState:UIControlStateNormal];
    [btnMonitor addTarget:self action:@selector(handleBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btnMonitor setTag:_TAG_MENU_MONITOR_BTN_];
    [self addSubview:btnMonitor];
}

- (void)createFolderBtn {
    UIButton * btnFolder = [[UIButton alloc] initWithFrame: CGRectMake(_Menu_Icon_W_*2,
                                                                       [[self layer] bounds].size.height/2-_Menu_Icon_H_/2,
                                                                       _Menu_Icon_W_,
                                                                       _Menu_Icon_H_)];
    //btnFolder.transform = CGAffineTransformMakeRotation(degreesToRadians(45));
    [btnFolder setImage:[UIImage imageNamed:@"Folder-Camera-icon"] forState:UIControlStateNormal];
    [btnFolder setTag:_TAG_MENU_FOLDER_BTN_];
    [btnFolder addTarget:self action:@selector(handleBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnFolder];
}

- (void)createSettingBtn {
    UIButton * btnSetting = [[UIButton alloc] initWithFrame: CGRectMake(_Menu_Icon_W_*4,
                                                                        [[self layer] bounds].size.height/2-_Menu_Icon_H_/2,
                                                                        _Menu_Icon_W_,
                                                                        _Menu_Icon_H_)];
    btnSetting.transform = CGAffineTransformMakeRotation(degreesToRadians(0));
    [btnSetting setImage:[UIImage imageNamed:@"settings-icon"] forState:UIControlStateNormal];
    [btnSetting setTag:_TAG_MENU_SETTING_BTN_];
    [btnSetting addTarget:self action:@selector(handleBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnSetting];
}

- (void)createStoreBtn {
    UIButton * btnStore = [[UIButton alloc] initWithFrame: CGRectMake(_Menu_Icon_W_*3,
                                                                      [[self layer] bounds].size.height/2-_Menu_Icon_H_/2,
                                                                      _Menu_Icon_W_,
                                                                      _Menu_Icon_H_)];
    [btnStore setImage:[UIImage imageNamed:@"Store"] forState:UIControlStateNormal];
    [btnStore setTag:_TAG_MENU_STORE_BTN_];
    [btnStore addTarget:self action:@selector(handleBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnStore];
}
- (void)createRadioBtn {
    UIButton * btnRadio = [[UIButton alloc] initWithFrame: CGRectMake(_Menu_Icon_W_*0,
                                                                      [[self layer] bounds].size.height/2-_Menu_Icon_H_/2,
                                                                      _Menu_Icon_W_,
                                                                      _Menu_Icon_H_)];
    [btnRadio setImage:[UIImage imageNamed:@"Radio-icon"] forState:UIControlStateNormal];
    [btnRadio setTag:_TAG_MENU_RADIO_BTN_];
    [btnRadio addTarget:self action:@selector(handleBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnRadio];
}



-(void) updateAll{
    
}

//- (void) hidden:(UIView*)view
//{
//    [self updateAll];
//    [UIView transitionWithView:view
//                      duration:0.5
//                       options:UIViewAnimationOptionTransitionFlipFromLeft
//                    animations:^{[self removeFromSuperview];}
//                    completion:NULL];
//}
//- (void) show:(UIView*)view
//{
//    [self updateAll];
//    [UIView transitionWithView:view
//                      duration:0.5
//                       options:UIViewAnimationOptionTransitionCurlDown
//                    animations:^{[view addSubview:self];}
//                    completion:NULL];
//}

@end
