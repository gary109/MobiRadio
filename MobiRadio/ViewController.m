//
//  ViewController.m
//  MobiRadio
//
//  Created by GarY on 2014/10/28.
//  Copyright (c) 2014年 gyhouse. All rights reserved.
//

#import "ViewController.h"

BOOL isPlayBlock = NO;
BOOL isRestartAudio=NO;

ViewController *g_viewController;

typedef enum {
    kTCP = 0,
    kUDP
}kNetworkWay;


@interface ViewController ()
{
    AVFormatContext *pFormatCtx;
    AVCodecContext *pAudioCodeCtx;
    
    int    audioStream;
    
    AudioPlayer *aPlayer;
    BOOL  isStop;
    BOOL  isLocalFile;
}

@property bool contentCreated;
@property (nonatomic,strong) UIImageView *batteryImageView;
@property (nonatomic,strong) LBScreenLockView * lbScreenView;
@property (nonatomic,strong) MRTableView * mrTableView;
@property (nonatomic,strong) MRMenuView * mrMenuView;
@property (nonatomic,strong) MRSettingView * mrSettingView;
@property (nonatomic,strong) MRStoreView * mrStoreView;
@end

@implementation ViewController
@synthesize mrTableView;
@synthesize lbScreenView;
@synthesize bannerView_;
@synthesize mrStoreView;
@synthesize mrSettingView;
@synthesize mrMenuView;
@synthesize batteryImageView;
@synthesize contentCreated;



#pragma mark - touch
//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    NSLog(@"Touches Began");
//    //[self logTouches: event];
//
//    [super touchesEnded: touches withEvent: event];
//}
//
//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    NSLog(@"Touches Moved");
//    //[self logTouches: event];
//
//    [super touchesEnded: touches withEvent: event];
//}
//
//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    NSLog(@"Touches Ended");
//    //[self logTouches: event];
//
//    [super touchesEnded: touches withEvent: event];
//}
//
//-(void)logTouchesFor: (UIEvent*)event
//{
//    int count = 1;
//
//    for (UITouch* touch in event.allTouches)
//    {
//        CGPoint location = [touch locationInView: self.view];
//
//        NSLog(@"%d: (%.0f, %.0f)", count, location.x, location.y);
//        count++;
//    }
//}
#pragma mark
#pragma mark - AdMob
#define GAD_SIMULATOR_ID @"Simulator"

