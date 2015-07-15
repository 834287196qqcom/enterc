//
//  seartypeCell.m
//  earthcars
//
//  Created by qianfeng on 15/7/7.
//  Copyright (c) 2015年 韩世民. All rights reserved.
//

#import "seartypeCell.h"

@implementation seartypeCell

- (void)awakeFromNib {
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self creatUI];
    }
    return self;
}
-(void)creatUI{
    _titleLabel = [MyControl creatLabelWithFrame:CGRectMake(10, 10, kScreenSize.width, 20) text:@""];
    [self.contentView addSubview:_titleLabel];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
