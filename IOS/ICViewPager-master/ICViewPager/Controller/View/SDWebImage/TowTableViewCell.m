//
//  TowTableViewCell.m
//  ICViewPager
//
//  Created by lanou3g on 14-7-23.
//  Copyright (c) 2014年 Ilter Cengiz. All rights reserved.
//

#import "TowTableViewCell.h"

@implementation TowTableViewCell
- (void)dealloc
{
    self.imagV = nil;
    self.lab = nil;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (UIImageView *)imagV
{
    if (_imagV == nil) {
        _imagV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 50, 40)];
        _imagV.contentMode = UIViewContentModeScaleAspectFit;
        
        [self.contentView addSubview:_imagV];
    }
    return _imagV;
}

- (UILabel *)lab
{
    if (_lab == nil) {
        _lab = [[UILabel alloc] initWithFrame:CGRectMake(65, 2, 80, 30)];
        _lab.font = [UIFont systemFontOfSize:14];
        _lab.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_lab];
    }
    return _lab;
    
}


- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
