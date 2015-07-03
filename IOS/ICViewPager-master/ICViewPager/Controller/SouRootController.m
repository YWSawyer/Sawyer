//
//  SouRootController.m
//  ICViewPager
//
//  Created by lanou3g on 14-7-29.
//  Copyright (c) 2014年 Ilter Cengiz. All rights reserved.
//

#import "SouRootController.h"
#import "SouCarModel.h"
#import "SouViewController.h"
#import "SouTableController.h"
#import "MBProgressHUD.h"
@interface SouRootController ()
@property (nonatomic, strong) SouViewController *collectVC;
@property (nonatomic, strong) SouTableController *tabVC;
@end

@implementation SouRootController
- (void)dealloc
{
    self.collectVC = nil;
    self.tabVC = nil;
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
    self.navigationItem.title = @"找车";
    NSDictionary *dict = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:17],NSForegroundColorAttributeName:[UIColor colorWithRed:35.0/255.0 green:55.0/255.0 blue:121.0/255.0 alpha:10]};
    self.navigationController.navigationBar.titleTextAttributes = dict;
    
    UIImageView *ima = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"汽车之家app_r1_c2"]];
    ima.frame = CGRectMake(0, 0, 80, 40);
    ima.contentMode = UIViewContentModeScaleAspectFit;
    UIBarButtonItem *butB = [[UIBarButtonItem alloc] initWithCustomView:ima];
    self.navigationItem.leftBarButtonItem = butB;
    
    [self.view setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
    self.collectVC = [[SouViewController alloc] init];
    
    [self.view addSubview:_collectVC.view];
    [self addChildViewController:_collectVC];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushAction) name:PushTableView object:nil];
    
    
    
    // Do any additional setup after loading the view.
}


- (void)pushAction
{
    self.tabVC = [[SouTableController alloc] initWithStyle:UITableViewStylePlain];
    _tabVC.tableView.frame = self.view.bounds;
//    [_collectVC.view removeFromSuperview];
//    [self.view addSubview:_tabVC.view];
//    [self addChildViewController:_tabVC];
    
    [self.navigationController pushViewController:_tabVC animated:YES];
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
