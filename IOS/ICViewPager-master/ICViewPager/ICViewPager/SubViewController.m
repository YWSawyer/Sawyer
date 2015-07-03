//
//  SubViewController.m
//  ICViewPager
//http://app.api.autohome.com.cn/autov4.0/cars/pics-a2-pm2-v4.0.2-ss66-sp0-cg0-cl0-p1-s60.html
//  Created by lanou3g on 14-7-23.
//  Copyright (c) 2014年 Ilter Cengiz. All rights reserved.
//

#import "SubViewController.h"
#import "CarManger.h"
#import "SubTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "ListCar.h"

@interface SubViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)NSMutableArray *arr;
@property (nonatomic, strong)NSMutableDictionary *dic;
@end

@implementation SubViewController
- (void)dealloc
{
    self.table = nil;
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
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    
    [self.view addGestureRecognizer:pan];
    

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadAction) name:SubViewControllerReload object:nil];
    
    if ([[CarManger defaultManger].FinDic[_stri] count] == 0) {
        
        [[CarManger defaultManger] FindCar:_stri];
    }
   
    self.table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width*3/4, self.view.bounds.size.height-120) style:UITableViewStylePlain];
    [self.view addSubview:_table];
    _table.delegate = self;
    _table.dataSource = self;
    // Do any additional setup after loading the view.
}



-(void) handlePan:(UIPanGestureRecognizer*) recognizer
{
    CGPoint tran = [recognizer translationInView:self.view];
    float x = self.view.center.x + tran.x;
 
    if (x<self.view.center.x) {
        x = self.view.center.x;
    } else if (x > self.view.center.x){
  
    [[NSNotificationCenter defaultCenter] postNotificationName:@"shouhui" object:nil];

    }
}

- (void)reloadAction
{
    [self.table reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[CarManger defaultManger].FinDic allKeys].count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *str = [CarManger defaultManger].FinArr[section];
    NSArray *arr = [CarManger defaultManger].FinDic[str];
    return arr.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cell_id = @"cell_id";
    SubTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if (!cell) {
        cell = [[SubTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cell_id];
    }
    
    NSString *str = [CarManger defaultManger].FinArr[indexPath.section];
    NSArray *arr = [CarManger defaultManger].FinDic[str];
    ListCar *car = arr[indexPath.row];
    
    [cell.imaV setImageWithURL:[NSURL URLWithString:car.imgUrl] placeholderImage:[UIImage imageNamed:@"101"]];
    cell.labe.text = car.name;
    cell.priceLab.text = car.price;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [CarManger defaultManger].FinArr[section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str = [CarManger defaultManger].FinArr[indexPath.section];
    NSArray *arr = [CarManger defaultManger].FinDic[str];
    ListCar *car = arr[indexPath.row];
    NSString *str_id = car.ID;
//    NSLog(@"%@",str_id);
    NSDictionary *dict = [NSDictionary dictionaryWithObject:str_id forKey:@"str"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:SubViewControllerSeclected object:nil userInfo:dict];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.table reloadData];
}

- (void)viewDidDisappear:(BOOL)animated
{
    self.table = nil;
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
