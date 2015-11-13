//
//  MRSettingView.m
//  MobRecorder
//
//  Created by GarY on 2014/8/24.
//  Copyright (c) 2014年 GarY WanG. All rights reserved.
//

#import "MRSettingView.h"

@interface MRSettingView ()
{
    
}
@end

@implementation MRSettingView

- (void) handleBtnClicked:(id)sender
{
    if(_TAG_SETTING_BACK_BTN_ == ((UIButton *)sender).tag) {
        [self.gydelegate hiddenSettingView];
    }else if(_TAG_SETTING_ABOUT_BTN_ == ((UIButton *)sender).tag) {
        [self.gydelegate showAboutView];
    }
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        if(!contentCreated)
        {
            contentCreated = YES;
            int separator_X         = 25;
            int separator_W         = [[self layer] bounds].size.width - separator_X*2;
            int separator_H         = 2;
            int contentStart_Y      = 10;
            int titleView_H         = 60;
            int contentInterval_H   = 30;
            int contentStart_X      = (self.frame.size.width/2)-60;
            int contentLabelStart_X = 25;

            contentCreated = YES;
            //---------------------------------------------------------------------------
            // Background View
            //---------------------------------------------------------------------------
            UIImageView * backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BG"]];
            CGRect backgroundFrame = [[self layer] bounds];
            backgroundImageView.frame = backgroundFrame;
            backgroundImageView.alpha = 1.0;
            [self addSubview:backgroundImageView];
            
            //---------------------------------------------------------------------------
            // titleView View
            //---------------------------------------------------------------------------
            UIView* titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, titleView_H)];
            titleView.backgroundColor=[UIColor clearColor];
            titleView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight;
            
            // 給圖層添加一個有色邊框
//            titleView.layer.borderWidth = 2;
//            titleView.layer.borderColor = [[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0] CGColor];
            
            [titleView setTag:_TAG_SETTING_TITLE_VIEW_];
            [self addSubview:titleView];
            //////////////
            // 我是分隔線 //
            //////////////
            UIImageView * SeparatorImageView0 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Separator"]];
            SeparatorImageView0.frame = CGRectMake(0,
                                                   titleView.frame.size.height-separator_H,
                                                   [[self layer] bounds].size.width,
                                                   separator_H);
            [titleView addSubview:SeparatorImageView0];
            //---------------------------------------------------------------------------
            // Title Icon
            //---------------------------------------------------------------------------
            UIImageView * titleIconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"settings-icon"]];
            CGRect titleIconFrame = CGRectMake(CGRectGetMidX(self.frame)-titleView_H/2,
                                               0,
                                               titleView_H,
                                               titleView_H);
            titleIconImageView.frame = titleIconFrame;
            titleIconImageView.alpha = 1.0;
            [titleView addSubview:titleIconImageView];
            //---------------------------------------------------------------------------
            // About 按鍵布局
            //---------------------------------------------------------------------------
