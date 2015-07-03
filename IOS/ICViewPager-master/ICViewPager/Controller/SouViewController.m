//
//  SouViewController.m
//  ICViewPager
//
//  Created by lanou3g on 14-7-28.
//  Copyright (c) 2014年 Ilter Cengiz. All rights reserved.
//

#import "SouViewController.h"
#import "SowRootView.h"
#import "Car.h"
#import "MyCollectiongCell.h"
#import "RecipeCollectionView.h"
#import "SouCarModel.h"
#import "MBProgressHUD.h"
@interface SouViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,MBProgressHUDDelegate>

{
    MBProgressHUD *HUD;
}

@property (nonatomic, strong) SowRootView *rootView;
@property (nonatomic, strong) NSMutableArray *keyArr;
@property (nonatomic, strong) NSMutableArray *arr;
@property (nonatomic, strong) NSMutableDictionary *dic;
@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, strong) NSMutableArray *IndArr;
@end

static NSString *cell_id = @"cell_id";
static NSString *cell_ID = @"cell_ID";

@implementation SouViewController

- (void)dealloc
{
    self.rootView = nil;
    self.keyArr   = nil;
    self.arr      = nil;
    self.dic      = nil;
    self.IndArr   = nil;

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
    self.rootView = [[SowRootView alloc] initWithFrame:[UIScreen mainScreen].bounds];
   
    self.view = _rootView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    _rootView.collectionView.delegate = self;
    _rootView.collectionView.dataSource = self;
    
    [_rootView.collectionView registerClass:[MyCollectiongCell class] forCellWithReuseIdentifier:cell_id];
    [_rootView.collectionView registerClass:[RecipeCollectionView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:cell_ID];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushLabel:) name:SouCarModelTotal object:nil];
    
    self.IndArr = [NSMutableArray array];
    
    // Do any additional setup after loading the view.
}

- (void)pushLabel:(NSNotification *)notification
{
    NSDictionary *dic = [notification userInfo];
    NSString *str = [NSString stringWithFormat:@"%@",dic[@"total"]];;
    
    if ([str isEqualToString:@"0"]) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(15, self.view.bounds.size.height - 100, self.view.bounds.size.width - 30, 50);
        [button setTitle:[NSString stringWithFormat:@"没有找到符合条件的车"] forState:0];
        button.backgroundColor = [UIColor cyanColor];
        [_rootView addSubview:button];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            sleep(2);
            dispatch_async(dispatch_get_main_queue(), ^{
                [button removeFromSuperview];
            });
        });
    } else {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(15, self.view.bounds.size.height - 100, self.view.bounds.size.width - 30, 50);
        button.backgroundColor = [UIColor cyanColor];
        [button setTitle:[NSString stringWithFormat:@"%@款符合条件的车,点击查看",str] forState:0];
        button.tag = 1010;
        [button addTarget:self action:@selector(pushAction) forControlEvents:UIControlEventTouchUpInside];
        [_rootView addSubview:button];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            sleep(4);
            dispatch_async(dispatch_get_main_queue(), ^{
                [button removeFromSuperview];
            });
        });
    }
    
}

