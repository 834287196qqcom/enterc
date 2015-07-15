//
//  conditionViewCell.h
//  earthcars
//
//  Created by qianfeng on 15/7/8.
//  Copyright (c) 2015年 韩世民. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "myModel.h"
@interface conditionViewCell : UITableViewCell
{
    UILabel *titleLabel;
    UIImageView *imageView;
    UILabel *typeLabel;
    UILabel *priceLabel;
}
-(void)showDataWithModel:(myModel *)model;
@end