- (void)showAdMob {
    // 在螢幕上方建立標準大小的視圖，
    // 可用的 AdSize 常值已在 GADAdSize.h 中解釋。
    CGPoint origin = CGPointMake(0.0,0.0);
    
    bannerView_ = [[GADBannerView alloc] initWithAdSize:kGADAdSizeSmartBannerPortrait origin:origin];
    
    
    //    CGRect screenFrame3 = [[self.view layer] bounds];
    //    screenFrame3.origin.x = CGRectGetMinX(screenFrame3);
    //    screenFrame3.origin.y = CGRectGetMaxY(screenFrame3)-kGADAdSizeBanner.size.height;
    //    screenFrame3.size = kGADAdSizeBanner.size;
    //    [bannerView_ setFrame:screenFrame3];
    
    
    // 指定廣告單元編號。
    bannerView_.adUnitID = @"ca-app-pub-2264368493541772/7475674709";
    
    // 通知執行階段，將使用者帶往廣告到達網頁後，該恢復哪一個 UIViewController，
    // 並將其加入檢視階層中。
    bannerView_.rootViewController = self;
    
    //        GADRequest *request = [GADRequest request];
    // Requests test ads on devices you specify. Your test device ID is printed to the console when
    // an ad request is made.
    //        request.testDevices = @[GAD_SIMULATOR_ID];//, @"MY_TEST_DEVICE_ID" ];
    
    
    //     request.testDevices = [NSArray arrayWithObjects:
    //                            @[GAD_SIMULATOR_ID],
    //                            @"d6b307ac0ee6cb52d2cd18fe7b3f6ed4c7c634b2",
    //                            nil];
    
    [self.view addSubview:bannerView_];
    
    // 啟動一般請求，隨著廣告一起載入。
    [bannerView_ loadRequest:[GADRequest request]];
    //    [bannerView_ loadRequest:request];
    /*
     
     //*/
    
}
#pragma mark - 電池相關
- (void) updateBatteryImage {
    CGRect screenFrame3 = [[self.view layer] bounds];
    screenFrame3.origin.x = CGRectGetMaxX(screenFrame3)-30;
    NSString * removeAds = [NSString stringWithFormat:@"%@",[MRPlist readPlist:@"Setting" forkey:@"RemoveAds"]];
    if ([removeAds isEqualToString:@"0"])
        screenFrame3.origin.y = CGRectGetMinY(screenFrame3)+kGADAdSizeBanner.size.height;
    else
        screenFrame3.origin.y = CGRectGetMinY(screenFrame3);
    screenFrame3.size.height = 20;
    screenFrame3.size.width = 30;
    batteryImageView.frame =  screenFrame3;
    
    
    UIDevice *device = [UIDevice currentDevice];
    NSLog(@"State: %i Charge: %f", (int)device.batteryState, device.batteryLevel);
    
    switch (device.batteryState) {
        case UIDeviceBatteryStateUnknown:
            [batteryImageView setImage:[UIImage imageNamed:@"Mobile-Empty-Battery-icon"]];
            break;
        case UIDeviceBatteryStateFull:
            [batteryImageView setImage:[UIImage imageNamed:@"Mobile-Full-Battery-icon"]];
            break;
        case UIDeviceBatteryStateUnplugged:
            if(device.batteryLevel <= 0.25)
                [batteryImageView setImage:[UIImage imageNamed:@"Mobile-Battery-25-Percent-icon"]];
            else if(device.batteryLevel <= 0.5)
                [batteryImageView setImage:[UIImage imageNamed:@"Mobile-Battery-50-Percent-icon"]];
            else if(device.batteryLevel <= 0.75)
                [batteryImageView setImage:[UIImage imageNamed:@"Mobile-Battery-75-Percent-icon"]];
            else
                [batteryImageView setImage:[UIImage imageNamed:@"Mobile-Battery-Full-icon"]];
            break;
        case UIDeviceBatteryStateCharging:
            [batteryImageView setImage:[UIImage imageNamed:@"Mobile-Charge-Battery-icon"]];
            break;
        default:
            break;
    }
    //[batteryImageView removeFromSuperview];
    
    
}
- (void) createBatteryView {
    UIDevice *device = [UIDevice currentDevice];
    device.batteryMonitoringEnabled = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(batteryLevelChanged:)
                                                 name:UIDeviceBatteryLevelDidChangeNotification
                                               object:device];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(batteryStateChanged:)
                                                 name:UIDeviceBatteryStateDidChangeNotification
                                               object:device];
    
    batteryImageView = [[UIImageView alloc] init];// initWithImage:[UIImage imageNamed:@"Mobile-Full-Battery-icon"]];
    
    
    [self updateBatteryImage];
    
    
}
- (void) batteryLevelChanged:(NSNotification *)notification {
    NSLog(@"batteryLevelChanged");
    [self updateBatteryImage];
}
- (void) batteryStateChanged:(NSNotification *)notification {
    NSLog(@"batteryStateChanged");
    [self updateBatteryImage];
}
#pragma mark - 畫面布局相關
- (void) createScreenLockView {
    CGRect screenFrame3 = [[self.view layer] bounds];
    screenFrame3.origin.y = CGRectGetMinY(screenFrame3);
    lbScreenView = [[LBScreenLockView alloc] initWithFrame:screenFrame3];
    lbScreenView.gydelegate = self;
    [self.view addSubview:lbScreenView];
}
- (void) createStoreView {
    CGRect screenFrame3 = [[self.view layer] bounds];
    screenFrame3.origin.y = CGRectGetMinY(screenFrame3);
    mrStoreView = [[MRStoreView alloc] initWithFrame:screenFrame3];
    mrStoreView.gydelegate = self;
    [self.view addSubview:mrStoreView];
}
- (void) createMenuView {
    CGRect screenFrame2 = [[self.view layer] bounds];
    screenFrame2.origin.x = CGRectGetMaxX(screenFrame2)-_Menu_Icon_W_*_MenuIconCounts_;
    screenFrame2.origin.y = CGRectGetMaxY(screenFrame2)-_Menu_Icon_H_;
    screenFrame2.size.height = _Menu_Icon_H_;
    screenFrame2.size.width = _Menu_Icon_W_*_MenuIconCounts_;
    mrMenuView = [[MRMenuView alloc] initWithFrame:screenFrame2];
    mrMenuView.gydelegate = self;
    [self.view addSubview:mrMenuView];
}
- (void) createSettingView {
    CGRect screenFrame3 = [[self.view layer] bounds];
    NSString * removeAds = [NSString stringWithFormat:@"%@",[MRPlist readPlist:@"Setting" forkey:@"RemoveAds"]];
    if ([removeAds isEqualToString:@"0"]) {
        screenFrame3.origin.y = kGADAdSizeSmartBannerLandscape.size.height;
        screenFrame3.size.height -= kGADAdSizeSmartBannerLandscape.size.height;
    }else{
        
    }
    mrSettingView = [[MRSettingView alloc] initWithFrame:screenFrame3];
    mrSettingView.gydelegate = self;
    [self.view addSubview:mrSettingView];
}
- (void) createMoviesTableView {
    CGRect screenFrame3 = [[self.view layer] bounds];
    screenFrame3.size.height /=2;
    
    mrTableView = [[MRTableView alloc]initWithFrame:screenFrame3];
    mrTableView.gydelegate = self;
    [self.view addSubview:mrTableView];
}
- (void) viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    if(!contentCreated)
    {
        // 不進入休眠
        UIApplication *app = [UIApplication sharedApplication];
        app.idleTimerDisabled = YES;
        
        g_viewController = self;
        
        // Configure the view.
        self.view.backgroundColor = [UIColor grayColor];

        [self createBatteryView];
        [self createMenuView];
        [self createSettingView];
        [self showBatteryView];
        [self createMoviesTableView];
  
        UIButton * btnRadioPlay = [[UIButton alloc] initWithFrame: CGRectMake(100,
                                                                              CGRectGetMidY([[self.view layer] bounds]),
                                                                              _Menu_Icon_W_,
                                                                              _Menu_Icon_H_)];
        [btnRadioPlay setTag:_TAG_RADIO_PLAY_BTN_];
        [btnRadioPlay setImage:[UIImage imageNamed:@"GPS_Record_Start"] forState:UIControlStateNormal];
        [btnRadioPlay addTarget:self action:@selector(handleBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btnRadioPlay];
        
        [self exchangeView:NO];
        
        //        NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        //        NSString *appName1 = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"];
        //
        
        
        //        float ver = [[[UIDevice currentDevice] systemVersion] floatValue];
        //        if (ver >= 3.0) {
        //            // Only executes on version 3 or above.
        //        }
        //
        //                UIAlertView * myAlertView = [[UIAlertView alloc] initWithTitle:@"Version"
        //                                                                       message:[NSString stringWithFormat:@"os version:%f", ver]
        //                                                                      delegate:nil
        //                                                             cancelButtonTitle:@"OK"
        //                                                             otherButtonTitles: nil];
        //
        //                [myAlertView show];
        
        contentCreated = YES;
        
        NSString * removeAds = [NSString stringWithFormat:@"%@",[MRPlist readPlist:@"Setting" forkey:@"RemoveAds"]];
        if ([removeAds isEqualToString:@"0"])
            [self showAdMob];
        
        [self createStoreView];
        
        //[self createScreenLockView];
        //[self showScreenLockView];
        
        //[UIViewController attemptRotationToDeviceOrientation];//这行代码是关键
        
        
        [self showMoviesTableView];
       
        
//                NSArray *menuData = [MRJSON getJSONData:@"radio" categoryName:@"radioList-Taiwan"];
//                NSDictionary *cellData = [menuData objectAtIndex:0];
//                NSString * title = [cellData objectForKey:@"title"];
//                NSString * uri = [cellData objectForKey:@"uri"];
//        
//                NSLog(@"current volume = %f", [self getVolumeLevel]);
//        
//                NSLog(@"title=%@, uri=%@", title,uri);
//                channelAddr = uri;
//        
//        
//                [self PlayAudioAll:YES];
    
        
        
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(volumeChanged:)
                                                     name:@"AVSystemController_SystemVolumeDidChangeNotification"
                                                   object:nil];
        
        //        MPMusicPlayerController *ipodMusicPlayer = [MPMusicPlayerController iPodMusicPlayer];
        //        [ipodMusicPlayer beginGeneratingPlaybackNotifications];
        //        [[NSNotificationCenter defaultCenter] addObserver:self
        //                                                 selector:@selector(trackTheDeviceVolume:)
        //                                                     name:MPMusicPlayerControllerVolumeDidChangeNotification
        //                                                   object:nil];
        
        
        
    }
}
- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL) shouldAutorotate {
    return YES;
}
//- (NSUInteger)supportedInterfaceOrientations {
//    return UIInterfaceOrientationMaskLandscape;
//}
- (NSUInteger) supportedInterfaceOrientations {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        return UIInterfaceOrientationMaskPortrait;
    //return UIInterfaceOrientationMaskLandscape; // 只支援橫螢幕
    else
        return UIInterfaceOrientationMaskPortrait;
    //    return UIInterfaceOrientationMaskLandscape; // 只支援橫螢幕
    
    // return UIInterfaceOrientationMaskLandscape;
}
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
//{
//    return UIInterfaceOrientationLandscapeLeft|UIInterfaceOrientationLandscapeRight;
//}

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    return (UIInterfaceOrientationMaskLandscape);
//}
// 隱藏Status Bar
- (BOOL) prefersStatusBarHidden {
    return YES;
}
#pragma mark
#pragma mark - gyDelegate Battery View
- (void) showBatteryView{
    [self.view addSubview:batteryImageView];
}
#pragma mark
#pragma mark - gyDelegate Store View
- (void) showStoreView{
    [mrStoreView show:self.view];
}
- (void) hiddenStoreView{
    [mrStoreView hidden:self.view];
}
#pragma mark
#pragma mark - gyDelegate Setting View
- (void) updateSettingViewFrame {
    [mrSettingView updateSettingViewFrame];
}
- (void) showSettingView {
    [mrSettingView show:self.view];
}
- (void) hiddenSettingView {
    [mrSettingView hidden:self.view];
}
- (void) updateStorageSizeLimit {
   
}
- (void) updateVideoQuality {
    
}
#pragma mark
#pragma mark - gyDelegate Others
- (void) removeAdmob {
    [bannerView_ removeFromSuperview];
}
- (void) method1:(NSString*)value1 {
    //撰寫取得value1後的反應。
    NSLog(@"method1:%@", value1);
}
- (void) method2:(NSString*)value2 {
    //撰寫取得value2後的反應。
    NSLog(@"method2:%@", value2);
}
#pragma mark
#pragma mark - gyDelegate Setting View
- (void) exchangeView:(BOOL)animation {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo: self.view animated: YES];
    hud.labelText = @"Please Wait...";
    hud.opacity = 0.5;
    hud.labelFont = [UIFont systemFontOfSize:10];
    
    
    //    UIAlertView * myAlertView = [[UIAlertView alloc] initWithTitle:@"Configuring Preferences\nPlease Wait..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
    //    [myAlertView show];
    
    
    //        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    //
    //        // Adjust the indicator so it is up a few pixels from the bottom of the alert
    //        //indicator.center = CGPointMake(myAlertView.bounds.size.width / 2, myAlertView.bounds.size.height - 50);
    //        indicator.center = CGPointMake(CGRectGetMidX([[self.view layer] bounds]), CGRectGetMidY([[self.view layer] bounds]));
    //        [indicator startAnimating];
    //        [self.view addSubview:indicator];
    
    
    CGRect screenFrame3 = [[self.view layer] bounds];
    screenFrame3.origin.x = CGRectGetMinX(screenFrame3);
    NSString * removeAds = [NSString stringWithFormat:@"%@",[MRPlist readPlist:@"Setting" forkey:@"RemoveAds"]];
    if ([removeAds isEqualToString:@"0"])
        screenFrame3.origin.y = 32;
    else
        screenFrame3.origin.y = 0;
    screenFrame3.size.width = 150;
    screenFrame3.size.height = 150;
    
    NSString* mainScreen1 = [NSString stringWithFormat:@"%@",[MRPlist readPlist:@"Setting" forkey:@"MainScreen"]];
    
    if([mainScreen1 isEqualToString:@"Video"]){
        if(animation)
        {
            //            [UIView transitionWithView:self.view
            //                              duration:0.5
            //                               options:UIViewAnimationOptionTransitionFlipFromTop
            //                            animations:^
            //                            {
            //                                [mrCameraView setFrame:[[self.view layer] bounds]];
            //                                [mrCameraView updateAll];
            //                                [self.view sendSubviewToBack:mrMapView];
            //                            }
            //                            completion:^(BOOL finished)
            //                            {
            //
            //                            }];
//            [mrCameraView setFrame:[[self.view layer] bounds]];
//            [mrCameraView updateAll];
//            [mrCameraView show:self.view];
//            //[self.view sendSubviewToBack:mrMapView];
//            [mrMapView hidden:self.view];
        }
        else
        {
//            [mrCameraView setFrame:[[self.view layer] bounds]];
//            [mrCameraView updateAll];
//            [mrCameraView show:self.view];
//            //[self.view sendSubviewToBack:mrMapView];
//            [mrMapView hidden:self.view];
        }
    }
    else if([mainScreen1 isEqualToString:@"Map"]){
        if(animation)
        {
            //            [UIView transitionWithView:self.view
            //                              duration:0.5
            //                               options:UIViewAnimationOptionTransitionFlipFromTop
            //                            animations:^
            //                            {
            //                                [self.view sendSubviewToBack:mrCameraView];
            //                            }
            //                            completion:^(BOOL finished)
            //                            {
            //
            //                            }];
//            [mrCameraView hidden:self.view];
//            [mrMapView show:self.view];
        }
        else
        {
            //            [self.view sendSubviewToBack:mrCameraView];
//            [mrCameraView hidden:self.view];
//            [mrMapView show:self.view];
        }
    }
    else if([mainScreen1 isEqualToString:@"Hybrid"]){
        if(animation)
        {
            //            [UIView transitionWithView:self.view
            //                              duration:0.5
            //                               options:UIViewAnimationOptionTransitionFlipFromTop
            //                            animations:^
            //                            {
            //                                [mrCameraView setFrame:screenFrame3];
            //                                [mrCameraView updateAll];
            //                                [self.view sendSubviewToBack:mrMapView];
            //                            }
            //                            completion:^(BOOL finished)
            //                            {
            //
            //                            }];
            
//            [mrCameraView setFrame:screenFrame3];
//            [mrCameraView updateAll];
//            [mrCameraView show:self.view];
//            [mrMapView show:self.view];
        }
        else
        {
            //            [mrCameraView setFrame:screenFrame3];
            //            [mrCameraView updateAll];
//            //            [self.view sendSubviewToBack:mrMapView];
//            [mrCameraView setFrame:screenFrame3];
//            [mrCameraView updateAll];
//            [mrCameraView show:self.view];
//            [mrMapView show:self.view];
        }
    }
    //    [myAlertView dismissWithClickedButtonIndex:0 animated:YES];
    //    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
    //        // Do something...
    //        dispatch_async(dispatch_get_main_queue(), ^{
    //            [MBProgressHUD hideHUDForView:self.view animated:YES];
    //        });
    //    });
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
#pragma mark
#pragma mark - gyDelegate LBScreenLock View
- (void) showScreenLockView{
    [lbScreenView show:self.view];
}
- (void) hiddenScreenLockView{
    [lbScreenView hidden:self.view];
}
- (BOOL) isScreenLock {
    return [lbScreenView isScreenLock];
}
- (void) setScreenLock:(BOOL)sw {
    [lbScreenView setScreenLock:sw];
}
#pragma mark
#pragma mark - gyDelegate Table View
- (void) updateMoviesTableViewFrame {
    [mrTableView updateMoviesTableViewFrame];
}
- (void) addTableViewItem:(NSString*)filename {
    [mrTableView.moviesArray insertObject:filename atIndex:0]; // 最新的檔案在最上面
    [mrTableView.tableViewMovies reloadData];
}
- (void) showMoviesTableView{
    [mrTableView show:self.view];
}
- (void) hiddenMoviesTableView{
    [mrTableView hidden:self.view];
}

