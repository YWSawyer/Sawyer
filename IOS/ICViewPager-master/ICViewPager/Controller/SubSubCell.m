//
//  SubSubCell.m
//  ICViewPager
//
//  Created by lanou3g on 14-7-29.
//  Copyright (c) 2014年 Ilter Cengiz. All rights reserved.
//

#import "SubSubCell.h"

@implementation SubSubCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (UIImageView *)ima
{
    if (!_ima) {
        _ima = [[UIImageView alloc] initWithFrame:CGRectMake(2, 5, self.bounds.size.width/3, 80)];
        _ima.contentMode = UIViewContentModeScaleAspectFit;
        
        [self addSubview:_ima];
    }
    return _ima;
}
- (UILabel *)labName
{
    if (!_labName) {
        _labName = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width/3 + 5, 5, self.bounds.size.width*2/3-10, 50)];
        _labName.textAlignment = NSTextAlignmentLeft;
        _labName.font = [UIFont boldSystemFontOfSize:15];
        _labName.numberOfLines = 0;
        
        [self addSubview:_labName];
    }
    return _labName;
}
- (UILabel *)PreLab
{
    if (!_PreLab) {
        _PreLab = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width/3 + 5, 55, self.bounds.size.width/3, 30)];
        _PreLab.textAlignment = NSTextAlignmentLeft;
        _PreLab.font = [UIFont systemFontOfSize:12];
        _PreLab.numberOfLines = 0;
        [self addSubview:_PreLab];
    }
    return _PreLab;
}

- (UILabel *)priceLab
{
    if (!_priceLab) {
        _priceLab = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width - 80 , 55, 70, 30)];
        _priceLab.textAlignment = NSTextAlignmentRight;
        _priceLab.textColor = [UIColor orangeColor];
        _priceLab.font = [UIFont systemFontOfSize:13];
        [self addSubview:_priceLab];
    }
    return _priceLab;
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
