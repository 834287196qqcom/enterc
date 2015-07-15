//
//  searchPaiZiViewController.h
//  earthcars
//
//  Created by qianfeng on 15/7/9.
//  Copyright (c) 2015年 韩世民. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "paiziCell.h"
@interface searchPaiZiViewController : UIViewController
{
    UITableView *_mytableView;
    NSMutableArray *_dataArr;
    AFHTTPRequestOperationManager *_manager;
    NSString *_abc;
    BOOL _isRefresh;
    BOOL _isLoadMore;
    
    NSInteger _name;
}
@property(nonatomic)NSInteger name;
@property (nonatomic,strong)UITableView *mytableView;
@property (nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic) BOOL isRefresh;
@property (nonatomic) BOOL isLoadMore;

@property (nonatomic)NSString *abc;


-(void)addTaskUrl:(NSString *)url;
@end