-(void) playAudio:(NSString*)uri {
    channelAddr = uri;
    [self stopFFmpegAudioStream];
    [aPlayer stop:YES];
    [self stopPlayAudio];
    [self RestartAudio];
    //[self PlayAudioAll:YES];
}
#pragma mark
#pragma mark - gyDelegate Radio

#pragma mark - FFmpeg processing
- (BOOL)initFFmpegAudioStream:(NSString *)filePath withTransferWay:(kNetworkWay)network {
    NSString *pAudioInPath;
    AVCodec  *pAudioCodec;
    
    // Parse header
    uint8_t pInput[] = {0x0ff,0x0f9,0x058,0x80,0,0x1f,0xfc};
    tAACADTSHeaderInfo vxADTSHeader={0};
    [AudioUtilities parseAACADTSHeader:pInput toHeader:(tAACADTSHeaderInfo *) &vxADTSHeader];
    
    // Compare the file path
    if (strncmp([filePath UTF8String], "rtsp", 4) == 0) {
        pAudioInPath = filePath;
        isLocalFile = NO;
    } else if (strncmp([filePath UTF8String], "mms:", 4) == 0) {
        pAudioInPath = [filePath stringByReplacingOccurrencesOfString:@"mms:" withString:@"rtsp:"];
        NSLog(@"Audio path %@", pAudioInPath);
        isLocalFile = NO;
    } else if (strncmp([filePath UTF8String], "mmsh:", 4) == 0) {
        pAudioInPath = filePath;
        isLocalFile = NO;
    } else {
        pAudioInPath = [[[NSBundle mainBundle] bundlePath] stringByAppendingString:filePath];
        isLocalFile = YES;
    }
    
    // Register FFmpeg
    avcodec_register_all();
    av_register_all();
    if (isLocalFile == NO) {
        avformat_network_init();
    }
    
    @synchronized(self) {
        pFormatCtx = avformat_alloc_context();
        //zzzili
        pFormatCtx->interrupt_callback.callback = interrupt_cb;//--------注册回调函数
        pFormatCtx->interrupt_callback.opaque = pFormatCtx;
    }
    
    // Set network path
    switch (network) {
        case kTCP:
        {
            AVDictionary *option = 0;
            av_dict_set(&option, "rtsp_transport", "tcp", 0);
            // Open video file
            if (avformat_open_input(&pFormatCtx, [pAudioInPath cStringUsingEncoding:NSASCIIStringEncoding], NULL, &option) != 0) {
                NSLog(@" kTCP - Could not open connection");
                return NO;
            }
            av_dict_free(&option);
        }
            break;
        case kUDP:
        {
            if (avformat_open_input(&pFormatCtx, [pAudioInPath cStringUsingEncoding:NSASCIIStringEncoding], NULL, NULL) != 0) {
                NSLog(@"kUDP - Could not open connection");
                return NO;
            }
        }
            break;
    }
    
    pAudioInPath = nil;
    
    // Retrieve stream information
    if (avformat_find_stream_info(pFormatCtx, NULL) < 0) {
        NSLog(@"Could not find streaming information");
        return NO;
    }
    
    // Dump Streaming information
    av_dump_format(pFormatCtx, 0, [pAudioInPath UTF8String], 0);
    
    // Find the first audio stream
    if ((audioStream = av_find_best_stream(pFormatCtx, AVMEDIA_TYPE_AUDIO, -1, -1, &pAudioCodec, 0)) < 0) {
        NSLog(@"Could not find a audio streaming information");
        return NO;
    } else {
        // Succeed to get streaming information
        //        NSLog(@"== Audio pCodec Information");
        //        NSLog(@"name = %s",pAudioCodec->name);
        //        NSLog(@"sample_fmts = %d",*(pAudioCodec->sample_fmts));
        
        if (pAudioCodec->profiles) {
            NSLog(@"Profile names = %@", pAudioCodec->profiles);
        } else {
            //            NSLog(@"Profile is Null");
        }
        
        // Get a pointer to the codec context for the video stream
        pAudioCodeCtx = pFormatCtx->streams[audioStream]->codec;
        
        // Find out the decoder
        pAudioCodec = avcodec_find_decoder(pAudioCodeCtx->codec_id);
        
        // Open codec
        if (avcodec_open2(pAudioCodeCtx, pAudioCodec, NULL) < 0) {
            return NO;
        }
    }
    
    isStop = NO;
    
    return YES;
}

