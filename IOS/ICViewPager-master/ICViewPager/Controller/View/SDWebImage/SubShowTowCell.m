 //
//  SubShowTowCell.m
//  ICViewPager
//
//  Created by lanou3g on 14-7-24.
//  Copyright (c) 2014年 Ilter Cengiz. All rights reserved.
//

#import "SubShowTowCell.h"

@implementation SubShowTowCell
- (void)dealloc
{
    self.nameLa = nil;
    self.priceLa = nil;
    self.descripLa = nil;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (UILabel *)nameLa
{
    if (_nameLa == nil) {
        _nameLa = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, self.bounds.size.width-20, 30)];
        _nameLa.font = [UIFont boldSystemFontOfSize:17];
        _nameLa.numberOfLines = 0;
        _nameLa.textAlignment = NSTextAlignmentLeft;
        
        [self.contentView addSubview:_nameLa];
    }
    return _nameLa;
}

- (UILabel *)priceLa
{
    if (_priceLa == nil) {
        _priceLa = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width-140, 40, 130, 30)];
        _priceLa.textColor = [UIColor orangeColor];
        _priceLa.font = [UIFont boldSystemFontOfSize:15];
        _priceLa.textAlignment = NSTextAlignmentRight;
        
        [self.contentView addSubview:_priceLa];
    }
    return _priceLa;
}

- (UILabel *)descripLa
{
    if (_descripLa == nil) {
        _descripLa = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, 130, 30)];
        _descripLa.textAlignment = NSTextAlignmentLeft;
        _descripLa.font = [UIFont systemFontOfSize:13];
        
        [self.contentView addSubview:_descripLa];
    }
    return _descripLa;
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
