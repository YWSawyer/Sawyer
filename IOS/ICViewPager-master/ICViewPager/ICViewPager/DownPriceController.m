//
//  DownPriceController.m
//  ICViewPager
//
//  Created by lanou3g on 14-7-24.
//  Copyright (c) 2014年 Ilter Cengiz. All rights reserved.
//

#import "DownPriceController.h"
#import "DownPriceTableViewController.h"
#import "DownAraeController.h"
#import "DownShowViewController.h"
#import "MoController.h"
@interface DownPriceController ()
@property (nonatomic, strong) DownPriceTableViewController *DownPriceVC;
@property (nonatomic, strong) DownAraeController *downAraeVC;
@property (nonatomic, assign) BOOL isAreaShowing;
@property (nonatomic, strong) UIBarButtonItem *barBut1;
@property (nonatomic, strong) UIBarButtonItem *barBut2;
@property (nonatomic, strong) UIBarButtonItem *barBut3;
@property (nonatomic, strong) DownShowViewController *DownShowVC;
@property (nonatomic, strong) MoController *mVC;
@property (nonatomic, assign) BOOL isMShowing;
@end

#define BlueColoer [UIColor colorWithRed:16.0/255.0 green:55.0/255.0 blue:111.0/255.0 alpha:10]
@implementation DownPriceController
- (void)dealloc
{
    self.downAraeVC = nil;
    self.DownPriceVC = nil;
    self.barBut1 = nil;
    self.barBut2 = nil;
    self.barBut3 = nil;
    self.mVC = nil;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
} 

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.barBut2 = [[UIBarButtonItem alloc] initWithTitle:@"地区" style:UIBarButtonItemStylePlain target:self action:@selector(areaAction)];
    _barBut2.tintColor = BlueColoer;
    
    self.barBut3 = [[UIBarButtonItem alloc] initWithTitle:@"品牌" style:UIBarButtonItemStylePlain target:self action:@selector(boardAction)];
    _barBut3.tintColor = BlueColoer;
    
    UIImageView *ima = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"汽车之家app_r1_c2"]];
    ima.frame = CGRectMake(0, 0, 80, 40);
    ima.contentMode = UIViewContentModeScaleAspectFit;

    UIBarButtonItem *lifeBarButton = [[UIBarButtonItem alloc] initWithCustomView:ima];
    self.navigationItem.leftBarButtonItem = lifeBarButton;
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeColor) name:AreaChange object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushAction:) name:DownPriceControllerPush object:nil];
    
    NSArray *actionButtonItems = @[_barBut2,_barBut3];
    
    self.navigationItem.rightBarButtonItems = actionButtonItems;
    
    
    

    self.DownPriceVC = [[DownPriceTableViewController alloc] initWithStyle:UITableViewStylePlain];
    _DownPriceVC.tableView.frame = self.view.bounds;
    
    [self.view addSubview:_DownPriceVC.view];
    [self addChildViewController:_DownPriceVC];
    // Do any additional setup after loading the view.
}

- (void)pushAction:(NSNotification *)notfiction
{
    self.DownShowVC = [[DownShowViewController alloc] init];
    NSDictionary *dic = [notfiction userInfo];
    
    Car *car = dic[@"str"];
    _DownShowVC.car = car;
    
    [self.navigationController pushViewController:_DownShowVC animated:YES];
    
}

- (void)changeColor
{
    self.isAreaShowing = NO;
    self.isMShowing = NO;
    _barBut2.tintColor = BlueColoer;
    _barBut3.tintColor = BlueColoer;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)areaAction
{
    [_mVC.tableView removeFromSuperview];
    _barBut3.tintColor = BlueColoer;
    self.isMShowing = NO;

    if (!self.isAreaShowing) {
        _barBut2.tintColor = [UIColor redColor];
        self.isAreaShowing = YES;
        if (_downAraeVC == nil) {
            self.downAraeVC = [[DownAraeController alloc] initWithStyle:UITableViewStylePlain];
        }
        _downAraeVC.tableView.frame = CGRectMake(self.view.bounds.size.width*1/3, 64, self.view.bounds.size.width*2/3, self.view.bounds.size.height-114);
        
        [self.view addSubview:_downAraeVC.tableView];
        [self addChildViewController:_downAraeVC];
        
    }else{
        [_downAraeVC.tableView removeFromSuperview];
        [_downAraeVC removeFromParentViewController];
        self.isAreaShowing = NO;
        _barBut2.tintColor = BlueColoer;
    }
    
    
}
- (void)boardAction
{
    [_downAraeVC.tableView removeFromSuperview];
    _barBut2.tintColor = BlueColoer;
    self.isAreaShowing = NO;

    if (!self.isMShowing) {
        _barBut3.tintColor = [UIColor redColor];
        self.isMShowing = YES;
        if (_mVC == nil) {
            self.mVC = [[MoController alloc] initWithStyle:UITableViewStylePlain];
        }
        _mVC.tableView.frame = CGRectMake(self.view.bounds.size.width/3, 64, self.view.bounds.size.width*2/3, self.view.bounds.size.height-114);
//        [self.view addSubview:_downAraeVC.tableView];
        [self.view addSubview:_mVC.tableView];
        [self addChildViewController:_mVC];
    } else {
        [_mVC.tableView removeFromSuperview];
        [_mVC removeFromParentViewController];
        self.isMShowing = NO;
        _barBut3.tintColor = BlueColoer;
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [_downAraeVC.tableView removeFromSuperview];
    [_downAraeVC removeFromParentViewController];
    [_mVC.tableView removeFromSuperview];
    [_mVC removeFromParentViewController];
    self.isAreaShowing = NO;
    self.isMShowing = NO;
    _barBut2.tintColor = BlueColoer;
    _barBut3.tintColor = BlueColoer;
    

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
