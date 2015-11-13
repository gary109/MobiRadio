//
//  MRTableView.m
//  MobRecorder
//
//  Created by GarY on 2014/9/3.
//  Copyright (c) 2014年 GarY WanG. All rights reserved.
//

#import "MRTableView.h"
#import "MRJSON.h"
#import "ViewController.h"


@interface MRTableView() {}
@property (nonatomic,retain) MPMoviePlayerViewController *playerViewController;
@end

@implementation MRTableView
@synthesize moviesArray,moviesArray1;
@synthesize tableViewMovies;
@synthesize playerViewController;

- (void) handleBackBtnClicked:(id)sender {
    NSLog(@"Back button have been clicked.");
    [self.gydelegate hiddenMoviesTableView];
}
- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        if(!contentCreated){
            contentCreated = YES;
            
            int titleView_H = 60;

            //moviesArrayTemp = [[NSMutableArray alloc] init];
            moviesArray = [[NSMutableArray alloc] init];
            moviesArray1 = [[NSMutableArray alloc] init];
            //---------------------------------------------------------------------------------------------------------------------//
            // 初始化 uiTableView
            UIView * uiTableView = [[UIView alloc] initWithFrame:[[self layer] bounds]];
            uiTableView.backgroundColor=[UIColor lightGrayColor];
            uiTableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight;
            [uiTableView setTag:_TAG_MOVIESTABLE_VIEW_];
            [self addSubview:uiTableView];
            //---------------------------------------------------------------------------------------------------------------------//
            UIView * uiTableTitleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[self layer] bounds].size.width, titleView_H)];
            uiTableTitleView.backgroundColor=[UIColor darkGrayColor];
            uiTableTitleView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight;
            [uiTableView addSubview:uiTableTitleView];
            //---------------------------------------------------------------------------------------------------------------------//
            // Back 按鍵布局
            UIButton * btnBack = [[UIButton alloc] initWithFrame: CGRectMake(CGRectGetMinX(uiTableView.frame),
                                                                             CGRectGetMinY(uiTableView.frame),
                                                                             titleView_H,
                                                                             titleView_H)];
            [btnBack setImage:[UIImage imageNamed:@"back-icon1.png"] forState:UIControlStateNormal];
            
            // 設定按鍵的觸發動作
            [btnBack addTarget:self action:@selector(handleBackBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [uiTableTitleView addSubview:btnBack];
            
            //---------------------------------------------------------------------------
            // Title Icon
            //---------------------------------------------------------------------------
            UIImageView * titleIconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Folder-Camera-icon"]];
            CGRect titleIconFrame = CGRectMake(CGRectGetMidX(self.frame)-titleView_H/2,
                                               0,
                                               titleView_H,
                                               titleView_H);
            titleIconImageView.frame = titleIconFrame;
            titleIconImageView.alpha = 1.0;
            [uiTableTitleView addSubview:titleIconImageView];
            //---------------------------------------------------------------------------------------------------------------------//
            tableViewMovies =[[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                           60,
                                                                           [[self layer] bounds].size.width,
                                                                           [[self layer] bounds].size.height-titleView_H)];
            tableViewMovies.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight;
            tableViewMovies.backgroundColor=[UIColor clearColor];
            [uiTableView addSubview:tableViewMovies];
            
            tableViewMovies.delegate = self;
            tableViewMovies.dataSource = self;
            tableViewMovies.rowHeight = 40;
            
            // We essentially implement our own selection
            tableViewMovies.allowsSelection = NO;
            
            // Makes the horizontal row seperator stretch the entire length of the table view
            tableViewMovies.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
            //---------------------------------------------------------------------------------------------------------------------//
            //Set the file save to URL
//            NSString *DestPath;
//            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
//                                                                 NSUserDomainMask,
//                                                                 YES);
//            DestPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"MobRecord"];
//            
//            NSLog(@"目前目錄路徑為 : %@", DestPath);
//            NSLog(@"印出路徑中所有內容：");
//            
//            NSDirectoryEnumerator *direnum = [[NSFileManager defaultManager] enumeratorAtPath: DestPath];
//            NSString *filename;
//            while ((filename = [direnum nextObject]))
//            {
//                NSLog (@"file!  %@", filename);
//           //     if(![moviesArrayTemp containsObject:filename])
//                    [moviesArray insertObject:filename atIndex:0];// 最新的檔案在最上面
//            }
//
//
            NSArray *menuData = [MRJSON getJSONData:@"radio" categoryName:@"radioList-Taiwan"];
            
            
            for(int i=0;i<[menuData count];i++) {
                [moviesArray addObject:[[menuData objectAtIndex:i] objectForKey:@"title"]];
                [moviesArray1 addObject:[[menuData objectAtIndex:i] objectForKey:@"uri"]];
                //[moviesArray insertObject:[[menuData objectAtIndex:i] objectForKey:@"title"] atIndex:0];
            }
            
//            
//            
//            while ((cellData = [[menuData objectEnumerator] nextObject]))
//            {
//                //NSLog (@"file!  %@", filename);
//                //     if(![moviesArrayTemp containsObject:filename])
//                //[moviesArray insertObject:filename atIndex:0];// 最新的檔案在最上面
//                
//                
//                
//            }

            
            
            
           // NSDictionary *cellData = [menuData objectAtIndex:0];
            //NSString * title = [cellData objectForKey:@"title"];
            //NSString * uri = [cellData objectForKey:@"uri"];
            
            [self updateMoviesTableViewFrame];
            [self setHidden:YES];
            
        }

    }
    return self;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return moviesArray.count;
}
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"cell selected at index path %ld", (long)indexPath.row);
    
