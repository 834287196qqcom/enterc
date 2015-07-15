//
//  paiziCell.m
//  earthcars
//
//  Created by qianfeng on 15/7/9.
//  Copyright (c) 2015年 韩世民. All rights reserved.
//

#import "paiziCell.h"
#import "UIImageView+WebCache.h"
@implementation paiziCell

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
    priceRange = [MyControl creatLabelWithFrame:CGRectMake(kScreenSize.width/4+20,30 , kScreenSize.width/3, 20) text:@""];
    [self.contentView addSubview:priceRange];
    
    kindLabel = [MyControl creatLabelWithFrame:CGRectMake(kScreenSize.width/4+20, 50, kScreenSize.width/3, 20) text:@""];
    [self.contentView addSubview:kindLabel];
    
}
-(void)showDataWithModel:(myModel *)model{
    [imageView sd_setImageWithURL:[NSURL URLWithString:model.photo] placeholderImage:[UIImage imageNamed:@"subscription_bg_night.jpg"]];
    titleLabel.text = model.name;
    titleLabel.font = [UIFont systemFontOfSize:14];
    priceRange.text = model.priceRange;
    priceRange.font = [UIFont systemFontOfSize:13];
    priceRange.textColor = [UIColor redColor];
    
    kindLabel.text = model.kind;
    kindLabel.font = [UIFont systemFontOfSize:11];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
