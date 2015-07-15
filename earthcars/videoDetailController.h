//
//  videoDetailController.h
//  earthcars
//
//  Created by qianfeng on 15/7/10.
//  Copyright (c) 2015年 韩世民. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import <MediaPlayer/MediaPlayer.h>
@interface videoDetailController : UIViewController
{
    NSString *_videoAdd;
    MPMoviePlayerViewController *_mp;
}
@property(nonatomic,copy)NSString *videoAdd;

@end
