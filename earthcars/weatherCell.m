//
//  weatherCell.m
//  earthcars
//
//  Created by qianfeng on 15/7/10.
//  Copyright (c) 2015年 韩世民. All rights reserved.
//

#import "weatherCell.h"

@implementation weatherCell

- (void)awakeFromNib {
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatUI];
    }
    return self;
}
-(void)creatUI{
/*
 UILabel *currentCityLabel;
 UILabel *dateLabel;
 UILabel *dayPictureUrlLabel;
 UILabel *weatherLabel;
 UILabel *windLabel;
 UILabel *temperatureLabel;
 */
    currentCityLabel = [MyControl creatLabelWithFrame:CGRectMake(kScreenSize.width/3, 10, kScreenSize.width/10, 30) text:@""];
    [self.contentView addSubview:currentCityLabel];
    
    dateLabel = [MyControl creatLabelWithFrame:CGRectMake(kScreenSize.width/3, 40, kScreenSize.width/2, 30) text:@""];
    [self.contentView addSubview:dateLabel];
    dayPictureUrlLabel = [MyControl creatImageViewWithFrame:CGRectMake(kScreenSize.width/3, 70, 50, 50) imageName:@""];
    [self.contentView addSubview:dayPictureUrlLabel];
    weatherLabel = [MyControl creatLabelWithFrame:CGRectMake(kScreenSize.width/3, 120, kScreenSize.width/2, 20) text:@""];
    [self.contentView addSubview:weatherLabel];
    windLabel = [MyControl creatLabelWithFrame:CGRectMake(kScreenSize.width/3, 140, kScreenSize.width/2, 20) text:@""];
    [self.contentView addSubview:windLabel];
    temperatureLabel = [MyControl creatLabelWithFrame:CGRectMake(kScreenSize.width/3, 160, kScreenSize.width/2, 20) text:@""];
    [self.contentView addSubview:temperatureLabel];
}
-(void)showDataWithModel:(myModel *)model{
    currentCityLabel.text = model.currentCity;
    currentCityLabel.font = [UIFont systemFontOfSize:15];
    
    dateLabel.text = model.date;
    [dayPictureUrlLabel sd_setImageWithURL:[NSURL URLWithString:model.dayPictureUrl] placeholderImage:[UIImage imageNamed:@"infor_live_channel_live_end_icon"]];
    
    weatherLabel.text = model.weather;
    windLabel.text = model.wind;
    temperatureLabel.text = model.temperature;
    
    NSLog(@"%@",model.kind);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
