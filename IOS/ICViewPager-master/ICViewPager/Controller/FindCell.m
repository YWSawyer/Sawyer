//
//  FindCell.m
//  ICViewPager
//
//  Created by lanou3g on 14-7-31.
//  Copyright (c) 2014年 Ilter Cengiz. All rights reserved.
//

#import "FindCell.h"

@implementation FindCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (UIImageView *)imView
{      if (_imView == nil) {
    _imView = [[UIImageView alloc]init];
    _imView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.width);
    _imView.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.contentView addSubview:_imView];
}
    return _imView;
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
