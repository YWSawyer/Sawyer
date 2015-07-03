//
//  FineViewController.m
//  ICViewPager
//
//  Created by lanou3g on 14-7-23.
//  Copyright (c) 2014年 Ilter Cengiz. All rights reserved.
//

#import "FineViewController.h"
#import "TowTableViewController.h"
#import "SubViewController.h"
#import "CarManger.h"
#import "SubShowController.h"
@interface FineViewController ()
@property (nonatomic, strong) TowTableViewController *towTabVC;
@property (nonatomic, strong) SubViewController *subTalVC;

@end

@implementation FineViewController
- (void)dealloc
{
    self.towTabVC = nil;
    self.subTalVC = nil;
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

    UIImageView *ima = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"汽车之家app_r1_c2"]];
    ima.frame = CGRectMake(0, 0, 80, 40);
    ima.contentMode = UIViewContentModeScaleAspectFit;
    
    UIBarButtonItem *lifeBarButton = [[UIBarButtonItem alloc] initWithCustomView:ima];
    self.navigationItem.leftBarButtonItem = lifeBarButton;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SelcetAction:) name:FindViewControllerSelectAction object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ditalAction:) name:SubViewControllerSeclected object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shouhui) name:@"shouhui" object:nil];
    
    self.towTabVC = [[TowTableViewController alloc] initWithStyle:UITableViewStylePlain];
    _towTabVC.tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-64);
    
    [self.view addSubview:_towTabVC.view];
    [self addChildViewController:_towTabVC];
    
    
    
    
    // Do any additional setup after loading the view.
}

- (void)shouhui
{
    [UIView animateWithDuration:.75 delay:0.01 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        _towTabVC.tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-64);
        
        _subTalVC.view.center = CGPointMake(self.view.bounds.size.width*3/2, self.view.center.y+32);
    } completion:^(BOOL finished) {
//        [_subTalVC.view removeFromSuperview];
    }];
    
}

- (void)ditalAction:(NSNotification *)notification
{
    NSDictionary *dict = [notification userInfo];
    NSString *str = dict[@"str"];
    SubShowController *subShow = [[SubShowController alloc] initWithStyle:UITableViewStylePlain];

    subShow.str = str;
    [self.navigationController pushViewController:subShow animated:YES];
}



- (void)viewWillDisappear:(BOOL)animated
{
    [_subTalVC.view removeFromSuperview];
    
    
    _towTabVC.tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-64);
    _subTalVC.view = nil;
    _subTalVC.view.frame = CGRectMake(0, 0, 0, 0);
    
    [_subTalVC removeFromParentViewController];
}

- (void)SelcetAction:(NSNotification *)notification
{
    NSDictionary *dic = [notification userInfo];
    NSString *str = dic[@"CarID"];
    [[CarManger defaultManger] FindCar:str];
//    _towTabVC.tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width/4, self.view.bounds.size.height-64);
    if (_subTalVC == nil) {
        
        self.subTalVC = [[SubViewController alloc] init];
        
    }
    
    
        _subTalVC.view.frame = CGRectMake(self.view.bounds.size.width/5, 64, self.view.bounds.size.width*4/5, self.view.bounds.size.height-64);
        _towTabVC.tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width/5, self.view.bounds.size.height-64);
        
        _subTalVC.stri = str;
        [self.view addSubview:_subTalVC.view];
        [self addChildViewController:_subTalVC];
//    [[NSNotificationCenter defaultCenter] postNotificationName:FindcarIsShowing object:nil];


    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
