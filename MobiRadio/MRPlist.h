//
//  MRPlist.h
//  MobRecorder
//
//  Created by GarY on 2014/8/20.
//  Copyright (c) 2014年 GarY WanG. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MRPlist : NSObject


+ (void) writePlist:(NSString*)fileName forkey:(NSString*)key content:(NSString*) content;
+ (NSString*) readPlist:(NSString*)fileName forkey:(NSString*)key;

@end
