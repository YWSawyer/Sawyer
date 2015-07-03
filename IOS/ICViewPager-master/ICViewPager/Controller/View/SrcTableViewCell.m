//
//  SrcTableViewCell.m
//  ICViewPager
//
//  Created by lanou3g on 14-7-21.
//  Copyright (c) 2014年 Ilter Cengiz. All rights reserved.
//

#import "SrcTableViewCell.h"
#import "CHCarHandle.h"
@implementation SrcTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (UIScrollView *)src
{
    if (_src == nil) {
        _src = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 150)];
        [self.contentView addSubview:_src];
        _src.userInteractionEnabled = YES;
        _src.directionalLockEnabled = YES;
        NSArray *arr = [CHCarHandle sharedHandle].carDic[@"最新"];
        NSArray *a = arr[0];
        _src.contentSize = CGSizeMake(self.bounds.size.width*(a.count+1), 150);
    }
    return _src;
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
