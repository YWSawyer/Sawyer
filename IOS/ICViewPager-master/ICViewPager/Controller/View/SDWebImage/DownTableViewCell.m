//
//  DownTableViewCell.m
//  ICViewPager
//
//  Created by lanou3g on 14-7-22.
//  Copyright (c) 2014年 Ilter Cengiz. All rights reserved.
//

#import "DownTableViewCell.h"

@implementation DownTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (UIImageView *)imageV
{
    if (_imageV == nil) {
        _imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width/3, 70)];
        
        _imageV.contentMode = UIViewContentModeScaleAspectFit;
        
        [self addSubview:_imageV];
    }
    return _imageV;
}

- (UILabel *)titleLab
{
    if (_titleLab == nil) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width/3 + 10, 0, self.bounds.size.width*2/3-15, 50)];
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.font = [UIFont boldSystemFontOfSize:17];
        _titleLab.numberOfLines = 0;
        [self addSubview:_titleLab];
        
    }
    return _titleLab;
}

- (UILabel *)disparityLab
{
    if (_disparityLab == nil) {
        _disparityLab = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width/3 + 10, 50, 120, 20)];
        _disparityLab.font = [UIFont systemFontOfSize:15];
        _disparityLab.textAlignment = NSTextAlignmentLeft;
        _disparityLab.textColor = [UIColor redColor];
        [self addSubview:_disparityLab];
    }
    return _disparityLab;
}

- (UILabel *)presentLab
{
    if (_presentLab == nil) {
        _presentLab = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width-120, 55, 110, 30)];
        _presentLab.font = [UIFont boldSystemFontOfSize:13];
        _presentLab.textColor = [UIColor orangeColor];
        _presentLab.textAlignment = NSTextAlignmentRight;
        
        [self addSubview:_presentLab];
    }
    return _presentLab;
}

- (UILabel *)areaLab
{
    if (_areaLab == nil) {
        _areaLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 80, 40, 20)];
        _areaLab.font = [UIFont systemFontOfSize:10];
        [self addSubview:_areaLab];
    }
    return _areaLab;
}


- (UILabel *)shouLab
{
    if (_shouLab == nil) {
        _shouLab = [[UILabel alloc] initWithFrame:CGRectMake(55, 80, 40, 20)];
        _shouLab.font = [UIFont systemFontOfSize:10];
        [self addSubview:_shouLab];
    }
    return _shouLab;
}

- (UIImageView *)ima
{
    if (_ima == nil) {
        _ima = [[UIImageView alloc] initWithFrame:CGRectMake(100, 80, 50, 20)];
        _ima.contentMode = UIViewContentModeScaleAspectFit;
        
        [self addSubview:_ima];
    }
    return _ima;
}
- (UILabel *)addressLab
{
    if (_addressLab == nil) {
        _addressLab = [[UILabel alloc] initWithFrame:CGRectMake(160, 80, 120, 20)];
        _addressLab.textColor = [UIColor redColor];
        _addressLab.font = [UIFont systemFontOfSize:13];
        [self addSubview:_addressLab];
    }
    return _addressLab;
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
