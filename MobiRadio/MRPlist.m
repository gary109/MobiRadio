//
//  MRPlist.m
//  MobRecorder
//
//  Created by GarY on 2014/8/20.
//  Copyright (c) 2014年 GarY WanG. All rights reserved.
//

#import "MRPlist.h"

@implementation MRPlist
+ (NSString*) readPlist:(NSString*)fileName forkey:(NSString*)key {
    //建立一個 Dictionary
    NSMutableDictionary *plistDictionary;
    
    //初始化路徑
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains
                          (NSDocumentDirectory,NSUserDomainMask, YES)
                          objectAtIndex:0];
    
    //rootPath = [rootPath stringByAppendingPathComponent:@"MobRecord/"];
    
    //取得 plist 檔路徑
    NSString *plistName = [fileName stringByAppendingString:@".plist"];
    NSString *plistPath = [rootPath stringByAppendingPathComponent:plistName];
    NSLog(@"%@ plist path:%@",fileName,plistPath);
    
    //[[NSFileManager defaultManager] removeItemAtPath:plistPath error:NULL];
    
    //如果 Documents 文件夾中沒有 test.plist 的話，則從 project 目錄中载入 test.plist
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath])
    {
        plistPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
    }
    //將取得的 plist 內容載入至剛才建立的 Dictionary 中
    plistDictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    
    //利用 NSLog 來查看剛才取得的 plist 檔的內容
    NSLog(@"%@ plist:%@",fileName,plistDictionary);
    
    if([plistDictionary objectForKey:key] == nil)
    {
        plistPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
    }
    //將取得的 plist 內容載入至剛才建立的 Dictionary 中
    plistDictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    
    //利用 NSLog 來查看剛才取得的 plist 檔的內容
    NSLog(@"%@ plist:%@",fileName,plistDictionary);
    
    return [plistDictionary objectForKey:key];
}


+ (void) writePlist:(NSString*)fileName forkey:(NSString*)key content:(NSString*) content{
    //先從取出開始
    //建立一個 Dictionary
    NSMutableDictionary *plistDictionary;
    
    //初始化路徑
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains
                          (NSDocumentDirectory,NSUserDomainMask, YES)
                          objectAtIndex:0];
    
    //rootPath = [rootPath stringByAppendingPathComponent:@"MobRecord/"];
    
    //取得 plist 檔路徑
    NSString *plistName = [fileName stringByAppendingString:@".plist"];
    NSString *plistPath = [rootPath stringByAppendingPathComponent:plistName];
    NSLog(@"%@ plist path:%@",fileName,plistPath);
    
    //如果 Documents 文件夾中沒有 test.plist 的話，則從 project 目錄中载入 test.plist
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath])
    {
        plistPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
    }
    
    //將取得的 plist 內容載入至剛才建立的 Dictionary 中
    plistDictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    
    //利用 NSLog 來查看剛才取得的 plist 檔的內容
    NSLog(@"%@ plist:%@",fileName,plistDictionary);
    
    //接荖我們來試著修改其內容
    [plistDictionary setObject:content forKey:key];
    
    //再利用 NSLog 來查看剛才修改的 Dictionary
    NSLog(@"%@ plist:%@",fileName,plistDictionary);
    
    //取得儲存路徑
    NSString *SaveRootPath = [NSSearchPathForDirectoriesInDomains
                              (NSDocumentDirectory,NSUserDomainMask, YES)
                              objectAtIndex:0];
    
    NSString *SavePath = [SaveRootPath stringByAppendingPathComponent:plistName];
    NSLog(@"Save %@.plist path:%@",fileName,SavePath);
    
    //將 Dictionary 儲存至指定的檔案
    [plistDictionary writeToFile:SavePath atomically:YES];
}

@end
