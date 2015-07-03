//
//  CHMyTabCell.m
//  QICheZhiJia
//
//  Created by lanou3g on 14-7-19.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "CHMyTabCell.h"

#define k_d 80
#define g_d 30
#define g_j 60
@implementation CHMyTabCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (UIImageView *)imView
{
    if (_imView == nil) {
        _imView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, self.bounds.size.width/3, 70)];
        _imView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_imView];
    }
    return _imView;
}

- (UILabel *)lable
{
    if (_lable == nil) {
        _lable = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width/3 + 10, 0, self.bounds.size.width*2/3-20, 60)];
        _lable.numberOfLines = 0;
        _lable.font = [UIFont systemFontOfSize:17];
        _lable.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_lable];
    }
    return _lable;
}

- (UILabel *)timeLab
{
    if (_timeLab == nil) {
        _timeLab = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width/3 + 10, g_j, k_d, g_d)];
        _timeLab.numberOfLines = 0;
        _timeLab.font = [UIFont systemFontOfSize:12];
        [self addSubview:_timeLab];
    }
    return _timeLab;
}

- (UILabel *)playedLab
{
    if (_playedLab == nil) {
        _playedLab = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width-90, g_j, k_d, g_d)];
        _playedLab.textAlignment = NSTextAlignmentRight;
        _playedLab.font = [UIFont systemFontOfSize:12];
        
        [self addSubview:_playedLab];
    }
    return _playedLab;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
