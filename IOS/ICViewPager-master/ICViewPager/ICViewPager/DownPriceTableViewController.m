//
//  DownPriceTableViewController.m
//  ICViewPager
//
//  Created by lanou3g on 14-7-22.
//  Copyright (c) 2014年 Ilter Cengiz. All rights reserved.
//

#import "DownPriceTableViewController.h"
#import "CHCarHandle.h"
#import "Car.h"
#import "DownTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "CarManger.h"
#import "DownAreaHandle.h"
#import "NowDownModel.h"
@interface DownPriceTableViewController ()<MJRefreshBaseViewDelegate>
@property (nonatomic, copy) NSString *str;

@property (nonatomic, retain) UIBarButtonItem *rightBarFenlei;

@property (nonatomic, strong) NSMutableArray *arr;
@property (nonatomic, strong) NSMutableDictionary *dic;

@end

@implementation DownPriceTableViewController
- (void)dealloc
{
    self.arr = nil;
    self.dic = nil;
}
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.arr = [NSMutableArray array];
    self.dic = [NSMutableDictionary dictionary];
    
    
    //下拉刷新
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = self.tableView;
    header.delegate = self;
    [header beginRefreshing];
    //上拉刷新
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = self.tableView;
    footer.delegate = self;
    
    self.str = @"降价";
    [[CHCarHandle sharedHandle] getCarData:_str];
    [NowDownModel defaultMange];
//    [[CHCarHandle sharedHandle] getDownCarData:@"0" withID:@"0"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeAction) name:DownPriceChangeValue object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(areaChangeReloadData) name:AreaChange object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(MochangeAction) name:MoControllerChange111 object:nil];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - 刷新控件的代理方法
#pragma mark 开始进入刷新状态
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
//    NSLog(@"%@----开始进入刷新状态", refreshView.class);
    
    // 1.添加假数据
    //    for (int i = 0; i<5; i++) {
    //        UIColor *color = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
    //
    if ([refreshView isKindOfClass:[MJRefreshHeaderView class]]) {
        
    } else {
    }
    

    
    // 2.2秒后刷新表格UI
    [self performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:1.0];
}

#pragma mark 刷新完毕
- (void)refreshViewEndRefreshing:(MJRefreshBaseView *)refreshView
{
    //    [CHFilmHandle sharedHandle].myBlock();

    //    NSLog(@"%@----刷新完毕", refreshView.class);
}

#pragma mark 监听刷新状态的改变
- (void)refreshView:(MJRefreshBaseView *)refreshView stateChange:(MJRefreshState)state
{
    switch (state) {
        case MJRefreshStateNormal:
            NSLog(@"%@----切换到：普通状态", refreshView.class);
            break;
            
        case MJRefreshStatePulling:
            NSLog(@"%@----切换到：松开即可刷新的状态", refreshView.class);
            break;
            
        case MJRefreshStateRefreshing:
            NSLog(@"%@----切换到：正在刷新状态", refreshView.class);
            break;
        default:
            break;
    }
}

- (void)doneWithView:(MJRefreshBaseView *)refreshView
{
    // 刷新表格
    //    _a = 8;
    //    [self.rootView.collectionView reloadData];
    
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [self.tableView reloadData];
    [refreshView endRefreshing];
}

- (void)MochangeAction
{
    if ([DownAreaHandle shareHandle].moSubSubArr == 0) {
        UIAlertView *aler = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"未能找到,请重新选择" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [aler show];
    }
    _arr = nil;
    _arr = [DownAreaHandle shareHandle].moSubSubArr;
    [self.tableView reloadData];
}

- (void)areaChangeReloadData
{
    _arr = nil;
    _arr = [NowDownModel defaultMange].arr;
    _arr = [CHCarHandle sharedHandle].downArr;
    [self.tableView reloadData];
}
- (void)changeAction
{
    _arr = nil;
    _arr = [NowDownModel defaultMange].arr;
//    _arr = [CHCarHandle sharedHandle].downArr;
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
   
    return 1;
   
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.

//    NSArray *arr = [CHCarHandle sharedHandle].carDic[_str];
    
    return _arr.count;
   
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
//    NSArray *arr = [CHCarHandle sharedHandle].carDic[_str];
    static NSString *cell_id = @"cell_id";
    DownTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if (!cell) {
        cell = [[DownTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cell_id];
    }
    Car *car = _arr[indexPath.row];


    
    [cell.imageV setImageWithURL:[NSURL URLWithString:car.specpic] placeholderImage:[UIImage imageNamed:@"汽车之家app_r1_c2"]];
    
    NSLog(@"%@",car.specpic);

    cell.titleLab.text = [NSString stringWithFormat:@"%@",car.specname];

    int a = [car.fctprice integerValue];
    int b = [car.dealerprice integerValue];
   
    cell.disparityLab.text = [NSString stringWithFormat:@"降价%d万",(a-b)];
    cell.presentLab.text = [NSString stringWithFormat:@"%@",car.dealerprice];

    if (car.city) {
        cell.areaLab.text = [NSString stringWithFormat:@"%@",car.city];
    }
    if (car.orderrange) {
        
        cell.shouLab.text = [NSString stringWithFormat:@"%@",car.orderrange];
    }
    cell.addressLab.text = [NSString stringWithFormat:@"%@",car.seriesname];
  
    [cell.ima setImageWithURL:[NSURL URLWithString:car.styledinventorystate]];
    // Configure the cell...
    
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Car *car = _arr[indexPath.row];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:car forKey:@"str"];
    [[NSNotificationCenter defaultCenter] postNotificationName:DownPriceControllerPush object:nil userInfo:dic];
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}




/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
