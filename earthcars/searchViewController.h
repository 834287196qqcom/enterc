//
//  searchViewController.h
//  earthcars
//
//  Created by qianfeng on 15/7/4.
//  Copyright (c) 2015年 韩世民. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
@interface searchViewController : UIViewController
{
    AFHTTPRequestOperationManager *_manager;
    NSMutableArray *_dataArr;
}
@property (nonatomic,strong)UITableView *mytableView;
@property (nonatomic,strong)NSMutableArray *dataArr;

-(void)addTaskUrl:(NSString *)url;

@end
