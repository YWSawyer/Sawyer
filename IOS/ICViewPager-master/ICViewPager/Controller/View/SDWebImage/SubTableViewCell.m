//
//  SubTableViewCell.m
//  ICViewPager
//
//  Created by lanou3g on 14-7-23.
//  Copyright (c) 2014年 Ilter Cengiz. All rights reserved.
//

#import "SubTableViewCell.h"

@implementation SubTableViewCell
- (void)dealloc
{
    self.imaV = nil;
    self.labe = nil;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (UIImageView *)imaV
{
    if (_imaV == nil) {
        _imaV = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, self.bounds.size.width/3, 70)];
        _imaV.contentMode = UIViewContentModeScaleAspectFit;
        
        [self.contentView addSubview:_imaV];
    }
    return _imaV;
}

- (UILabel *)labe
{
    if (_labe == nil) {
        _labe = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width/3 + 10, 5, self.bounds.size.width/3, 40)];
        _labe.font = [UIFont boldSystemFontOfSize:15];
        _labe.numberOfLines = 0;
        
        [self.contentView addSubview:_labe];
    }
    return _labe;
}

- (UILabel *)priceLab
{
    if (_priceLab == nil) {
        _priceLab = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width/3 + 10, 50, self.bounds.size.width*2/3-25, 20)];
        _priceLab.font = [UIFont systemFontOfSize:13];
        _priceLab.textColor = [UIColor orangeColor];
        _priceLab.textAlignment = NSTextAlignmentLeft;
        
        [self.contentView addSubview:_priceLab];
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
