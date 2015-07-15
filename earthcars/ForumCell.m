//
//  ForumCell.m
//  earthcars
//
//  Created by qianfeng on 15/7/5.
//  Copyright (c) 2015年 韩世民. All rights reserved.
//

#import "ForumCell.h"

@implementation ForumCell

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
    _pushLabel = [MyControl creatLabelWithFrame:CGRectMake(kScreenSize.width/4+10+10, 60, kScreenSize.width/3, 20) text:@""];
    [self.contentView addSubview:_pushLabel];
    
     _lastreplydateLabel = [MyControl creatLabelWithFrame:CGRectMake(kScreenSize.width-kScreenSize.width/4, 60, kScreenSize.width/3, 20) text:@""];
    [self.contentView addSubview:_lastreplydateLabel];
}
-(void)showDataWithModel:(myModel *)model{
    [_imageView sd_setImageWithURL:[NSURL URLWithString:model.smallpic] placeholderImage:[UIImage imageNamed:@"subscription_bg_night.jpg"]];
    
    _titleLabel.text = model.title;
    _titleLabel.font = [UIFont systemFontOfSize:14];

    [_titleLabel setNumberOfLines:2];
    
    if ([[model.bbsname substringToIndex:4]  isEqual: @"行车点评"]) {
        NSString *subStr = [model.bbsname substringFromIndex:5];
        NSString *stbStr2 = [NSString stringWithFormat:@"车有话说 %@",subStr];
         _pushLabel.text = stbStr2;
    }else if([[model.bbsname substringToIndex:4]  isEqual: @"海外购车"]){
        NSString *subStr = [model.bbsname substringFromIndex:5];
        NSString *stbStr2 = [NSString stringWithFormat:@"进口汽车 %@",subStr];
        _pushLabel.text = stbStr2;
    }else{
        NSString *subStr = [model.bbsname substringFromIndex:5];
        NSString *stbStr2 = [NSString stringWithFormat:@"高端汽车 %@",subStr];
        _pushLabel.text = stbStr2;
    }
    
    
   
    _pushLabel.font = [UIFont systemFontOfSize:10];
    _lastreplydateLabel.text = model.lastreplydate;
    _lastreplydateLabel.font = [UIFont systemFontOfSize:10];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
