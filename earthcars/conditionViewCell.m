//
//  conditionViewCell.m
//  earthcars
//
//  Created by qianfeng on 15/7/8.
//  Copyright (c) 2015年 韩世民. All rights reserved.
//

#import "conditionViewCell.h"
#import "UIImageView+WebCache.h"
@implementation conditionViewCell

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
    imageView = [MyControl creatImageViewWithFrame:CGRectMake(5, 5, kScreenSize.width/4, 60) imageName:nil];
    [self.contentView addSubview:imageView];
    titleLabel = [MyControl creatLabelWithFrame:CGRectMake(kScreenSize.width/4+20, 10, kScreenSize.width/3, 20) text:@""];
    [self.contentView addSubview:titleLabel];
    priceLabel = [MyControl creatLabelWithFrame:CGRectMake(kScreenSize.width/4+20,30 , kScreenSize.width/3, 20) text:@""];
    [self.contentView addSubview:priceLabel];
    
    typeLabel = [MyControl creatLabelWithFrame:CGRectMake(kScreenSize.width/4+20, 50, kScreenSize.width/3, 20) text:@""];
    [self.contentView addSubview:typeLabel];
    
}
-(void)showDataWithModel:(myModel *)model{
    [imageView sd_setImageWithURL:[NSURL URLWithString:model.photo] placeholderImage:[UIImage imageNamed:@"subscription_bg_night.jpg"]];
    titleLabel.text = model.name;
    titleLabel.font = [UIFont systemFontOfSize:14];
    priceLabel.text = model.prices;
    priceLabel.font = [UIFont systemFontOfSize:13];
    priceLabel.textColor = [UIColor redColor];
    
    typeLabel.text = model.kind;
    typeLabel.font = [UIFont systemFontOfSize:11];
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