- (void)pushAction
{
    NSMutableString *str1;
    NSMutableString *str2;
    NSMutableString *str3;
    NSMutableString *str4;
    for (NSIndexPath *indexs in _IndArr) {
        NSString *key = [SouCarModel sharedHanle].keyArr[indexs.section];
        NSArray *arr = [SouCarModel sharedHanle].dic[key];
        Car *car = arr[indexs.row];
        if (indexs.section == 0) {
            str1 = [NSMutableString stringWithFormat:@"%@",car.Id];
        }
        if (indexs.section == 1) {
            str2 = [NSMutableString stringWithFormat:@"%@",car.Id];
        }
        if (indexs.section == 2) {
            str3 = [NSMutableString stringWithFormat:@"%@",car.Id];
        }
        if (indexs.section == 3) {
            str4 = [NSMutableString stringWithFormat:@"%@",car.Id];
        }
    }
    [[SouCarModel sharedHanle] GetDataCarWithPrice:str1 withJb:str2 withPl:str3 withGbox:str4];
    for (NSIndexPath *ind in _IndArr) {
        MyCollectiongCell *cell = (MyCollectiongCell *)[_rootView.collectionView cellForItemAtIndexPath:ind];
        cell.layer.borderWidth = 0;
        cell.labe.textColor = [UIColor blackColor];
        [_rootView.collectionView deselectItemAtIndexPath:ind animated:YES];
    }
    [_IndArr removeAllObjects];
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate = self;
    HUD.labelText = @"Loading";
    HUD.square = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [HUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];

}
- (void)myTask
{
    
}
- (void)viewDidDisappear:(BOOL)animated
{
    UIButton *but = (UIButton *)[self.view viewWithTag:1010];
    [but removeFromSuperview];
    for (NSIndexPath *ind in _IndArr) {
        MyCollectiongCell *cell = (MyCollectiongCell *)[_rootView.collectionView cellForItemAtIndexPath:ind];
        cell.layer.borderWidth = 0;
        cell.labe.textColor = [UIColor blackColor];
        [_rootView.collectionView deselectItemAtIndexPath:ind animated:YES];
    }
    [_IndArr removeAllObjects];
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSString *str = [SouCarModel sharedHanle].keyArr[section];
    NSArray *arr = [SouCarModel sharedHanle].dic[str];
//    NSString *str = _keyArr[section];
//    NSArray *arr = _dic[str];
    
    return arr.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [SouCarModel sharedHanle].keyArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str = [SouCarModel sharedHanle].keyArr[indexPath.section];
    NSArray *arr = [SouCarModel sharedHanle].dic[str];
    
    
    MyCollectiongCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cell_id forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[MyCollectiongCell alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    }
    

    BOOL isshowing = NO;
    for (NSIndexPath *indexPath1 in _IndArr) {
        if (indexPath == indexPath1) {
            isshowing = YES;
        }
    }
    
    
    if (isshowing == NO) {
        cell.layer.borderWidth = 0;
        cell.labe.textColor = [UIColor blackColor];
    }else{
        cell.layer.borderWidth = 2;
        cell.layer.borderColor = [UIColor blueColor].CGColor;
        cell.labe.textColor = [UIColor blueColor];
    }

    Car *a = arr[indexPath.row];

    cell.labe.text = a.name;
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    RecipeCollectionView *ive = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:cell_ID forIndexPath:indexPath];
    if (!ive) {
        ive = [[RecipeCollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 30)];
        
    }
    ive.backgroundColor = [UIColor colorWithRed:234.0/255.0 green:230.0/255.0 blue:231.0/255.0 alpha:1.0];
    ive.label.text = [SouCarModel sharedHanle].keyArr[indexPath.section];
    
    return ive;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(self.view.bounds.size.width, 30);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
  
    MyCollectiongCell *cell = (MyCollectiongCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    cell.layer.borderWidth = 2.0;
    cell.layer.borderColor = [UIColor blueColor].CGColor;
    cell.labe.textColor = [UIColor blueColor];
    
    NSMutableArray *a = [NSMutableArray array];
    for (NSIndexPath *ind in _IndArr) {
        if (indexPath.section == ind.section) {
            MyCollectiongCell *cell = (MyCollectiongCell *)[_rootView.collectionView cellForItemAtIndexPath:ind];
            cell.layer.borderWidth = 0;
            cell.labe.textColor = [UIColor blackColor];
            [_rootView.collectionView deselectItemAtIndexPath:ind animated:YES];
            
            [a addObject:ind];
        }
        
    }
    
    [_IndArr removeObjectsInArray:a];
    [_IndArr addObject:indexPath];
    NSMutableString *str1;
    NSMutableString *str2;
    NSMutableString *str3;
    NSMutableString *str4;
    for (NSIndexPath *indexs in _IndArr) {
        NSString *key = [SouCarModel sharedHanle].keyArr[indexs.section];
        NSArray *arr = [SouCarModel sharedHanle].dic[key];
        Car *car = arr[indexs.row];
        if (indexs.section == 0) {
            str1 = [NSMutableString stringWithFormat:@"%@",car.Id];
        }
        if (indexs.section == 1) {
            str2 = [NSMutableString stringWithFormat:@"%@",car.Id];
        }
        if (indexs.section == 2) {
            str3 = [NSMutableString stringWithFormat:@"%@",car.Id];
        }
        if (indexs.section == 3) {
            str4 = [NSMutableString stringWithFormat:@"%@",car.Id];
        }
    }
    [[SouCarModel sharedHanle] getTotalPrice:str1 withJb:str2 wirhPl:str3 withGbox:str4];

}


- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyCollectiongCell *cell = (MyCollectiongCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [_IndArr removeObject:indexPath];
    cell.layer.borderWidth = 0.0;
    cell.labe.textColor = [UIColor blackColor];

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