//            UIButton * btnAbout = [[UIButton alloc] initWithFrame: CGRectMake(titleView.frame.size.width-titleView_H,
//                                                                   0,
//                                                                   titleView_H,
//                                                                   titleView_H)];
//            [btnAbout setTag:_TAG_SETTING_ABOUT_BTN_];
//            
//            [btnAbout setImage:[UIImage imageNamed:@"About"] forState:UIControlStateNormal];
//            
//            // 設定按鍵的觸發動作
//            [btnAbout addTarget:self action:@selector(handleBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//            [titleView addSubview:btnAbout];
            //---------------------------------------------------------------------------
            // Back 按鍵布局
            //---------------------------------------------------------------------------
            UIButton * btnBack = [[UIButton alloc] initWithFrame: CGRectMake(0,
                                                                  0,
                                                                  titleView_H,
                                                                  titleView_H)];
            
            [btnBack setTag:_TAG_SETTING_BACK_BTN_];
            [btnBack setImage:[UIImage imageNamed:@"back-icon1"] forState:UIControlStateNormal];
            
            // 設定按鍵的觸發動作
            [btnBack addTarget:self action:@selector(handleBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [titleView addSubview:btnBack];
            
            //---------------------------------------------------------------------------
            // scrollView
            //---------------------------------------------------------------------------
            UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,
                                                                                       titleView_H,
                                                                                       self.frame.size.width,
                                                                                       self.frame.size.height-titleView_H)];
            
            
            scrollView.backgroundColor = [UIColor clearColor];
            [scrollView setTag:_TAG_SETTING_SCROLL_VIEW_];
            [self addSubview:scrollView];
            
            //---------------------------------------------------------------------------
            // contentView
            //---------------------------------------------------------------------------
            UIView * contentView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                            0,
                                                                            scrollView.frame.size.width,
                                                                            scrollView.frame.size.height)];
          
            [contentView setTag:_TAG_SETTING_CONTENT_VIEW_];
            contentView.backgroundColor = [UIColor clearColor];
            
            
            //---------------------------------------------------------------------------
            // UISwitch - ECO
            //---------------------------------------------------------------------------
