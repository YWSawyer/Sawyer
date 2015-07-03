//
//  TuTabCell.m
//  ICViewPager
//
//  Created by lanou3g on 14-7-30.
//  Copyright (c) 2014年 Ilter Cengiz. All rights reserved.
//

#import "TuTabCell.h"

@implementation TuTabCell
- (void)dealloc
{
    self.imv = nil;
    self.nameLab = nil;
    self.countLab = nil;
}
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
        _imv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, gao)];
        _imv.contentMode = UIViewContentModeScaleToFill;
        
        [self addSubview:_imv];
    }
    return _imv;
}

- (UILabel *)nameLab
{
    if (_nameLab == nil) {
        _nameLab = [[UILabel alloc] initWithFrame:CGRectMake(5, gao-30, self.bounds.size.width*2/3+60, 20)];
        _nameLab.textColor = [UIColor whiteColor];
        _nameLab.font = [UIFont systemFontOfSize:14];
        _nameLab.textAlignment = NSTextAlignmentLeft;
        
        [self addSubview:_nameLab];
    }
    return _nameLab;
}

- (UILabel *)countLab
{
    if (_countLab == nil) {
        _countLab = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width - 90, gao-30, 80, 20)];
        _countLab.textAlignment = NSTextAlignmentRight;
        _countLab.textColor = [UIColor whiteColor];
        _countLab.font = [UIFont systemFontOfSize:14];
        
        [self addSubview:_countLab];
    }
    return _countLab;
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
