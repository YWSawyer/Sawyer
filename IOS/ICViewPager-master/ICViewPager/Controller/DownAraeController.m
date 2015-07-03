//
//  DownAraeController.m
//  ICViewPager
//
//  Created by lanou3g on 14-7-24.
//  Copyright (c) 2014年 Ilter Cengiz. All rights reserved.
//

#import "DownAraeController.h"
#import "Area.h"
#import "City.h"
#import "DownAreaHandle.h"
#import "CHCarHandle.h"
@interface DownAraeController ()
@property (nonatomic, assign)BOOL isShowing;
@property (nonatomic, strong)NSMutableArray *arr;
@property (nonatomic, strong)NSMutableDictionary *dic;
@end

@implementation DownAraeController

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
    self.tableView.layer.borderWidth = 1.0;
    self.tableView.layer.borderColor = [UIColor orangeColor].CGColor;
    self.dic = [NSMutableDictionary dictionary];
    self.arr = [NSMutableArray array];
    
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshAction) name:DownAreaControllerRefreshData object:nil];
    
    [DownAreaHandle shareHandle];
      // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (self.isShowing) {
//        NSMutableArray *a = [NSMutableArray array];
//        for (City *cit in _arr) {
//            if (![a containsObject:cit.firstletter]) {
//                
//                [a addObject:cit.firstletter];
//            }
//            [a sortUsingSelector:@selector(compare:)];
//        }
//        return a;
        return 0;
    }
    return [DownAreaHandle shareHandle].grpArr;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.isShowing = NO;
    [self refreshAction];
}

- (void)viewDidDisappear:(BOOL)animated
{
    _arr = nil;
    _dic = nil;
    self.isShowing = NO;
}


- (void)refreshAction
{
    _arr = [DownAreaHandle shareHandle].grpArr;
    _dic = [DownAreaHandle shareHandle].grpDic;
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
        return 1;
    }
    return [DownAreaHandle shareHandle].grpArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
//    NSString *str = [DownAreaHandle shareHandle].grpArr[section];
//    NSArray *arr = [DownAreaHandle shareHandle].grpDic[str];
    if (self.isShowing) {
  
        return _arr.count + 1;
    }
    NSString *str = _arr[section];
    NSArray *arr1 = _dic[str];
    return arr1.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    static NSString *cell_id = @"cell_id";
    static NSString *cell_ID = @"cell_ID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    UITableViewCell *cell_1 = [tableView dequeueReusableCellWithIdentifier:cell_ID];
    if (!cell_1) {
        cell_1 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cell_ID];
    }
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cell_id];
    }
    
    if (self.isShowing) {
//        City *are = _arr[indexPath.section];
//        NSArray *arr = _dic[are.name];
        if (indexPath.row == 0) {
            cell_1.textLabel.text = @"返回";
            cell_1.textLabel.textColor = [UIColor redColor];
            cell_1.textLabel.font = [UIFont boldSystemFontOfSize:17];
            return cell_1;
        } else if(indexPath.row == 1){
            cell_1.textLabel.font = [UIFont boldSystemFontOfSize:17];
            cell_1.textLabel.text = @"全省";
            return cell_1;
        } else {
            
            NSLog(@"%u",_arr.count);
        City *cit = _arr[indexPath.row-1];

        cell.textLabel.text = [NSString stringWithFormat:@"%@",cit.name];
        }
    } else if(!self.isShowing) {
        
        NSString *str = _arr[indexPath.section];
        NSArray *arr = _dic[str];
        Area *ar = arr[indexPath.row];
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@",ar.name];
    }
    
    // Configure the cell...
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (self.isShowing) {
//        City *city = _arr[section];
        return 0;
    }
    return [DownAreaHandle shareHandle].grpArr[section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.isShowing) {
        return 0;
    }
    return 15;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.isShowing) {
        
        self.isShowing = YES;
        NSString *str = [DownAreaHandle shareHandle].grpArr[indexPath.section];
        _arr = nil;
        
        NSArray *ar_1 = [DownAreaHandle shareHandle].grpDic[str];
        
        Area *a = ar_1[indexPath.row];
        
        _arr = [DownAreaHandle shareHandle].dic[a.ID];
        [_arr insertObject:a.ID atIndex:0];
  
        [self.tableView reloadData];
        return;
    } else {
        self.isShowing = NO;
        if (indexPath.row == 0) {
            _arr = nil;
//            NSLog(@"%@",[DownAreaHandle shareHandle].grpArr);
            _arr = [DownAreaHandle shareHandle].grpArr;
            _dic = [DownAreaHandle shareHandle].grpDic;
            [self.tableView reloadData];
        } else if(indexPath.row == 1){
            NSString *str = _arr[0];
            [[CHCarHandle sharedHandle] getDownCarData:str withID:@"0"];
            
            [self.tableView removeFromSuperview];
        } else {
            City *cit = _arr[indexPath.row-1];
            
            [[CHCarHandle sharedHandle] getDownCarData:cit.ID withID:cit.ID];
            self.isShowing = NO;
            [self.tableView removeFromSuperview];
        }
        
        
    }
    
}

//    Area *a = [DownAreaHandle shareHandle].arr[indexPath.section];
//    NSArray *menu = [DownAreaHandle shareHandle].dic[a.name];
//    POPDViewController *popMenu = [[POPDViewController alloc]initWithMenuSections:menu];
//    popMenu.delegate = self;
//    popMenu.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
//    [self addChildViewController:popMenu];
//    [self.view addSubview:popMenu.view];


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
