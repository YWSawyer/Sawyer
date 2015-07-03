//
//  SubShowController.m
//  ICViewPager
//
//  Created by lanou3g on 14-7-24.
//  Copyright (c) 2014年 Ilter Cengiz. All rights reserved.
//

#import "SubShowController.h"
#import "Car.h"
#import "SubShowTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "SubShowTowCell.h"
#import "SubFindController.h"
@interface SubShowController ()
@property (nonatomic, strong) NSMutableArray *arr;
@property (nonatomic, strong) NSMutableDictionary *dic;
@end

@implementation SubShowController
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
    
//    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"汽车之家app_r2_c1"] style:UIBarButtonItemStyleDone target:self action:@selector(backBarButtonItema)];
//    self.navigationItem.leftBarButtonItem = leftBarButton;
    
 
//    UIImage *imae = [UIImage imageNamed:@"app_r2_c111"];
//    
////    ima.contentMode = UIViewContentModeScaleAspectFit;
//    
//    UIBarButtonItem *lef = [[UIBarButtonItem alloc] initWithImage:imae style:UIBarButtonItemStyleDone target:self action:@selector(backBarButtonItema)];
//
//    [lef setTintColor:[UIColor colorWithPatternImage:imae]];
//    
//
//    self.navigationItem.leftBarButtonItem = lef;
    
    
    NSString *str = [NSString stringWithFormat:@"http://app.api.autohome.com.cn/autov4.0/cars/seriessummary-a2-pm2-v4.0.2-s%@-t.html",_str];
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data!=nil) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            [self ext_mothed:dic];
        }
    }];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

//- (void)backBarButtonItema
//{
//    [self.navigationController popToRootViewControllerAnimated:YES];
//}


- (void)ext_mothed:(NSDictionary *)dict
{
    self.dic = [NSMutableDictionary dictionary];
    self.arr = [NSMutableArray array];
    
    NSDictionary *dic = dict[@"result"];
    Car *car = [[Car alloc] init];
    car.fctprice = dic[@"fctprice"];
    car.levelname = dic[@"levelname"];
    car.imgurl = dic[@"logo"];
    car.name = dic[@"name"];
    NSArray *ar = [NSArray arrayWithObject:car];
    [_dic setObject:ar forKey:@"result"];
    [_arr addObject:@"result"];
    
    NSArray *arr = dic[@"enginelist"];
    
    for (NSDictionary *di in arr) {
        [_arr addObject:di[@"name"]];
        NSArray *array = di[@"speclist"];
        NSMutableArray *ar_1 = [NSMutableArray array];
        for (NSDictionary *d in array) {
            Car *ca = [[Car alloc] init];
            
            ca.teltext = d[@"description"];
            ca.Id = d[@"id"];
            ca.name = d[@"name"];
            ca.specprice = d[@"price"];
            
            [ar_1 addObject:ca];
        }
        [_dic setObject:ar_1 forKey:di[@"name"]];
    }
    
    [self.tableView reloadData];
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    self.tableView = nil;
}

- (void)viewWillAppear:(BOOL)animated
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
    return _arr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSString *str = _arr[section];
    NSArray *arr = _dic[str];
    return arr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cell_id = @"cell_id";
    static NSString *cell_ID = @"cell_ID";
    NSString *str = _arr[indexPath.section];
    NSArray *arr = _dic[str];
    Car *car = [[Car alloc] init];
    car = arr[indexPath.row];
    
    if (indexPath.section == 0) {
        SubShowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
        if (!cell) {
            cell = [[SubShowTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cell_id];
        }
        
        
        [cell.imv setImageWithURL:[NSURL URLWithString:car.imgurl] placeholderImage:[UIImage imageNamed:@"101"]];
        cell.textLab.text = car.name;
        cell.rigtLab.text = car.fctprice;
        return cell;
    }
    SubShowTowCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_ID];
    if (cell == nil) {
        cell = [[SubShowTowCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cell_ID];
        
    }
    cell.nameLa.text = car.name;
    cell.descripLa.text = car.teltext;
    cell.priceLa.text = car.specprice;
    // Configure the cell...
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return _arr[section];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    return 20;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 250;
    }
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section != 0) {
        NSString *str = _arr[indexPath.section];
        NSArray *arr = _dic[str];
        Car *car = [[Car alloc] init];
        car = arr[indexPath.row];
        
        SubFindController *finVC = [[SubFindController alloc] init];
        finVC.strr = [NSString stringWithFormat:@"%@",car.Id];
        
        [self.navigationController pushViewController:finVC animated:YES];
        
        
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
