//
//  SowRootView.m
//  ICViewPager
//
//  Created by lanou3g on 14-7-28.
//  Copyright (c) 2014年 Ilter Cengiz. All rights reserved.
//

#import "SowRootView.h"

@implementation SowRootView
- (void)dealloc
{
    self.collectionView = nil;
    self.collectionViewFlowLayout = nil;
}
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
    self.collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    _collectionViewFlowLayout.itemSize = CGSizeMake(80, 30);
    _collectionViewFlowLayout.minimumInteritemSpacing = 20;
    _collectionViewFlowLayout.minimumLineSpacing = 20;
    _collectionViewFlowLayout.sectionInset = UIEdgeInsetsMake(10, 15, 10, 15);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:_collectionViewFlowLayout];
    _collectionView.contentMode = UIViewContentModeScaleAspectFit;
    _collectionView.allowsMultipleSelection = YES;
    
    _collectionView.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240./255.0 blue:240.0/255.0 alpha:1.0];
//    _collectionView.backgroundColor = [UIColor whiteColor];
    
    [_collectionView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    
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
