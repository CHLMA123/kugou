//
//  ListTableViewCell.m
//  kugou
//
//  Created by MCL on 16/6/30.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "ListTableViewCell.h"

@implementation ListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = CLEARCOLOR;
        self.textLabel.textColor = [UIColor whiteColor];
        self.textLabel.font  = [UIFont systemFontOfSize:17];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    //NSLog(@"rect :%@",NSStringFromCGRect(self.imageView.frame));
    self.imageView.frame = CGRectMake(25, 0, 32, 32);
    self.imageView.center = CGPointMake(self.imageView.centerX, self.textLabel.centerY);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
