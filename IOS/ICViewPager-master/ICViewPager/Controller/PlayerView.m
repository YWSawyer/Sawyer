//
//  PlayerView.m
//  ICViewPager
//
//  Created by lanou3g on 14-7-22.
//  Copyright (c) 2014年 Ilter Cengiz. All rights reserved.
//

#import "PlayerView.h"

@implementation PlayerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)layoutSubviews
{
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    //判断当前方向是横屏还是竖屏
    if (UIInterfaceOrientationIsPortrait(orientation)) {
        //        NSLog(@"当前状态是竖屏");
        //吧视图上的元素位置与大小改为书评下样式
        
        
        _movie.view.frame = CGRectMake(0, 0, self.bounds.size.width,self.bounds.size.height);
        _movie.view.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
        
//        CGAffineTransform trabsform = CGAffineTransformMakeRotation(M_PI/2);
//        [_movie.view setTransform:trabsform];
    }else{
        //        NSLog(@"当前是横屏");
        _movie.view.frame = CGRectMake(0, 0,self.bounds.size.width,self.bounds.size.height);
    }
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
