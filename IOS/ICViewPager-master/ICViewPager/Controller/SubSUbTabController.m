//
//  SubSUbTabController.m
//  ICViewPager
//
//  Created by lanou3g on 14-7-29.
//  Copyright (c) 2014年 Ilter Cengiz. All rights reserved.
//

#import "SubSUbTabController.h"
#import "SouCarModel.h"
#import "Car.h"
#import "ShowTabController.h"
#import "SubSubCell.h"
#import "UIImageView+WebCache.h"
@interface SubSUbTabController ()

@end

@implementation SubSUbTabController

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
    self.navigationItem.title = _nameTitil;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshAction) name:subSubTabRefresh object:nil];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return [SouCarModel sharedHanle].subKeyArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSString *key = [SouCarModel sharedHanle].subKeyArr[section];
    NSArray *arr = [SouCarModel sharedHanle].subDic[key];
    return arr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cell_id = @"cell_id";
    SubSubCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if (!cell) {
        cell = [[SubSubCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cell_id];
    }
    NSString *key = [SouCarModel sharedHanle].subKeyArr[indexPath.section];
    NSArray *arr = [SouCarModel sharedHanle].subDic[key];
    Car *car = arr[indexPath.row];
    
    [cell.ima setImageWithURL:[NSURL URLWithString:car.imgurl]];
    cell.labName.text = [NSString stringWithFormat:@"%@",car.name];
    cell.PreLab.text = [NSString stringWithFormat:@"%@",car.nickname];
    cell.priceLab.text = [NSString stringWithFormat:@"%@",car.price];
    
    // Configure the cell...
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *key = [SouCarModel sharedHanle].subKeyArr[indexPath.section];
    NSArray *arr = [SouCarModel sharedHanle].subDic[key];
    Car *car = arr[indexPath.row];
    
    ShowTabController *showVC = [[ShowTabController alloc] init];
    showVC.strr = [NSString stringWithFormat:@"%@",car.Id];
    
    
    [self.navigationController pushViewController:showVC animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [SouCarModel sharedHanle].subKeyArr[section];
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
