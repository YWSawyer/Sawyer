//
//  MyCollectiongCell.m
//  ICViewPager
//
//  Created by lanou3g on 14-7-28.
//  Copyright (c) 2014年 Ilter Cengiz. All rights reserved.
//

#import "MyCollectiongCell.h"

@implementation MyCollectiongCell
- (void)dealloc
{
    self.labe = nil;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (UILabel *)labe
{
    if (_labe == nil) {
        _labe = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
        _labe.textAlignment = NSTextAlignmentCenter;
        _labe.backgroundColor = [UIColor whiteColor];
        _labe.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_labe];
    }
    return _labe;
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
