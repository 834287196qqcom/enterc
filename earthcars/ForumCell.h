//
//  ForumCell.h
//  earthcars
//
//  Created by qianfeng on 15/7/5.
//  Copyright (c) 2015年 韩世民. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "myModel.h"
@interface ForumCell : UITableViewCell
{
    UIImageView *_imageView;
    UILabel *_titleLabel;
    UILabel *_pushLabel;
    UILabel *_lastreplydateLabel;
}
-(void)showDataWithModel:(myModel *)model;

@end
