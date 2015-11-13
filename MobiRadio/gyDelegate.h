//
//  gyDelegate.h
//  MobRecorder
//
//  Created by GarY on 2014/8/1.
//  Copyright (c) 2014年 GarY WanG. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol gyDelegate <NSObject>

@optional

// About System
- (float) getVolumeLevel;

// About GPS
- (double) GetLatitude;
- (double) GetLongitude;
- (double) GetHeading;
- (double) GetSpeed;

// About ALAssetsLibrary
- (void) CreateGroupAlbum:(NSString*)groupName;
- (void) iPhotoEnumerator;

// About file management
- (void) clearDirContentAll:(NSString*)dirName;
- (NSDate *)getFileCreationDate:(NSString *)fileName;
- (NSString *)findEarlierCreationDateAtFolder:(NSString *)dirName;
- (NSString *) saveVideoFile:(NSString *)fileName;
- (void) fileEnumerator:(NSString*)dirName;
- (void) createDir:(NSString *)dirName;
- (void) wrPlist;
- (void) moveDirContentToLibrary:(NSString*)dirName;

// About Battery
-(void) updateBatteryImage;

// About Map View
-(void) updateTrackingInfoViewFrame;
-(void) updateMapViewUnit;

// About About View
-(void) showAboutView;
-(void) hiddenAboutView;


- (void) exchangeView:(BOOL)animation;

// About MovieesTableView
-(void) updateMoviesTableViewFrame;
-(void) showMoviesTableView;
-(void) hiddenMoviesTableView;
-(void) addTableViewItem:(NSString*)filename;
-(void) playAudio:(NSString*)uri;


// About Setting View
-(void) showSettingView;
-(void) hiddenSettingView;
-(void) updateSettingViewFrame;

// About Menu View
-(void) showMenuView;
-(void) hiddenMenuView;

// About Store View
-(void) showStoreView;
-(void) hiddenStoreView;

-(void) removeAdmob;

- (void) method1:(NSString*)value1;
- (void) method2:(NSString*)value2;

// About ScreenLock View
- (BOOL) isScreenLock;
- (void) setScreenLock:(BOOL)sw;
- (void) showScreenLockView;
- (void) hiddenScreenLockView;
@end