//
//  TuCollectView.m
//  ICViewPager
//
//  Created by lanou3g on 14-7-30.
//  Copyright (c) 2014年 Ilter Cengiz. All rights reserved.
//

#import "TuCollectView.h"

@implementation TuCollectView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self addAllView];
    }
    return self;
}
- (void)addAllView
{
    self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    _flowLayout.itemSize = CGSizeMake(150, 150);
    _flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 100, 0);
    _flowLayout.minimumLineSpacing = 20;
    _flowLayout.minimumInteritemSpacing = 50;
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:_flowLayout];
    _collectionView.contentMode = UIViewContentModeScaleAspectFit;
    
    [_collectionView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    _collectionView.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:_collectionView];
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
