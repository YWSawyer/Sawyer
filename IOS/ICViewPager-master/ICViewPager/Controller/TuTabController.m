//
//  TuTabController.m
//  ICViewPager
//
//  Created by lanou3g on 14-7-30.
//  Copyright (c) 2014年 Ilter Cengiz. All rights reserved.
//

#import "TuTabController.h"
#import "TuManger.h"
#import "UIImageView+WebCache.h"
#import "ListCar.h"
#import "TuTabCell.h"
#import "TuShowController.h"
#import "MJRefresh.h"

@interface TuTabController ()<MJRefreshBaseViewDelegate>

@end

@implementation TuTabController

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
    [TuManger defaultsManger];
    
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = self.tableView;
    header.delegate = self;
    [header beginRefreshing];
    
    UIImageView *ima = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"汽车之家app_r1_c2"]];
    ima.frame = CGRectMake(0, 0, 80, 40);
    ima.contentMode = UIViewContentModeScaleAspectFit;
    UIBarButtonItem *butB = [[UIBarButtonItem alloc] initWithCustomView:ima];
    self.navigationItem.leftBarButtonItem = butB;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshAction) name:TukuTab object:nil];

    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidAppear:(BOOL)animated
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(4);
        if ([TuManger defaultsManger].arr.count == 0) {
            UIAlertView *aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络不给力" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            dispatch_async(dispatch_get_main_queue(), ^{
                [aler show];
            });
        }
    });

}

#pragma mark - 刷新控件的代理方法
#pragma mark 开始进入刷新状态

- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    // 1.添加假数据
    //
    //    NSArray *arr = [CHCarHandle sharedHandle].carDic[_str];
    //    if (arr.count == 0) {
    //        [[CHCarHandle sharedHandle] getCarData:_str];
    //    }
    if ([refreshView isKindOfClass:[MJRefreshHeaderView class]]) {
        
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


- (void)refreshAction
{
    
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
    return [TuManger defaultsManger].arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cell_id = @"cell_id";
    TuTabCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id ];
    if (!cell) {
        cell = [[TuTabCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cell_id];
    }
    ListCar *car = [TuManger defaultsManger].arr[indexPath.row];
    [cell.imv setImageWithURL:[NSURL URLWithString:car.imgUrl] placeholderImage:[UIImage imageNamed:@"101"]];
    cell.nameLab.text = [NSString stringWithFormat:@"%@",car.name];
    cell.countLab.text = [NSString stringWithFormat:@"%@张",car.nubCount];
    
    // Configure the cell...
    
    return cell;
}
- (void)viewWillAppear:(BOOL)animated
{
    if ([TuManger defaultsManger].arr.count == 0) {
        [TuManger defaultsManger];
    }
    [self.tableView reloadData];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return gao+50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ListCar *car = [TuManger defaultsManger].arr[indexPath.row];
    TuShowController *tuShow = [[TuShowController alloc] init];
    
    NSString *strUrl = [NSString stringWithFormat:@"%@",car.url];
    
    [[TuManger defaultsManger] getTuKu:strUrl];
    tuShow.strr = strUrl;
    
    [self.navigationController pushViewController:tuShow animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
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
