//
//  SubFindController.m
//  ICViewPager
//
//  Created by lanou3g on 14-7-31.
//  Copyright (c) 2014年 Ilter Cengiz. All rights reserved.
//

#import "SubFindController.h"
#import "FinColectionView.h"
#import "FindCell.h"
#import "ListCar.h"
#import "UIImageView+WebCache.h"
#import "RecipeCollectionView.h"
#import "MBProgressHUD.h"
@interface SubFindController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIGestureRecognizerDelegate>
{
    MBProgressHUD *HUD;
}
@property (nonatomic, strong) FinColectionView *rootVC;

@property (nonatomic, strong) NSMutableArray *keyArr;
@property (nonatomic, strong) NSMutableDictionary *dic;

@end
static NSString *cell_ID = @"cell_ID";
static NSString *cell_header = @"cell_header";
@implementation SubFindController
- (void)dealloc
{
    self.rootVC = nil;
    self.keyArr = nil;
    self.dic = nil;
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
    self.rootVC = [[FinColectionView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.view = _rootVC;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _rootVC.collectionView.dataSource = self;
    _rootVC.collectionView.delegate = self;
    
    [_rootVC.collectionView registerClass:[FindCell class] forCellWithReuseIdentifier:cell_ID];
    [_rootVC.collectionView registerClass:[RecipeCollectionView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:cell_header];
    [self  getData:_strr];
    // Do any additional setup after loading the view.
}

- (void)getData:(NSString *)str
{
    _keyArr = nil;
    _dic = nil;
    self.keyArr = [NSMutableArray array];
    self.dic = [NSMutableDictionary dictionary];
    NSString *urlStr = [NSString stringWithFormat:@"http://app.api.autohome.com.cn/autov4.0/cars/pics-a2-pm2-v4.0.2-ss65-sp%@-cg0-cl0-p1-s60.html",str];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:80];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSDictionary *dic1 = dict[@"result"];
            
            NSArray *arr = dic1[@"defaultpiclist"];
            
            for (NSDictionary *dic2 in arr) {
                NSString *key = dic2[@"name"];
                [_keyArr addObject:key];
                NSArray *ar1 = dic2[@"list"];
                NSMutableArray *carAr = [NSMutableArray array];
                for (NSDictionary *dic3 in ar1) {
                    ListCar *car = [[ListCar alloc] init];
                    car.imgUrl = dic3[@"smallpic"];
                    car.name = dic3[@"specname"];
                    [carAr addObject:car];
                }
                [_dic setObject:carAr forKey:key];
            }
            [self.rootVC.collectionView reloadData];
        }
    }];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return _keyArr.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSString *key = _keyArr[section];
    NSArray *arr = _dic[key];
    return arr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *key = _keyArr[indexPath.section];
    NSArray *arr = _dic[key];
    
    FindCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cell_ID forIndexPath:indexPath];
    if (!cell) {
        cell = [[FindCell alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    }
    ListCar *car = arr[indexPath.row];
    [cell.imView setImageWithURL:[NSURL URLWithString:car.imgUrl]];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(80, 60);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    RecipeCollectionView *ive = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:cell_header forIndexPath:indexPath];
    if (!ive) {
        ive = [[RecipeCollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 30)];
        
    }
    ive.backgroundColor = [UIColor colorWithRed:234.0/255.0 green:230.0/255.0 blue:231.0/255.0 alpha:1.0];
    ive.label.text = _keyArr[indexPath.section];
    
    return ive;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(self.view.bounds.size.width, 30);
}



- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 30, 10);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *key = _keyArr[indexPath.section];
    NSArray *arr = _dic[key];
//    ListCar *car = arr[indexPath.row];
//
//    NSString *str = [NSString stringWithFormat:@"%@",car.imgUrl];
//    
//    str = [str stringByReplacingOccurrencesOfString:@"s_" withString:@"w_"];
//    NSURL *url = [NSURL URLWithString:str];
//    UIImageView *ima = [[UIImageView alloc] init];
//    ima.frame = self.view.bounds;
//    ima.contentMode = UIViewContentModeScaleAspectFit;
//    [ima setImageWithURL:url];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeAction:)];
//
    tap.numberOfTapsRequired = 2;
   
    
    UIScrollView *vew = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    vew.contentSize = CGSizeMake(arr.count*self.view.bounds.size.width, self.view.bounds.size.height);
    int i = 0;
    for (ListCar *car in arr) {
        NSString *str1 = [NSString stringWithFormat:@"%@",car.imgUrl];
        
        str1 = [str1 stringByReplacingOccurrencesOfString:@"s_" withString:@"w_"];
        NSURL *url1 = [NSURL URLWithString:str1];
        UIImageView *imageV = [[UIImageView alloc] init];
        [imageV setImageWithURL:url1 placeholderImage:[UIImage imageNamed:@"101"]];
        imageV.frame = CGRectMake(self.view.bounds.size.width*i, 0, self.view.bounds.size.width, self.view.bounds.size.height);
        imageV.contentMode = UIViewContentModeScaleAspectFit;
        
        i ++;
        [vew addSubview:imageV];
        vew.pagingEnabled = YES;

//        [vew addGestureRecognizer:tap];

    }
    vew.contentOffset = CGPointMake(indexPath.row*self.view.bounds.size.width, 0);
//    [self.view addSubview:vew];
    
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor blackColor];
    
    [view addSubview:vew];
    [view addGestureRecognizer:tap];
   
    view.tag = 1100;
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    
    [self.view addSubview:view];
//

}


- (void)removeAction:(UIPanGestureRecognizer *)sender
{
    UIView *ive = [self.view viewWithTag:1100];
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = NO;
    [ive removeFromSuperview];
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
