//
//  DetailViewController.h
//  earthcars
//
//  Created by qianfeng on 15/7/9.
//  Copyright (c) 2015年 韩世民. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "myModel.h"
#import "AFNetworking.h"
@interface DetailViewController : UIViewController
{
    
    AFHTTPRequestOperationManager *_manager;
    NSMutableArray *_dataArr;
  
}
@property (nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic,strong)myModel *model;
@property (nonatomic,copy)NSString *contentUrl;
@end