static int interrupt_cb(void *ctx) {
    //zzzili
    // do something
    if(isPlayBlock==YES)
    {
        return 1;
    }
    
    return 0;
}
- (void)readFFmpegAudioFrameAndDecode {
    int error;
    AVPacket aPacket;
    av_init_packet(&aPacket);
    
    //    if (isLocalFile) {
    //        // Local File playing
    //        while (isStop == NO) {
    //            // Read frame
    //            error = av_read_frame(pFormatCtx, &aPacket);
    //            if (error == AVERROR_EOF) {
    //                // End of playing music
    //                isStop = YES;
    //            } else if (error == 0) {
    //                // During playing..
    //                if (aPacket.stream_index == audioStream) {
    //                    if ([aPlayer putAVPacket:&aPacket] <=0 ) {
    //                        NSLog(@"Put Audio packet error");
    //                    }
    //                    // For local file, packet should delay
    //                    usleep(1000 * 25);
    //                } else {
    //                    av_free_packet(&aPacket);
    //                }
    //            } else {
    //                // Error occurs
    //                NSLog(@"av_read_frame error :%s", av_err2str(error));
    //                isStop = YES;
    //            }
    //        }
    //    } else
    {
        
        // Remote File playing
        while (isStop == NO) {
            //            NSLog(@"%@--putAVPacket------%d",aPlayer,aPlayer->audioPacketQueue.count);
            // Read frame
            error = av_read_frame(pFormatCtx, &aPacket);
            if(isPlayBlock == YES)
            {
                //zzzili
                [self RestartAudio];
                return;
            }
            if (error == AVERROR_EOF) {
                // End of playing music
                isStop = YES;
            } else if (error == 0) {
                // During playing..
                if (aPacket.stream_index == audioStream) {
                    if ([aPlayer putAVPacket:&aPacket] <=0 ) {
                        NSLog(@"Put Audio packet error");
                    }
                } else {
                    av_free_packet(&aPacket);
                }
            } else {
                // Error occurs
                NSLog(@"av_read_frame error :%s", av_err2str(error));
                isStop = YES;
            }
        }
    }
    NSLog(@"End of playing ffmpeg");
}
- (void)PlayAudioAll:(BOOL)isClearMem {
    
    [MBProgressHUD showHUDAddedTo: self.view animated: YES];
    
    // Succeed to play audio
    /// TODO: determine if this streaming support ffmpeg
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        
        if ([self initFFmpegAudioStream:channelAddr withTransferWay:kTCP] == NO)
        {
            NSLog(@"Init ffmpeg failed");
            dispatch_async(dispatch_get_main_queue(), ^{
                //playBtn.selected = NO;
                
                
                    UIButton * btnPlay = (UIButton*)[g_viewController.view viewWithTag:_TAG_RADIO_PLAY_BTN_];
                    [btnPlay setImage:[UIImage imageNamed:@"GPS_Record_Start"] forState:UIControlStateNormal];
                
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                
            });
            return;
        }
        
        if(isClearMem==NO&&aPlayer != nil&&aPlayer->audioPacketQueue.count>5)
        {
            aPlayer = [[AudioPlayer alloc] initAuido:aPlayer->audioPacketQueue withCodecCtx:(AVCodecContext *)pAudioCodeCtx];
            
        }
        else
        {
            aPlayer = [[AudioPlayer alloc] initAuido:nil withCodecCtx:(AVCodecContext *)pAudioCodeCtx];
        }
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if(aPlayer->audioPacketQueue.count<50||isClearMem == YES)
            {
                sleep(5);
                NSLog(@"播放");
                UIButton * btnPlay = (UIButton*)[g_viewController.view viewWithTag:_TAG_RADIO_PLAY_BTN_];
                [btnPlay setImage:[UIImage imageNamed:@"GPS_Record_Stop"] forState:UIControlStateNormal];
            }
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            isRestartAudio = NO;
            if ([aPlayer getStatus] != eAudioRunning) {
                [aPlayer play];
            }
        });
        
        // Read Packet in another thread
        [self readFFmpegAudioFrameAndDecode];
        
    });
    // Read ffmpeg audio packet in another thread
    
}
- (void)RestartAudio {
    if(isRestartAudio == NO)
    {
        isRestartAudio = YES;
        NSLog(@"重启播放线程------");
        [self stopFFmpegAudioStream];
        [aPlayer stop:YES];
        [self stopPlayAudio];
        
        [self PlayAudioAll:NO];
        isPlayBlock = NO;
    }
}
- (void)stopFFmpegAudioStream {
    isStop = YES;
}
- (void)destroyFFmpegAudioStream {
    avformat_network_deinit();
}
- (void)stopPlayAudio {
    [self stopFFmpegAudioStream];
    [aPlayer stop:YES];
    [self destroyFFmpegAudioStream];
}