//    NSString *DestPath;
//    NSString *DestPathTmp;
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
//                                                         NSUserDomainMask,
//                                                         YES);
//    DestPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"MobRecord/"];
//    DestPathTmp = [DestPath stringByAppendingPathComponent:[moviesArray objectAtIndex:indexPath.row]];
//    NSLog(@"outputFileURL: %@", DestPathTmp);
//    [self playVideo:DestPathTmp];
    
    [self.gydelegate playAudio:[moviesArray1 objectAtIndex:indexPath.row]];
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SWTableViewCell *cell;
    
    
    static NSString *cellIdentifier = @"MoviesCell";
    
    cell = (SWTableViewCell *)[self.tableViewMovies dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        NSMutableArray *leftUtilityButtons = [NSMutableArray new];
        NSMutableArray *rightUtilityButtons = [NSMutableArray new];
        
        //        [leftUtilityButtons addUtilityButtonWithColor:
        //         [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.0]
        //                                                 icon:[UIImage imageNamed:@"youtube-icon.png"]];
        //        [leftUtilityButtons addUtilityButtonWithColor:
        //         [UIColor colorWithRed:1.0f green:1.0f blue:0.35f alpha:1.0]
        //                                                 icon:[UIImage imageNamed:@"clock.png"]];
        //        [leftUtilityButtons addUtilityButtonWithColor:
        //         [UIColor colorWithRed:1.0f green:0.231f blue:0.188f alpha:1.0]
        //                                                 icon:[UIImage imageNamed:@"cross.png"]];
        //        [leftUtilityButtons addUtilityButtonWithColor:
        //         [UIColor colorWithRed:0.55f green:0.27f blue:0.07f alpha:1.0]
        //                                                 icon:[UIImage imageNamed:@"list.png"]];
        
        [rightUtilityButtons addUtilityButtonWithColor:[UIColor colorWithRed:0.0f green:0.25f blue:0.8f alpha:1.0]
                                                 title:@"Album"];
        [rightUtilityButtons addUtilityButtonWithColor:[UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f]
                                                 title:@"Delete"];
        
        cell = [[SWTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:cellIdentifier
                                  containingTableView:self.tableViewMovies // Used for row height and selection
                                   leftUtilityButtons:leftUtilityButtons
                                  rightUtilityButtons:rightUtilityButtons];
        cell.delegate = self;
    }
    
    cell.textLabel.text = moviesArray[indexPath.row];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", moviesArray1[indexPath.row]];
    
//    NSString *DestPath;
//    NSString *DestPathTmp;
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    DestPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"MobRecord/"];
//    DestPathTmp = [DestPath stringByAppendingPathComponent:[moviesArray objectAtIndex:indexPath.row]];
//    
//    // 取得影片時間長度 - 方法1
//    AVPlayerItem* playItem = [AVPlayerItem  playerItemWithURL:[NSURL fileURLWithPath:DestPathTmp]];
//    CMTime duration = [[playItem asset]duration];
//    unsigned long long seconds = (unsigned long long)CMTimeGetSeconds(duration);
//    
//    // 取得影片時間長度 - 方法2
//    // 使用文件路径初始化avassets
//    AVAsset *movieAsset = [AVAsset assetWithURL:[NSURL fileURLWithPath:DestPathTmp]];
//    
//    // 获取视频的截图,截第0秒的视频的图片
//    AVAssetImageGenerator *assetImageGenerator = [AVAssetImageGenerator assetImageGeneratorWithAsset:movieAsset];
//    CGImageRef imageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(0, 1) actualTime:NULL error:NULL];
//    
//    cell.imageView.image = [UIImage imageWithCGImage:imageRef];
//    
//    cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2llu:%.2llu:%.2llu",   totalSecondsToHr(seconds),
//                                 totalSecondsToMin(seconds),
//                                 totalSecondsToSec(seconds)];
    return cell;
}
- (void) scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    NSLog(@"scroll view did begin dragging");
}
- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    // Set background color of cell here if you don't want white
}
#pragma mark
#pragma mark - SWTableViewDelegate
- (void) swippableTableViewCell:(SWTableViewCell *)cell didTriggerLeftUtilityButtonWithIndex:(NSInteger)index {
    switch (index) {
        case 0:
        {
            NSLog(@"left button 0 was pressed");
            //            NSString *DestPath;
            //            NSString *DestPathTmp;
            //            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
            //                                                                 NSUserDomainMask,
            //                                                                 YES);
            //            DestPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"MobRecord/"];
            //            NSIndexPath *cellIndexPath = [self.tableView indexPathForCell:cell];
            //            DestPathTmp = [DestPath stringByAppendingPathComponent:[_testArray objectAtIndex:cellIndexPath.row]];
            //
            //            NSLog(@"outputFileURL: %@", DestPathTmp);
            //
            //            [self playVideo:DestPathTmp];
            
            UIAlertView *alertTest = [[UIAlertView alloc] initWithTitle:@"Message"
                                                                message:@"Unopened"
                                                               delegate:nil
                                                      cancelButtonTitle:@"cancel"
                                                      otherButtonTitles: nil];
            [alertTest show];
            
            
            break;
        }
        case 1:
            NSLog(@"left button 1 was pressed");
            break;
        case 2:
            NSLog(@"left button 2 was pressed");
            break;
        case 3:
            NSLog(@"left btton 3 was pressed");
        default:
            break;
    }
}
- (void) swippableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    switch (index) {
        case 0:
        {
            NSLog(@"Move button was pressed");
            
            NSString *fileName;
            NSString *DestPath;
            NSString *DestPathTmp;
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                 NSUserDomainMask,
                                                                 YES);
            DestPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"MobRecord/"];
            NSIndexPath *cellIndexPath = [self.tableViewMovies indexPathForCell:cell];
            
            
            fileName = [moviesArray objectAtIndex:cellIndexPath.row];
            DestPathTmp = [DestPath stringByAppendingPathComponent:fileName];
            
