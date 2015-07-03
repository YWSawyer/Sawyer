//
//  TucollectCell.m
//  ICViewPager
//
//  Created by lanou3g on 14-7-30.
//  Copyright (c) 2014年 Ilter Cengiz. All rights reserved.
//

#import "TucollectCell.h"

@implementation TucollectCell
- (void)dealloc
{
    self.nameLab = nil;
    self.imav = nil;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (UIImageView *)imav
{
    if (_imav == nil) {
        _imav = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.width)];
        _imav.contentMode = UIViewContentModeScaleAspectFit;
        
        [self.contentView addSubview:_imav];
    }
    return _imav;
}

- (UILabel *)nameLab
{
    if (_nameLab == nil) {
        _nameLab = [[UILabel alloc] initWithFrame:CGRectMake(0, self.bounds.size.height, self.bounds.size.width, 20)];
        _nameLab.textAlignment = NSTextAlignmentCenter;
        _nameLab.font = [UIFont systemFontOfSize:11];
        
        [self.contentView addSubview:_nameLab];
    }
    return _nameLab;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
