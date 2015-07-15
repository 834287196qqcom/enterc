//
//  FirstCell.m
//  earthcars
//
//  Created by qianfeng on 15/7/4.
//  Copyright (c) 2015年 韩世民. All rights reserved.
//

#import "FirstCell.h"

@implementation FirstCell

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
    _imageView = [MyControl creatImageViewWithFrame:CGRectMake(10, 10, kScreenSize.width/4, 60) imageName:nil];
    [self.contentView addSubview:_imageView];
    _titleLabel  = [MyControl creatLabelWithFrame:CGRectMake(kScreenSize.width/4+10+10,10 , kScreenSize.width-kScreenSize.width/3, 40) text:@""];
    [self.contentView addSubview:_titleLabel];
    _commentLabel = [MyControl creatLabelWithFrame:CGRectMake(kScreenSize.width/4+10+10, 60, kScreenSize.width/3, 20) text:@""];
    [self.contentView addSubview:_commentLabel];
    _pushLabel  = [MyControl creatLabelWithFrame:CGRectMake(kScreenSize.width-kScreenSize.width/4, 60, kScreenSize.width/3, 20) text:@""];
    [self.contentView addSubview:_pushLabel];
}

-(void)showDataWithModel:(myModel *)model{
    [_imageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"subscription_bg_night.jpg"]];
    _titleLabel.text = model.title;
    _titleLabel.font = [UIFont systemFontOfSize:14];
    //_titleLabel.numberOfLines = 2;
    [_titleLabel setNumberOfLines:2];
    
    if (model.cmtCount.intValue == 0) {
        _commentLabel.text = @"抢沙发";
    }else{
     _commentLabel.text = [NSString stringWithFormat:@"%@ 评论",model.cmtCount];
    }
    _commentLabel.font =[UIFont systemFontOfSize:12];
    
    _pushLabel.text = model.pubDate;
    _pushLabel.font = [UIFont systemFontOfSize:12];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
