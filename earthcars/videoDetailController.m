//
//  videoDetailController.m
//  earthcars
//
//  Created by qianfeng on 15/7/10.
//  Copyright (c) 2015年 韩世民. All rights reserved.
//

#import "videoDetailController.h"


@interface videoDetailController ()



@end

@implementation videoDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self playMovieWithFile:self.videoAdd];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void)playMovieWithFile:(NSString *)path{
    if (path.length == 0) {
        return;
    }
    NSURL *url = [NSURL URLWithString:path];
    _mp = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
    _mp.moviePlayer.shouldAutoplay = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playBack:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    [self presentViewController:_mp animated:YES completion:nil];
}
- (void)playBack:(NSNotification *)nf {
    [_mp dismissViewControllerAnimated:YES completion:nil];
    [_mp.moviePlayer stop];
    _mp = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
}

@end
