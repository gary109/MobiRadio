//
//  MRTableView.h
//  MobRecorder
//
//  Created by GarY on 2014/9/3.
//  Copyright (c) 2014年 GarY WanG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AVFoundation/AVFoundation.h"
#import "gyDelegate.h"
#import "ALDisk.h"
#import "MRPlist.h"
#import "SWTableViewCell.h"
#import <MediaPlayer/MediaPlayer.h>
#import "GADBannerView.h"

//<<Can delete if not storing videos to the photo library.  Delete the assetslibrary framework too requires this)
#import <AssetsLibrary/AssetsLibrary.h>

@interface MRTableView : UIView <UITableViewDelegate, UITableViewDataSource, SWTableViewCellDelegate, gyDelegate>
{
    bool contentCreated;
    NSMutableArray *moviesArray;//, *moviesArrayTemp;
    NSMutableArray *moviesArray1;//, *moviesArrayTemp;
    UITableView *tableViewMovies;
    id <gyDelegate> delegate;
}
@property (nonatomic, assign) id<gyDelegate> gydelegate;
@property (nonatomic,strong) UITableView *tableViewMovies;
@property (nonatomic,retain) NSMutableArray *moviesArray;//, *moviesArrayTemp;
@property (nonatomic,retain) NSMutableArray *moviesArray1;//, *moviesArrayTemp;
- (void) updateAll;
- (void) updateMoviesTableViewFrame;
- (void) hidden:(UIView*)view;
- (void) show:(UIView*)view;
@end
