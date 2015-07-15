//
//  paiziCell.h
//  earthcars
//
//  Created by qianfeng on 15/7/9.
//  Copyright (c) 2015年 韩世民. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "myModel.h"
@interface paiziCell : UITableViewCell
{
    UILabel *titleLabel;
    UIImageView *imageView;
    UILabel *kindLabel;
    UILabel *priceRange;
}

-(void)showDataWithModel:(myModel *)model;

@end