//            UISwitch * ecoSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(contentStart_X, contentStart_Y, 50, 50)];
//            [ecoSwitch setOn:[[MRPlist readPlist:@"Setting" forkey:@"ECO"] boolValue]];
//            [ecoSwitch addTarget:self action:@selector(switchOnOff:) forControlEvents:UIControlEventValueChanged];
//            [contentView addSubview:ecoSwitch];
//            
//            UILabel * ecoLabel=[[UILabel alloc] initWithFrame:CGRectMake(contentLabelStart_X, contentStart_Y, 200, 50)];
//            ecoLabel.textColor=[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
//            [ecoLabel setFont:[UIFont fontWithName:@"Arial" size:30]];
//            ecoLabel.text=@"ECO";
//            ecoLabel.backgroundColor=[UIColor clearColor];
//            [contentView  addSubview:ecoLabel];
//            
//            contentStart_Y += ecoSwitch.frame.size.height+contentInterval_H;
            
            //---------------------------------------------------------------------------
            // UISegmentedControl - main screen
            //---------------------------------------------------------------------------
            //建立陣列並設定其內容來當作選項
            NSArray *mainScreenItemArray =[NSArray arrayWithObjects:@"Video", @"Map", @"Hybrid",@"ECO", nil];
            
            //使用陣列來建立UISegmentedControl
            UISegmentedControl * mainScreenSegmentedControl = [[UISegmentedControl alloc] initWithItems:mainScreenItemArray];
            
            [mainScreenSegmentedControl setTag:_TAG_SETTING_MAIN_SCREEN_SEGCTRL_];

            // 將圖層的邊框設置為圓腳
            mainScreenSegmentedControl.layer.cornerRadius = 5;
            mainScreenSegmentedControl.layer.masksToBounds = YES;
            
            //設定外觀大小與初始選項
            [mainScreenSegmentedControl setTintColor:[UIColor whiteColor]];
            
            mainScreenSegmentedControl.frame = CGRectMake(contentStart_X, contentStart_Y, 300, 50);
            
            
            
            //設定所觸發的事件條件與對應事件
            [mainScreenSegmentedControl addTarget:self action:@selector(chooseOne:) forControlEvents:UIControlEventValueChanged];
            
            //加入畫面中並釋放記憶體
            [contentView addSubview:mainScreenSegmentedControl];
            
            
            UILabel * mainScreenLabel=[[UILabel alloc] initWithFrame:CGRectMake(contentLabelStart_X, contentStart_Y, 200, 50)];
            mainScreenLabel.textColor=[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
            [mainScreenLabel setFont:[UIFont fontWithName:@"Arial" size:25]];
            mainScreenLabel.text=@"Main Screen";
            mainScreenLabel.backgroundColor=[UIColor clearColor];
            [contentView  addSubview:mainScreenLabel];
            
            contentStart_Y += mainScreenSegmentedControl.frame.size.height+contentInterval_H;
            
            //////////////
            // 我是分隔線 //
            //////////////
            UIImageView * SeparatorImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Separator"]];
            SeparatorImageView.frame = CGRectMake(separator_X,
                                                   contentStart_Y-contentInterval_H/2,
                                                   separator_W,
                                                   separator_H);
            [contentView addSubview:SeparatorImageView];
            
            //---------------------------------------------------------------------------
            // UISegmentedControl - Storage
            //---------------------------------------------------------------------------
            //建立陣列並設定其內容來當作選項
            NSArray *storageItemArray =[NSArray arrayWithObjects:@"1G", @"2G", @"3G",@"4G",@"6G",@"8G", nil];
            
            //使用陣列來建立UISegmentedControl
            UISegmentedControl * storageSegmentedControl = [[UISegmentedControl alloc] initWithItems:storageItemArray];
            [storageSegmentedControl setTag:_TAG_SETTING_STORAGE_SEGCTRL_];
            
            // 將圖層的邊框設置為圓腳
            storageSegmentedControl.layer.cornerRadius = 5;
            storageSegmentedControl.layer.masksToBounds = YES;
            
            //設定外觀大小與初始選項
            [storageSegmentedControl setTintColor:[UIColor whiteColor]];
            
            storageSegmentedControl.frame = CGRectMake(contentStart_X, contentStart_Y, 300, 50);
            
            
            [storageSegmentedControl addTarget:self action:@selector(chooseOne:) forControlEvents:UIControlEventValueChanged];
            [contentView addSubview:storageSegmentedControl];
            
            UILabel * storageSizeLabel=[[UILabel alloc] initWithFrame:CGRectMake(contentLabelStart_X, contentStart_Y, 200, 50)];
            storageSizeLabel.textColor=[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
            [storageSizeLabel setFont:[UIFont fontWithName:@"Arial" size:25]];
            storageSizeLabel.text=@"Storage";
            storageSizeLabel.backgroundColor=[UIColor clearColor];
            [contentView  addSubview:storageSizeLabel];
            
            contentStart_Y += storageSegmentedControl.frame.size.height+contentInterval_H;
            
            //////////////
            // 我是分隔線 //
            //////////////
            UIImageView * SeparatorImageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Separator"]];
            SeparatorImageView1.frame = CGRectMake(separator_X,
                                                  contentStart_Y-contentInterval_H/2,
                                                  separator_W,
                                                  separator_H);
            [contentView addSubview:SeparatorImageView1];
            
            
            CGRect storageInfoLabelFrame = storageSegmentedControl.frame;
            storageInfoLabelFrame.origin.x = CGRectGetMinX(storageInfoLabelFrame);
            storageInfoLabelFrame.origin.y = CGRectGetMaxY(storageInfoLabelFrame);
            storageInfoLabelFrame.size.height = 20;
            storageInfoLabelFrame.size.width = storageSegmentedControl.frame.size.width;
            
            UILabel * storageInfoLabel = [[UILabel alloc] initWithFrame:storageInfoLabelFrame];
            [storageInfoLabel setTag:_TAG_SETTING_STORAGE_INFO_LABEL_];
            
            storageInfoLabel.textColor=[UIColor colorWithRed:1.0 green:1.0 blue:0.0 alpha:1.0];
            [storageInfoLabel setFont:[UIFont fontWithName:@"Arial" size:10]];
            
            storageInfoLabel.backgroundColor=[UIColor clearColor];
            [contentView addSubview:storageInfoLabel];
       
            
            //---------------------------------------------------------------------------
            // UISegmentedControl - Video Quality
            //---------------------------------------------------------------------------
            NSArray *videoQualityItemArray =[NSArray arrayWithObjects:@"High", @"Normal", @"Low", nil];
            
            //使用陣列來建立UISegmentedControl
            UISegmentedControl * videoQualitySegmentedControl = [[UISegmentedControl alloc] initWithItems:videoQualityItemArray];
            [videoQualitySegmentedControl setTag:_TAG_SETTING_VIDEO_QUALITY_SEGCTRL_];
            
            // 將圖層的邊框設置為圓腳
            videoQualitySegmentedControl.layer.cornerRadius = 5;
            videoQualitySegmentedControl.layer.masksToBounds = YES;
            
            //設定外觀大小與初始選項
            [videoQualitySegmentedControl setTintColor:[UIColor whiteColor]];
            
            videoQualitySegmentedControl.frame = CGRectMake(contentStart_X, contentStart_Y, 300, 50);
            
            
            
            
            
            //設定所觸發的事件條件與對應事件
            [videoQualitySegmentedControl addTarget:self action:@selector(chooseOne:) forControlEvents:UIControlEventValueChanged];
            
            //加入畫面中並釋放記憶體
            [contentView addSubview:videoQualitySegmentedControl];
            
            
            UILabel * videoQualityLabel=[[UILabel alloc] initWithFrame:CGRectMake(contentLabelStart_X, contentStart_Y, 200, 50)];
            videoQualityLabel.textColor=[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
            [videoQualityLabel setFont:[UIFont fontWithName:@"Arial" size:25]];
            videoQualityLabel.text=@"Video Quality";
            videoQualityLabel.backgroundColor=[UIColor clearColor];
            [contentView  addSubview:videoQualityLabel];
            
            contentStart_Y += videoQualitySegmentedControl.frame.size.height+contentInterval_H;
            
            //////////////
            // 我是分隔線 //
            //////////////
            UIImageView * SeparatorImageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Separator"]];
            SeparatorImageView2.frame = CGRectMake(separator_X,
                                                  contentStart_Y-contentInterval_H/2,
                                                  separator_W,
                                                  separator_H);
            [contentView addSubview:SeparatorImageView2];
            
            //---------------------------------------------------------------------------
            // UISegmentedControl - Speed Unit
            //---------------------------------------------------------------------------
            NSArray *speedUnitItemArray =[NSArray arrayWithObjects:@"km/h", @"MPH", nil];
            
            //使用陣列來建立UISegmentedControl
            UISegmentedControl * speedUnitSegmentedControl = [[UISegmentedControl alloc] initWithItems:speedUnitItemArray];
            [speedUnitSegmentedControl setTag:_TAG_SETTING_SPEED_UNIT_SEGCTRL_];
            
            // 將圖層的邊框設置為圓腳
            speedUnitSegmentedControl.layer.cornerRadius = 5;
            speedUnitSegmentedControl.layer.masksToBounds = YES;
            
            //設定外觀大小與初始選項
            [speedUnitSegmentedControl setTintColor:[UIColor whiteColor]];
            
            speedUnitSegmentedControl.frame = CGRectMake(contentStart_X, contentStart_Y, 300, 50);
            
            
            
            
            
            //設定所觸發的事件條件與對應事件
            [speedUnitSegmentedControl addTarget:self action:@selector(chooseOne:) forControlEvents:UIControlEventValueChanged];
            
            //加入畫面中並釋放記憶體
            [contentView addSubview:speedUnitSegmentedControl];
            
            
            UILabel * speedUnitLabel=[[UILabel alloc] initWithFrame:CGRectMake(contentLabelStart_X, contentStart_Y, 200, 50)];
            speedUnitLabel.textColor=[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
            [speedUnitLabel setFont:[UIFont fontWithName:@"Arial" size:25]];
            speedUnitLabel.text=@"Unit";
            speedUnitLabel.backgroundColor=[UIColor clearColor];
            [contentView  addSubview:speedUnitLabel];
            
            contentStart_Y += speedUnitSegmentedControl.frame.size.height+contentInterval_H;
            
            //////////////
            // 我是分隔線 //
            //////////////
            UIImageView * SeparatorImageView3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Separator"]];
            SeparatorImageView3.frame = CGRectMake(separator_X,
                                                  contentStart_Y-contentInterval_H/2,
                                                  separator_W,
                                                  separator_H);
            [contentView addSubview:SeparatorImageView3];
            
            ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            [contentView setFrame:CGRectMake(0,
                                             0,
                                             self.frame.size.width,
                                             contentStart_Y)];
        
            scrollView.contentSize = contentView.bounds.size;
            
            [scrollView addSubview:contentView];
            
            [self updateAll];
            
            [self updateSettingViewFrame];
            
            [self setHidden:YES];
            
            NSLog(@"SettingView - frame - Enter");
            NSLog(@"x: %f", self.frame.origin.x);
            NSLog(@"y: %f", self.frame.origin.y);
            NSLog(@"w: %f", self.frame.size.width);
            NSLog(@"h: %f", self.frame.size.height);
            NSLog(@"SettingView - bounds - Enter");
            NSLog(@"x: %f", self.bounds.origin.x);
            NSLog(@"y: %f", self.bounds.origin.y);
            NSLog(@"w: %f", self.bounds.size.width);
            NSLog(@"h: %f", self.bounds.size.height);
            NSLog(@"SettingView - Exit");
        }
        
    }
    return self;
}
- (void)chooseOne:(id)sender {
    if(_TAG_SETTING_VIDEO_QUALITY_SEGCTRL_ == ((UISegmentedControl *)sender).tag){
        NSLog(@"videoQuality: %@", [sender titleForSegmentAtIndex:[sender selectedSegmentIndex]]);
        [MRPlist writePlist:@"Setting"
                     forkey:@"VideoQuality"
                    content:[NSString stringWithFormat:@"%@", [sender titleForSegmentAtIndex:[sender selectedSegmentIndex]]]];
       
    }
    else if(_TAG_SETTING_STORAGE_SEGCTRL_ == ((UISegmentedControl *)sender).tag){
        NSLog(@"storage: %@", [sender titleForSegmentAtIndex:[sender selectedSegmentIndex]]);
        [MRPlist writePlist:@"Setting"
                     forkey:@"StorageSize"
                    content:[NSString stringWithFormat:@"%@", [sender titleForSegmentAtIndex:[sender selectedSegmentIndex]]]];
       
    }
    else if(_TAG_SETTING_MAIN_SCREEN_SEGCTRL_ == ((UISegmentedControl *)sender).tag){
        NSLog(@"main screen: %@", [sender titleForSegmentAtIndex:[sender selectedSegmentIndex]]);
        [MRPlist writePlist:@"Setting"
                     forkey:@"MainScreen"
                    content:[NSString stringWithFormat:@"%@", [sender titleForSegmentAtIndex:[sender selectedSegmentIndex]]]];
        [self.gydelegate exchangeView:NO];
    }
    else if(_TAG_SETTING_SPEED_UNIT_SEGCTRL_ == ((UISegmentedControl *)sender).tag){
        NSLog(@"Speed Unit: %@", [sender titleForSegmentAtIndex:[sender selectedSegmentIndex]]);
        [MRPlist writePlist:@"Setting"
                     forkey:@"SpeedUnit"
                    content:[NSString stringWithFormat:@"%@", [sender titleForSegmentAtIndex:[sender selectedSegmentIndex]]]];
       
       
    }
}

- (void) hidden:(UIView*)view
{
    [UIView transitionWithView:self
                      duration:0.5
                       options:UIViewAnimationOptionTransitionCurlUp
                    animations:^{[self setHidden:YES];}
                    completion:NULL];
}

- (void) show:(UIView*)view
{
    [self updateAll];
    [UIView transitionWithView:self
                      duration:0.5
                       options:UIViewAnimationOptionTransitionCurlDown
                    animations:^{ [self setHidden:NO];}
                    completion:NULL];
}

- (void) updateSettingViewFrame {
    NSString * removeAds = [NSString stringWithFormat:@"%@",[MRPlist readPlist:@"Setting" forkey:@"RemoveAds"]];
    
        
    UIScrollView * scrollView = (UIScrollView*)[self viewWithTag:_TAG_SETTING_SCROLL_VIEW_];
    UIView * titleView = (UIView*)[self viewWithTag:_TAG_SETTING_TITLE_VIEW_];
    
    CGRect titleViewFrame = titleView.frame;
    if ([removeAds isEqualToString:@"0"])
        titleViewFrame.origin.y = kGADAdSizeBanner.size.height;
    else
        titleViewFrame.origin.y = 0;
    [titleView setFrame:titleViewFrame];
    
    CGRect scrollViewFrame = scrollView.frame;
    if ([removeAds isEqualToString:@"0"])
        scrollViewFrame.origin.y =  titleViewFrame.size.height + kGADAdSizeBanner.size.height;
    else
        scrollViewFrame.origin.y = titleViewFrame.size.height;
    [scrollView setFrame:scrollViewFrame];
}

- (void) updateAll {
    [self updateStorageSize];
    [self updateVideoQuality];
    [self updateMainScreen];
    [self updateSpeedUnit];
}
- (void) updateSpeedUnit {
    UISegmentedControl * speedUnitSegmentedControl = (UISegmentedControl*)[self viewWithTag:_TAG_SETTING_SPEED_UNIT_SEGCTRL_];
    NSString * speedUnit = [NSString stringWithFormat:@"%@",[MRPlist readPlist:@"Setting" forkey:@"SpeedUnit"]];
    if([speedUnit isEqualToString:@"km/h"])
        speedUnitSegmentedControl.selectedSegmentIndex = 0;
    else
        speedUnitSegmentedControl.selectedSegmentIndex = 1;
}
- (void) updateStorageSize
{
    //UIView * contentView = (UIView*)[self viewWithTag:_TAG_SETTING_CONTENT_VIEW_];
    UISegmentedControl * storageSegmentedControl = (UISegmentedControl*)[self viewWithTag:_TAG_SETTING_STORAGE_SEGCTRL_];
    
    
    NSString * storageSize = [NSString stringWithFormat:@"%@",[MRPlist readPlist:@"Setting" forkey:@"StorageSize"]];
    unsigned int storageSizeValue = [[storageSize stringByReplacingOccurrencesOfString:@"" withString:@"G"] intValue];
    if(storageSizeValue<=4)
        storageSegmentedControl.selectedSegmentIndex = storageSizeValue-1;
    else if(storageSizeValue==6)
        storageSegmentedControl.selectedSegmentIndex = 4;
    else
        storageSegmentedControl.selectedSegmentIndex = 5;
    
    double freeDiskSpaceGB = ([ALDisk freeDiskSpaceInBytes]+[ALDisk totalDirSpaceInBytes])/1024/1024/1024;
    
    for(double i=1.0f;i<=6.0f;i++)
    {
        if(i<5.0f)
        {
            if(freeDiskSpaceGB < i)
            {
                [storageSegmentedControl setEnabled:NO forSegmentAtIndex:(unsigned int)(i-1)];
                if((unsigned int)(i-1) == storageSegmentedControl.selectedSegmentIndex)
                {
                    storageSegmentedControl.selectedSegmentIndex = 0;
                    [MRPlist writePlist:@"Setting"
                                 forkey:@"StorageSize"
                                content:[NSString stringWithFormat:@"%@", @"1G"]];
                }
            }
        }
        else if(i==5.0f)
        {
            if(freeDiskSpaceGB < 6.0f)
            {
                [storageSegmentedControl setEnabled:NO forSegmentAtIndex:(unsigned int)(i-1)];
                if((unsigned int)(i-1) == storageSegmentedControl.selectedSegmentIndex)
                {
                    storageSegmentedControl.selectedSegmentIndex = 0;
                    [MRPlist writePlist:@"Setting"
                                 forkey:@"StorageSize"
                                content:[NSString stringWithFormat:@"%@", @"1G"]];
                }
            }
        }
        else{
            if(freeDiskSpaceGB < 8.0f)
            {
                [storageSegmentedControl setEnabled:NO forSegmentAtIndex:(unsigned int)(i-1)];
                
                if((unsigned int)(i-1) == storageSegmentedControl.selectedSegmentIndex)
                {
                    storageSegmentedControl.selectedSegmentIndex = 0;
                    [MRPlist writePlist:@"Setting"
                                 forkey:@"StorageSize"
                                content:[NSString stringWithFormat:@"%@", @"1G"]];
                }
            }
        }
    }


    
    UILabel * storageInfoLabel = (UILabel *)[self viewWithTag:_TAG_SETTING_STORAGE_INFO_LABEL_];
    
    storageInfoLabel.text = [NSString stringWithFormat:@"Total Space:%@ Free Space:%@",
                             [ALDisk totalDiskSpace],
                             [ALDisk memoryFormatter:([ALDisk freeDiskSpaceInBytes] + [ALDisk totalDirSpaceInBytes])]];
}

- (void) updateVideoQuality
{
    //UIView * contentView = (UIView*)[self viewWithTag:_TAG_SETTING_CONTENT_VIEW_];
    UISegmentedControl * videoQualitySegmentedControl = (UISegmentedControl*)[self viewWithTag:_TAG_SETTING_VIDEO_QUALITY_SEGCTRL_];
    NSString * videoQuality = [NSString stringWithFormat:@"%@",[MRPlist readPlist:@"Setting" forkey:@"VideoQuality"]];
    if([videoQuality isEqualToString:@"Normal"])
    {
        videoQualitySegmentedControl.selectedSegmentIndex = 1;
    }
    else if([videoQuality isEqualToString:@"High"])
    {
        
        videoQualitySegmentedControl.selectedSegmentIndex = 0;
    }
    else
    {
        videoQualitySegmentedControl.selectedSegmentIndex = 2;
    }
}

- (void) updateMainScreen
{
    //UIView * contentView = (UIView*)[self viewWithTag:_TAG_SETTING_CONTENT_VIEW_];
    UISegmentedControl * mainScreenSegmentedControl = (UISegmentedControl*)[self viewWithTag:_TAG_SETTING_MAIN_SCREEN_SEGCTRL_];
    NSString * mainScreen = [NSString stringWithFormat:@"%@",[MRPlist readPlist:@"Setting" forkey:@"MainScreen"]];
    
    if([mainScreen isEqualToString:@"Map"])
        mainScreenSegmentedControl.selectedSegmentIndex = 1;
    else if([mainScreen isEqualToString:@"Hybrid"])
        mainScreenSegmentedControl.selectedSegmentIndex = 2;
    else if([mainScreen isEqualToString:@"ECO"])
        mainScreenSegmentedControl.selectedSegmentIndex = 3;
    else
        mainScreenSegmentedControl.selectedSegmentIndex = 0;
    
    //[mainScreenSegmentedControl setEnabled:NO forSegmentAtIndex:1];
    //[mainScreenSegmentedControl setEnabled:NO forSegmentAtIndex:2];
    [mainScreenSegmentedControl setEnabled:NO forSegmentAtIndex:3];
}

//- (void)switchOnOff:(id)sender
//{
//    if(ecoSwitch == sender){
//        NSLog(@"ecoSwitch change");
//        [MRPlist writePlist:@"Setting" forkey:@"ECO" content:[NSString stringWithFormat:@"%d",ecoSwitch.on]];
//    }
//    else if(tapToFocusSwitch == sender){
//        NSLog(@"tapToFocusSwitch change");
//        [MRPlist writePlist:@"Setting" forkey:@"TapToFocus" content:[NSString stringWithFormat:@"%d",tapToFocusSwitch.on]];
//    }
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
