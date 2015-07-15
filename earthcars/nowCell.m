//
//  nowCell.m
//  earthcars
//
//  Created by qianfeng on 15/7/4.
//  Copyright (c) 2015年 韩世民. All rights reserved.
//

#import "nowCell.h"
#import "MyControl.h"
@implementation nowCell

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
    _imageView = [MyControl creatImageViewWithFrame:CGRectMake(10, 0, kScreenSize.width-20, kScreenSize.height/4) imageName:nil];
    [self.contentView addSubview:_imageView];
    
    _titleLabel = [MyControl creatLabelWithFrame:CGRectMake(10, kScreenSize.height/4,kScreenSize.width-20, 30) text:nil];
    [self.contentView addSubview:_titleLabel];
    
    UIImageView *myview = [MyControl creatImageViewWithFrame:CGRectMake(10, kScreenSize.height/4+30, 15, 15) imageName:nil];
    myview.image = [UIImage imageNamed:@"infor_live_channel_live_end_icon"];
    [self.contentView addSubview:myview];
    
    _zbtime = [MyControl creatLabelWithFrame:CGRectMake(40, kScreenSize.height/4+10, 50, 50) text:@""];
    [self.contentView addSubview:_zbtime];
    
    UIImageView *myview1 = [MyControl creatImageViewWithFrame:CGRectMake(kScreenSize.width/3, kScreenSize.height/4+30, 15, 15) imageName:nil];
    myview1.image = [UIImage imageNamed:@"infor_live_channel_time_icon"];
    [self.contentView addSubview:myview1];
    
    _pushLabel = [MyControl creatLabelWithFrame:CGRectMake(kScreenSize.width/3+30, kScreenSize.height/4+10, kScreenSize.width/2, 50) text:@""];
    [self.contentView addSubview:_pushLabel];
    
    UIImageView *myview2 = [MyControl creatImageViewWithFrame:CGRectMake(kScreenSize.width-kScreenSize.width/4, kScreenSize.height/4+30, 15, 15) imageName:nil];
    myview2.image = [UIImage imageNamed:@"infor_live_channel_comment_icon"];
    [self.contentView addSubview:myview2];
    
    _comLabel = [MyControl creatLabelWithFrame:CGRectMake(kScreenSize.width-kScreenSize.width/5, kScreenSize.height/4+10, 50, 50) text:@""];
    [self.contentView addSubview:_comLabel];
    
}
-(void)showDataWithModel:(myModel *)model{
    _titleLabel.text = model.titile;
    
    _titleLabel.font = [UIFont systemFontOfSize:15];
    
    if ([model.zbState  isEqual: @"0"]) {
        _zbtime.text = @"已结束";
    }else{
    _zbtime.text = @"正在直播";
    }
    _zbtime.font = [UIFont systemFontOfSize:10];
    
    [_imageView sd_setImageWithURL:[NSURL URLWithString:model.banner]];
    _pushLabel.text = model.zbTime;
    _pushLabel.font = [UIFont systemFontOfSize:10];
    _comLabel.text = model.cmtCount.stringValue;
    _comLabel.font = [UIFont systemFontOfSize:10];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
