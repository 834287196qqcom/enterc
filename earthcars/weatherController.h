//
//  weatherController.h
//  earthcars
//
//  Created by qianfeng on 15/7/10.
//  Copyright (c) 2015年 韩世民. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
@interface weatherController : UIViewController
{
    UITableView *_mytableView;
    NSMutableArray *_dataArr;
    AFHTTPRequestOperationManager *_manager;
}
@property (nonatomic,strong)UITableView *mytableView;
@property (nonatomic,strong)NSMutableArray *dataArr;
@end
