//
//  BaseViewController.h
//  earthcars
//
//  Created by qianfeng on 15/7/3.
//  Copyright (c) 2015年 韩世民. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
@interface BaseViewController : UIViewController
{
    UITableView *_mytableView;
    UIScrollView *_myscrollView;
    NSMutableArray *_dataArr;
    NSMutableArray *_PicArr;
    AFHTTPRequestOperationManager *_manager;
    NSInteger _currentPage;
    BOOL _isRefresh;
    BOOL _isLoadMore;
}
@property (nonatomic,strong)UITableView *mytableView;
@property (nonatomic,strong)UIScrollView *myscrollView;
@property (nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic,strong)NSMutableArray *PicArr;

@property (nonatomic) BOOL isRefresh;
@property (nonatomic) BOOL isLoadMore;
@property (nonatomic)NSInteger currentPage;

-(void)addTaskUrl:(NSString *)url;

-(void)creatView;
-(void)creatRefresh;
-(void)endRefresh;

@end
