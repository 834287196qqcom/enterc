//
//  searchBarCell.h
//  earthcars
//
//  Created by qianfeng on 15/7/10.
//  Copyright (c) 2015年 韩世民. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "myModel.h"
@interface searchBarCell : UITableViewCell
{
    UILabel *_keywordLabel;
    UILabel *_priceLabel;
    UILabel *_sidLabel;
}

-(void)showDataWithModel:(myModel *)model;
@end
