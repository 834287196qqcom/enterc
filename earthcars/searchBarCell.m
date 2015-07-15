//
//  searchBarCell.m
//  earthcars
//
//  Created by qianfeng on 15/7/10.
//  Copyright (c) 2015年 韩世民. All rights reserved.
//

#import "searchBarCell.h"

@implementation searchBarCell

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
  
    _keywordLabel = [MyControl creatLabelWithFrame:CGRectMake(10, 10, kScreenSize.width/3, 20) text:@""];
    [self.contentView addSubview:_keywordLabel];
    
    _priceLabel = [MyControl creatLabelWithFrame:CGRectMake(10,30 , kScreenSize.width/3, 20) text:@""];
    [self.contentView addSubview:_priceLabel];
    
    _sidLabel = [MyControl creatLabelWithFrame:CGRectMake(10, 50, kScreenSize.width/3, 20) text:@""];
    [self.contentView addSubview:_sidLabel];
    
}
-(void)showDataWithModel:(myModel *)model{
   
    _keywordLabel.text = model.keyword;
    _keywordLabel.font = [UIFont systemFontOfSize:14];
    NSLog(@"%@",model.keyword);
    _priceLabel.text = model.price;
    _priceLabel.font = [UIFont systemFontOfSize:13];
    _priceLabel.textColor = [UIColor redColor];
    
    _sidLabel.text = model.sid;
    _sidLabel.font = [UIFont systemFontOfSize:11];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
