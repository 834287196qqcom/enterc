//
//  nowCell.h
//  earthcars
//
//  Created by qianfeng on 15/7/4.
//  Copyright (c) 2015年 韩世民. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "myModel.h"
@interface nowCell : UITableViewCell
{
    UIImageView *_imageView;
    UILabel *_titleLabel;
    UILabel *_pushLabel;
    UILabel *_zbtime;
    UILabel *_comLabel;
}

-(void)showDataWithModel:(myModel *)model;
@end
