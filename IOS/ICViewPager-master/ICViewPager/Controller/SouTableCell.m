//
//  SouTableCell.m
//  ICViewPager
//
//  Created by lanou3g on 14-7-29.
//  Copyright (c) 2014年 Ilter Cengiz. All rights reserved.
//

#import "SouTableCell.h"

@implementation SouTableCell

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
        _ima = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, self.bounds.size.width/3, 60)];
        _ima.contentMode = UIViewContentModeScaleAspectFit;
        
        [self addSubview:_ima];
    }
    return _ima;
}
- (UILabel *)labName
{
    if (!_labName) {
        _labName = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width/3 + 10, 5, self.bounds.size.width/2, 30)];
        _labName.textAlignment = NSTextAlignmentLeft;
        
        [self addSubview:_labName];
    }
    return _labName;
}
- (UILabel *)PreLab
{
    if (!_PreLab) {
        _PreLab = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width/3 + 10, 35, self.bounds.size.width/2, 30)];
        _PreLab.textAlignment = NSTextAlignmentLeft;
        _PreLab.textColor = [UIColor orangeColor];
        
        [self addSubview:_PreLab];
    }
    return _PreLab;
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
