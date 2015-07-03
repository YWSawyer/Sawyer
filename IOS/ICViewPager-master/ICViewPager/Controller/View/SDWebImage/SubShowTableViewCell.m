//
//  SubShowTableViewCell.m
//  ICViewPager
//
//  Created by lanou3g on 14-7-24.
//  Copyright (c) 2014年 Ilter Cengiz. All rights reserved.
//

#import "SubShowTableViewCell.h"

@implementation SubShowTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (UIImageView *)imv
{
    if (_imv == nil) {
        _imv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 48, self.bounds.size.width, 150)];
        _imv.contentMode = UIViewContentModeScaleAspectFill;
        
        [self.contentView addSubview:_imv];
    }
    return _imv;
}

- (UILabel *)textLab
{
    if (_textLab == nil) {
        _textLab = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_imv.bounds)+60, self.bounds.size.width/3, 20)];
        _textLab.font = [UIFont systemFontOfSize:15];
        _textLab.textAlignment = NSTextAlignmentLeft;
        _textLab.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_textLab];
    }
    return _textLab;
}

- (UILabel *)rigtLab
{
    if (_rigtLab == nil) {
        _rigtLab = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width/3+10, CGRectGetMaxY(_imv.bounds)+60, self.bounds.size.width*2/3-20, 20)];
        _rigtLab.font = [UIFont systemFontOfSize:15];
        _rigtLab.textAlignment = NSTextAlignmentRight;
        _rigtLab.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_rigtLab];
    }
    return _rigtLab;
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
