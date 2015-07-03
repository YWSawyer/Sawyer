//
//  TableViewController.m
//  ICViewPager
//
//  Created by lanou3g on 14-7-21.
//  Copyright (c) 2014年 Ilter Cengiz. All rights reserved.
//

#import "TableViewController.h"
#import "CHCarHandle.h"
#import "CHMyTabCell.h"
#import "Car.h"
#import "ShowViewController.h"
#import "SrcTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
@interface TableViewController ()<MJRefreshBaseViewDelegate>
{
    NSInteger _timeCount;
    NSTimer *timer;
}
@property (nonatomic, retain) NSMutableDictionary *dic;
@property (nonatomic, retain) NSMutableArray *arr;
@property (nonatomic, assign) BOOL isScro;


@end

@implementation TableViewController

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
   
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = self.tableView;
    header.delegate = self;
    [header beginRefreshing];
    //上拉
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = self.tableView;
    footer.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeAction) name:CHFirstValueChange object:nil];

    
//    NSLog(@"%@",_str);
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}




- (void)viewWillAppear:(BOOL)animated
{
    if ([[CHCarHandle sharedHandle].carDic[_str] count] == 0) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            sleep(4);
            if ([[CHCarHandle sharedHandle].carDic[_str] count] == 0) {
                UIAlertView *aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络不给力" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [aler show];
                });
            }
        });
        
        [[CHCarHandle sharedHandle] getCarData:_str];
    }
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



- (void)changeAction
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
    return [[CHCarHandle sharedHandle].carDic[_str] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int i = 0;
    NSArray *arr = [CHCarHandle sharedHandle].carDic[_str];
    
    if ([_str isEqualToString:@"最新"]) {
        if (indexPath.row == 0) {
            
        NSArray *ar_a = arr[0];
        static NSString *cell_di = @"cell_di";
        SrcTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_di];
        if (cell == nil) {
            cell = [[SrcTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cell_di];
        }
        for (Car *ca in ar_a) {
            UIImageView * imageView = [[UIImageView alloc] init];
            [imageView setImageWithURL:[NSURL URLWithString:ca.imgurl]];
            
            imageView.frame = CGRectMake(cell.src.frame.size.width*i, 0, cell.src.frame.size.width, cell.src.frame.size.height);
            
//            NSLog(@"......%d",i);
            i++;
            UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doDoubleTap:)];
            doubleTap.numberOfTapsRequired = 1;
            doubleTap.numberOfTouchesRequired = 1;
            [cell.src addGestureRecognizer:doubleTap];
            
            cell.src.pagingEnabled = YES;
            cell.src.contentMode = UIViewContentModeScaleAspectFit;
            [cell.src addSubview:imageView];
            cell.src.delegate = self;
            cell.src.tag = 1000;

        }
            Car *ca = ar_a[0];
            UIImageView * imageView = [[UIImageView alloc] init];
            [imageView setImageWithURL:[NSURL URLWithString:ca.imgurl]];
            imageView.frame = CGRectMake(cell.src.frame.size.width*i, 0, cell.src.frame.size.width, cell.src.frame.size.height);
            [cell.src addSubview:imageView];
    
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                _timeCount = 0;

            timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(srcView) userInfo:nil repeats:YES];
            });
            
            return cell;
        }
    }
    
    Car *c = arr[indexPath.row];
    NSString *poster = c.smallpic;
    static NSString *cell_id = @"cell_id";
    CHMyTabCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if (cell == nil) {
        cell = [[CHMyTabCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cell_id];
    }
    if (poster == nil) {
        poster = c.smallimg;
    }
    if (poster == nil) {
        poster = c.imgurl;
    }
   
    
    [cell.imView setImageWithURL:[NSURL URLWithString:poster] placeholderImage:[UIImage imageNamed:@"101"]];
    
    if ([_str isEqualToString:@"视频"] || [_str isEqualToString:@"原创视频"]) {
        cell.playedLab.text = [NSString stringWithFormat:@"%@播放",c.playcount];
    } else {
        cell.playedLab.text = [NSString stringWithFormat:@"%@评论",c.replycount];
    }
    cell.lable.text = c.title;
    cell.timeLab.text = c.time;
    // Configure the cell...
    
    return cell;
}

- (void)srcView
{
    UIScrollView *src = (UIScrollView *)[self.view viewWithTag:1000];
   
    NSArray *arr = [CHCarHandle sharedHandle].carDic[@"最新"];
    if (arr.count != 0) {
        
        NSInteger count = [arr[0] count];
        
        
        if (_timeCount == count-1) {
            self.isScro = YES;
        }else if (_timeCount == 0){
            self.isScro = NO;
        }
        [src scrollRectToVisible:CGRectMake(_timeCount*self.view.bounds.size.width, 0, self.view.bounds.size.width, 150) animated:YES];
        
        if (self.isScro) {
            _timeCount --;
        }else{
            _timeCount ++;
        }
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_str isEqualToString:@"最新"]) {
        if (indexPath.row == 0) {
            return 150;
        }
    }
    return 100;
}

#pragma mark 点击ScrollViewchuf


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    float currentPage = scrollView.contentOffset.x;
    int a = currentPage/self.view.bounds.size.width;
    _timeCount = a;
    
    NSArray *arr = [CHCarHandle sharedHandle].carDic[@"最新"];
    
    int b = [arr[0] count];
   
    if (a == b) {
        
        [scrollView scrollRectToVisible:CGRectMake(0, 0, self.view.bounds.size.width, 100) animated:NO];
    }

    
//    NSLog(@"%u",[arr[0] count]);
//
    
}


- (void)doDoubleTap:(UITapGestureRecognizer *)sender
{
    UIScrollView *scr = (UIScrollView *)sender.view;
    int a = scr.contentOffset.x/self.view.bounds.size.width;
    NSArray *arr = [CHCarHandle sharedHandle].carDic[_str];
    NSArray *array = arr[0];

    Car *car = array[a];
    NSDictionary *dic = [NSDictionary dictionaryWithObject:car forKey:@"car"];
//    NSLog(@"%@",car.Id);
    [[NSNotificationCenter defaultCenter] postNotificationName:CHTableViewControllerDidSelected object:self userInfo:dic];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *arr = [CHCarHandle sharedHandle].carDic[_str];

    Car *car = arr[indexPath.row];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:car forKey:@"car"];
//    NSLog(@"%@",car.Id);
    [[NSNotificationCenter defaultCenter] postNotificationName:CHTableViewControllerDidSelected object:self userInfo:dic];
    
}

//- (void)viewDidDisappear:(BOOL)animated
//{
//    self.tableView  = nil;
//}
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