//            //轉存 Temp
//            if(![moviesArrayTemp containsObject:fileName])
//                [moviesArrayTemp insertObject:fileName atIndex:0];
            
            [moviesArray removeObjectAtIndex:cellIndexPath.row];
            [self.tableViewMovies deleteRowsAtIndexPaths:@[cellIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
            
            ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
            [library writeVideoAtPathToSavedPhotosAlbum:[NSURL fileURLWithPath:DestPathTmp]
                                        completionBlock:^(NSURL *assetURL, NSError *error)
             {
                 if (error)
                 {
                     NSLog(@"writeVideoAtPathToSavedPhotosAlbum error: %@", error);
                 }
                 else
                 {
                     NSLog(@"writeVideoAtPathToSavedPhotosAlbum sccess");
                     
                     // 移除檔案
                     //NSLog(@"移除檔案:%@",DestPathTmp);
                     
                     // remove file
                     [[NSFileManager defaultManager] removeItemAtPath:DestPathTmp error:NULL];
                     
//                     if([moviesArrayTemp containsObject:fileName])
//                         [moviesArrayTemp removeObjectAtIndex:[moviesArrayTemp indexOfObject:fileName]];
                 }
             }];
            
            [cell hideUtilityButtonsAnimated:YES];
            
            break;
        }
        case 1:
        {
            // Delete button was pressed
            NSString *DestPath;
            NSString *DestPathTmp;
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                 NSUserDomainMask,
                                                                 YES);
            DestPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"MobRecord/"];
            NSIndexPath *cellIndexPath = [self.tableViewMovies indexPathForCell:cell];
            DestPathTmp = [DestPath stringByAppendingPathComponent:[moviesArray objectAtIndex:cellIndexPath.row]];
            NSLog(@"移除檔案:%@",DestPathTmp);
            [[NSFileManager defaultManager] removeItemAtPath:DestPathTmp error:NULL];
            [moviesArray removeObjectAtIndex:cellIndexPath.row];
            [self.tableViewMovies deleteRowsAtIndexPaths:@[cellIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
            
            break;
        }
        default:
            break;
    }
}
- (BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
#pragma mark
#pragma mark - 影片播放
- (void) playVideo:(NSString *)fileName {
    playerViewController = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL fileURLWithPath:fileName]];
    
    // 影片播放結束後，呼叫movieFinishedCallback
    [[NSNotificationCenter defaultCenter]   addObserver:self
                                               selector:@selector(movieFinishedCallback:)
                                                   name:MPMoviePlayerPlaybackDidFinishNotification
                                                 object:[playerViewController moviePlayer]];
    
    // 影片播放中Exit，呼叫movieFinishedCallback
    [[NSNotificationCenter defaultCenter]   addObserver:self
                                               selector:@selector(movieWillExitFullscreenCallback:)
                                                   name:MPMoviePlayerWillExitFullscreenNotification
                                                 object:[playerViewController moviePlayer]];
    
    
    //playerViewController.moviePlayer.movieSourceType = MPMovieSourceTypeStreaming;
    
    
    //[playVideoView addSubview:playerViewController.view];
    //[self.view addSubview:playVideoView];
    [self addSubview:playerViewController.view];
    
    MPMoviePlayerController * myPlayer = [playerViewController moviePlayer];
    myPlayer.fullscreen = YES;
    myPlayer.shouldAutoplay = YES;
    //myPlayer.view.transform = CGAffineTransformMakeRotation(1.5707964); // 旋轉90度
    
    myPlayer.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;//自動縮放符合畫面比例
    myPlayer.scalingMode = MPMovieScalingModeAspectFit; //設定影片比例的縮放
    
    
    myPlayer.repeatMode = MPMovieRepeatModeNone;//設定影片不重複參數、控制列等參數
    //myPlayer.repeatMode = MPMovieRepeatModeOne;
    myPlayer.controlStyle = MPMovieControlStyleDefault;//設定影片控制列等參數為預設值
    
    //play movie
    [myPlayer play];
}
- (void) movieWillExitFullscreenCallback:(NSNotification*) aNotification {
    MPMoviePlayerController * myPlayer = [aNotification object];
    
    [myPlayer.view setHidden:YES];
    
    myPlayer.fullscreen = NO;
    
    myPlayer.initialPlaybackTime = -1;
    [myPlayer pause];
    [myPlayer stop];
    
    
    
    [[NSNotificationCenter defaultCenter]   removeObserver:self
                                                      name:MPMoviePlayerWillExitFullscreenNotification
                                                    object:myPlayer];
    
    [UIView transitionWithView:self
                      duration:0.5
                       options:UIViewAnimationOptionTransitionCurlUp
                    animations:^{[myPlayer.view removeFromSuperview];}
                    completion:NULL];
    
}
- (void) movieFinishedCallback:(NSNotification*) aNotification {
    MPMoviePlayerController * myPlayer = [aNotification object];
    
    myPlayer.fullscreen = NO;
    
    myPlayer.initialPlaybackTime = -1;
    [myPlayer pause];
    [myPlayer stop];
    
    
    
    [[NSNotificationCenter defaultCenter]   removeObserver:self
                                                      name:MPMoviePlayerPlaybackDidFinishNotification
                                                    object:myPlayer];
    
    
    [UIView transitionWithView:self
                      duration:0.5
                       options:UIViewAnimationOptionTransitionCurlUp
                    animations:^{[myPlayer.view removeFromSuperview];}
                    completion:NULL];
    
}
- (void) hidden:(UIView*)view {
    [UIView transitionWithView:view
                      duration:0.5
                       options:UIViewAnimationOptionTransitionCurlUp
                    animations:^{[self setHidden:YES];}
                    completion:NULL];
}
- (void) show:(UIView*)view {
    [self.tableViewMovies reloadData];
    [UIView transitionWithView:view
                      duration:0.5
                       options:UIViewAnimationOptionTransitionCurlDown
                    animations:^{ [self setHidden:NO];}
                    completion:NULL];
}
- (void) updateAll {
    
}
- (void) updateMoviesTableViewFrame {
    NSString * removeAds = [NSString stringWithFormat:@"%@",[MRPlist readPlist:@"Setting" forkey:@"RemoveAds"]];
    UIView * uiTableView = (UIView*)[self viewWithTag:_TAG_MOVIESTABLE_VIEW_];
  
    
    CGRect uiTableViewFrame = uiTableView.frame;
    if ([removeAds isEqualToString:@"0"])
        uiTableViewFrame.origin.y = kGADAdSizeBanner.size.height;
    else
        uiTableViewFrame.origin.y = 0;
    [uiTableView setFrame:uiTableViewFrame];
}
@end
