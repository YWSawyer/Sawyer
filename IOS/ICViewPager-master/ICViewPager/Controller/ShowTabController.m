//
//  ShowTabController.m
//  ICViewPager
//
//  Created by lanou3g on 14-7-29.
//  Copyright (c) 2014年 Ilter Cengiz. All rights reserved.
//

#import "ShowTabController.h"
#import "MBProgressHUD.h"
@interface ShowTabController ()<MBProgressHUDDelegate>
{
    MBProgressHUD *HUD;
}
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation ShowTabController

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
    self.navigationController.navigationBar.hidden = NO;
    
    NSString *strr = [NSString stringWithFormat:@"http://mrobot.pcauto.com.cn/v3/price/detailv36/%@",_strr];
    
//    NSLog(@"555 2222......%@",strr);
    NSURL *url = [NSURL URLWithString:strr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    
    [_webView loadRequest:request];
    
    [_webView setAllowsInlineMediaPlayback:YES];
    [_webView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate = self;
    HUD.labelText= @"Loading";
    HUD.square = YES;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [HUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
    
    // Do any additional setup after loading the view.
}

- (void)myTask
{
    sleep(2);
    
    [self performSelectorOnMainThread:@selector(LoadAction) withObject:nil waitUntilDone:YES];

}
- (void)LoadAction
{
    [self.view addSubview:_webView];

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