#pragma mark
#pragma mark - 音量控制
- (void)volumeChanged:(NSNotification *)notification {
    
    float volume = [[[notification userInfo] objectForKey:@"AVSystemController_AudioVolumeNotificationParameter"] floatValue];
    
    NSLog(@"current volume = %f", volume);
    
}
- (float) getVolumeLevel {
    MPVolumeView* slide =[MPVolumeView new];
    UISlider*volumeViewSlider;
    for(UIView*view in[slide subviews]){
        if([[[view class] description] isEqualToString:@"MPVolumeSlider"])
        {
            volumeViewSlider =(UISlider*) view;
        }
    }
    float val =[volumeViewSlider value];
    return val;
}
#pragma mark - 按鍵宣告
- (void) handleBtnClicked:(id)sender {
    if(_TAG_RADIO_PLAY_BTN_ == ((UIButton *)sender).tag)
    {
        NSLog(@"handleRadioPlayBtnClicked...");
        
        if([aPlayer getStatus] == eAudioRunning) {
            [self stopFFmpegAudioStream];
            [aPlayer stop:YES];
            [self stopPlayAudio];
        }else{
            [self RestartAudio];
        }
        
        if([aPlayer getStatus] == eAudioRunning) {
            UIButton * btnRadioPlay = (UIButton*)[g_viewController.view viewWithTag:_TAG_RADIO_PLAY_BTN_];
            [btnRadioPlay setImage:[UIImage imageNamed:@"GPS_Record_Stop"] forState:UIControlStateNormal];
        }else{
            UIButton * btnRadioPlay = (UIButton*)[g_viewController.view viewWithTag:_TAG_RADIO_PLAY_BTN_];
            [btnRadioPlay setImage:[UIImage imageNamed:@"GPS_Record_Start"] forState:UIControlStateNormal];
        }
    }
}
@end
