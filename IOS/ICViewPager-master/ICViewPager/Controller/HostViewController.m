//
//  HostViewController.m
//  ICViewPager
//
//  Created by Ilter Cengiz on 28/08/2013.
//  Copyright (c) 2013 Ilter Cengiz. All rights reserved.
//

#import "HostViewController.h"
 #import "CHCarHandle.h"
#import "TableViewController.h"
#import "Car.h"
#import "ShowViewController.h"
#import "PlayViewController.h"
@interface HostViewController () <ViewPagerDataSource, ViewPagerDelegate>

@end

@implementation HostViewController

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewDidLoad {
    
    self.dataSource = self;
    self.delegate = self;

//    self.title = @"你-我-他";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(PushAction:) name:CHTableViewControllerDidSelected object:nil];
    
    // Keeps tab bar below navigation bar on iOS 7.0+
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    [super viewDidLoad];
}

- (void)PushAction:(NSNotification *)notification
{
    NSDictionary *dic = [notification userInfo];
    Car *car = dic[@"car"];
    if (car.videoaddress) {
        PlayViewController *player = [[PlayViewController alloc] init];
        player.str = car.videoaddress;
//        NSLog(@"........%@",car.videoaddress);
        [self.navigationController pushViewController:player animated:YES];
        
    } else {
        
    ShowViewController *showView = [[ShowViewController alloc] init];
    
    showView.car = car;
    
    [self.navigationController pushViewController:showView animated:YES];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ViewPagerDataSource
- (NSUInteger)numberOfTabsForViewPager:(ViewPagerController *)viewPager {
    return [CHCarHandle sharedHandle].carArr.count - 2;
}
- (UIView *)viewPager:(ViewPagerController *)viewPager viewForTabAtIndex:(NSUInteger)index {
    
    UILabel *label = [UILabel new];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:13.0];
    label.text = [CHCarHandle sharedHandle].carArr[index];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    [label sizeToFit];
    
    return label;
}

- (UIViewController *)viewPager:(ViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index {
    
//    ContentViewController *cvc = [self.storyboard instantiateViewControllerWithIdentifier:@"contentViewController"];
//    
//    cvc.labelString = [NSString stringWithFormat:@"Content View #%i", index];
    TableViewController *cvc = [[TableViewController alloc] initWithStyle:UITableViewStylePlain];
    cvc.str = [CHCarHandle sharedHandle].carArr[index];
    return cvc;
}

#pragma mark - ViewPagerDelegate
- (CGFloat)viewPager:(ViewPagerController *)viewPager valueForOption:(ViewPagerOption)option withDefault:(CGFloat)value {
    
    switch (option) {
        case ViewPagerOptionStartFromSecondTab:
            return 0.0;
            break;
        case ViewPagerOptionCenterCurrentTab:
            return 0.0;
            break;
        case ViewPagerOptionTabLocation:
            return 1.0;
            break;
        default:
            break;
    }
    
    return value;
}
- (UIColor *)viewPager:(ViewPagerController *)viewPager colorForComponent:(ViewPagerComponent)component withDefault:(UIColor *)color {
    
    switch (component) {
        case ViewPagerIndicator:
            return [[UIColor redColor] colorWithAlphaComponent:0.64];
            break;
        default:
            break;
    }
    
    return color;
}

@end
