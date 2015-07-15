//
//  favoriteCell.h
//  earthcars
//
//  Created by qianfeng on 15/7/10.
//  Copyright (c) 2015年 韩世民. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "myModel.h"
@interface favoriteCell : UITableViewCell
{
    UIImageView *_imageView;
    UILabel *_titleLabel;
    UILabel *_commentLabel;
    UILabel *_pushLabel;
    UILabel *_isnoLabel;
}
-(void)showDataWithModel:(myModel *)model;

@end
