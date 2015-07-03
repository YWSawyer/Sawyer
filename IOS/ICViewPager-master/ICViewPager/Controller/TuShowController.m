//
//  TuShowController.m
//  ICViewPager
//
//  Created by lanou3g on 14-7-30.
//  Copyright (c) 2014年 Ilter Cengiz. All rights reserved.
//

#import "TuShowController.h"
#import "MBProgressHUD.h"
#import "TuCollectView.h"
#import "TucollectCell.h"
#import "TuManger.h"
#import "ListCar.h"
#import "UIImageView+WebCache.h"
@interface TuShowController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    MBProgressHUD *HUD;
    
}

@property (nonatomic, strong) TuCollectView *rootView;

@end
static NSString *cell_id = @"cell_id";
@implementation TuShowController
- (void)dealloc
{
    self.rootView = nil;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    self.rootView = [[TuCollectView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.view = _rootView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    //    HUD.delegate = self;
    HUD.labelText = @"Loading";
    HUD.square = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tabBarController.tabBar.hidden = YES;
    
    [HUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];

    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshAction) name:TuShow object:nil];
    _rootView.collectionView.delegate = self;
    _rootView.collectionView.dataSource = self;
    
    [_rootView.collectionView registerClass:[TucollectCell class] forCellWithReuseIdentifier:cell_id];
    

    
    
    // Do any additional setup after loading the view.
}

- (void)myTask
{
    sleep(3);
}
- (void)refreshAction
{
    [self.rootView.collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [TuManger defaultsManger].tuArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TucollectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cell_id forIndexPath:indexPath];
    if (!cell) {
        cell = [[TucollectCell alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    }
    ListCar *car = [TuManger defaultsManger].tuArr[indexPath.row];
    

    [cell.imav setImageWithURL:[NSURL URLWithString:car.imgUrl] placeholderImage:[UIImage imageNamed:@"101"]];
    
    return cell;
}
- (void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.bounds.size.width, 150);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 100;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 150;
}


//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    UICollectionViewCell *selectedCell =  [collectionView  cellForItemAtIndexPath:indexPath];
//    
//    //类似淡入淡出效果的动画效果，    cell的awakeFromNib是在加载时会调用的初始化（在cell是xib文件时）
//    [UIView animateWithDuration:1.2 animations:^{
//        selectedCell.alpha = 0.0f;  //透明
//    } completion:^(BOOL finished) {
//        [UIView animateWithDuration:1.2 animations:^{
//            selectedCell.alpha = 1.0f;
//        }];
//    }];
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *selectedCell = [collectionView  cellForItemAtIndexPath :indexPath];
    [UIView animateWithDuration:1.2 animations:^{
        selectedCell.transform = CGAffineTransformMakeScale(2.0f, 2.0f);    //放大，参数：宽高缩放比例
    }];
}

- (void)collectionView:(UICollectionView *)collectionView  didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *selectedCell =  [collectionView  cellForItemAtIndexPath:indexPath];
    [UIView animateWithDuration:1.2 animations:^{
        selectedCell.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
    }];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
