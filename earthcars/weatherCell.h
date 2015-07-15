//
//  weatherCell.h
//  earthcars
//
//  Created by qianfeng on 15/7/10.
//  Copyright (c) 2015年 韩世民. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "myModel.h"
@interface weatherCell : UITableViewCell
{
    UILabel *currentCityLabel;
    UILabel *dateLabel;
    UIImageView *dayPictureUrlLabel;
    UILabel *weatherLabel;
    UILabel *windLabel;
    UILabel *temperatureLabel;
}
-(void)showDataWithModel:(myModel *)model;

@end
