//
//  MoController.m
//  ICViewPager
//
//  Created by lanou3g on 14-7-25.
//  Copyright (c) 2014年 Ilter Cengiz. All rights reserved.
//

#import "MoController.h"
#import "CarManger.h"
#import "TowTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "DownAreaHandle.h"
#import "MJRefresh.h"
#import "MBProgressHUD.h"
@interface MoController ()<MJRefreshBaseViewDelegate>
{
    MBProgressHUD *HUD;
}
@property (nonatomic, assign) BOOL isShowing;
@property (nonatomic, strong) NSMutableArray *arr;
@property (nonatomic, strong) NSMutableDictionary *dic;
@property (nonatomic, assign) BOOL isSubShowing;
@property (nonatomic, copy) NSMutableString *str1;
@property (nonatomic, copy) NSMutableString *str2;
@end

@implementation MoController
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
    [CarManger defaultManger];
    self.arr = [NSMutableArray array];
    self.dic = [NSMutableDictionary dictionary];
    self.tableView.layer.borderWidth = 1.0;
    self.tableView.layer.borderColor = [UIColor orangeColor].CGColor;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshAction) name:TowTableViewContrellerRefreah object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeValue) name:MoControllerValueChange object:nil];
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = self.tableView;
    header.delegate = self;
    [header beginRefreshing];
   
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark 开始进入刷新状态
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    NSLog(@"%@----开始进入刷新状态", refreshView.class);
    
    
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
    [refreshView endRefreshing];
}



- (void)changeValue
{
    if (self.isSubShowing) {
        _arr = [CarManger defaultManger].moSubArr;
        _dic = [CarManger defaultManger].moSubDic;
    } else {
    _arr = [CarManger defaultManger].MoArr;
    _dic = [CarManger defaultManger].MoDic;
    }
    [self.tableView reloadData];
    
}
//- (void)witerAction
//{
//    sleep(4);
//    if ([CarManger defaultManger].arr.count == 0) {
//        UIAlertView *aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络不给力" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [aler show];
//        });
//    }
//}
- (void)refreshAction
{
    _arr = nil;
    _dic = nil;
    
    _arr = [CarManger defaultManger].arr;
    _dic = [CarManger defaultManger].dic;
  
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
    if (self.isShowing) {
        return _arr.count + 1;
    }
    return _arr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.isShowing) {
        if (section == 0) {
            return 1;
        }else{
        NSString *str = _arr[section-1];
        NSArray *arr = _dic[str];
        return arr.count;
        }
    }
    NSString *str = _arr[section];
    NSArray *arr = _dic[str];
    return arr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cell_id = @"cell_id";
    static NSString *cell_ID = @"cell_ID";
    static NSString *cell_DI = @"cell_DI";
    if (self.isShowing) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_ID];
        
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cell_ID];
        }
        if (indexPath.section == 0) {
            UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:cell_DI];
            if (cell1==nil) {
                cell1 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cell_DI];
            }
            cell1.textLabel.text = @"返回";
            cell1.textLabel.textColor = [UIColor redColor];
            cell1.textLabel.font = [UIFont systemFontOfSize:15];
            return cell1;
        }
        NSString *str = _arr[indexPath.section-1];
        NSArray *arr = _dic[str];
        ListCar *car = arr[indexPath.row];
        cell.textLabel.text = car.name;
        if (self.isSubShowing) {
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.textLabel.textColor = [UIColor orangeColor];
            
        } else {
            cell.textLabel.font = [UIFont systemFontOfSize:17];
            cell.textLabel.textColor = [UIColor blackColor];
        }
        return cell;
    }
    
    TowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if (!cell) {
        cell = [[TowTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cell_id];
    }
    NSString *str = _arr[indexPath.section];
    NSArray *arr = _dic[str];
    ListCar *car = arr[indexPath.row];
    [cell.imagV setImageWithURL:[NSURL URLWithString:car.imgUrl]];
    cell.lab.text = car.carName;
    // Configure the cell...
    
    return cell;

}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (self.isShowing == YES) {
        if (section == 0) {
            return 0;
        }
        return _arr[section-1];
    }
    return _arr[section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.isShowing == YES) {
        
        if (section == 0) {
            return 0;
        }
    }
    return 20;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.isShowing = NO;
    self.isSubShowing = NO;
    [self refreshAction];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.isShowing) {
        self.isShowing = YES;

        
        NSString *str = [CarManger defaultManger].arr[indexPath.section];
        NSArray *arr = [CarManger defaultManger].dic[str];
        ListCar *car = arr[indexPath.row];
        NSString *strID = car.ID;
        _str1 = [NSMutableString stringWithFormat:@"%@",car.ID];
//        NSLog(@"......%@",_str1);
        _arr = nil;
        _dic = nil;
        [[CarManger defaultManger] ModFinCar:strID];
    } else {
        if (indexPath.section == 0) {
            if (self.isSubShowing) {
                self.isSubShowing = NO;
                _arr = nil;
                _dic = nil;
                _arr = [CarManger defaultManger].MoArr;
                _dic = [CarManger defaultManger].MoDic;
            } else {
            self.isShowing = NO;
            _arr = nil;
            _dic = nil;
            _arr = [CarManger defaultManger].arr;
            _dic = [CarManger defaultManger].dic;
            }
            [self.tableView reloadData];
        }else{
            if (!self.isSubShowing) {
                NSString *str = _arr[indexPath.section-1];
                NSArray *arr = _dic[str];
                ListCar *car = arr[indexPath.row];
                NSString *strKey = car.ID;
                _str2 = [NSMutableString stringWithFormat:@"%@",car.ID];
//                NSLog(@".....%@",_str2);
                self.isSubShowing = YES;
                [[CarManger defaultManger] ModSubCar:strKey];
            }else{
                NSString *str = _arr[indexPath.section-1];
                NSArray *arr = _dic[str];
                ListCar *car = arr[indexPath.row];
//                NSLog(@"%@",car.ID);
                
                self.isShowing = NO;
                self.isSubShowing = NO;
                [[NSNotificationCenter defaultCenter] postNotificationName:AreaChange object:nil];
                [self.tableView removeFromSuperview];
                [[DownAreaHandle shareHandle] ModSubSubCar:_str1 with:_str2 with:car.ID with:@"40"];
            }
        }
    }
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
