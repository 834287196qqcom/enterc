//
//  conditionController.h
//  earthcars
//
//  Created by qianfeng on 15/7/8.
//  Copyright (c) 2015年 韩世民. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
@interface conditionController : UIViewController
{
    NSString *_low;
    NSString *_height;
    
    UITableView *_mytableView;
    NSMutableArray *_dataArr;
    AFHTTPRequestOperationManager *_manager;
    BOOL _isRefresh;
    BOOL _isLoadMore;
    NSInteger currentPage;
    
    int from;
    int to;
}
@property (nonatomic)int from;
@property (nonatomic)int to;
@property(nonatomic,copy)NSString *low;
@property(nonatomic,copy)NSString *height;

@property (nonatomic,strong)UITableView *mytableView;
@property (nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic) BOOL isRefresh;
@property (nonatomic) BOOL isLoadMore;
@property (nonatomic)NSInteger currentPage;
@end
