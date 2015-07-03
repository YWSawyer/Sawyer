//
//  DownShowViewController.m
//  ICViewPager
//
//  Created by lanou3g on 14-7-25.
//  Copyright (c) 2014年 Ilter Cengiz. All rights reserved.
//

#import "DownShowViewController.h"
#import "MBProgressHUD.h"

@interface DownShowViewController ()<MBProgressHUDDelegate>
{
    MBProgressHUD *HUD;
}
@property (nonatomic,strong)UIWebView *webView;
@end
@implementation DownShowViewController
- (void)dealloc
{
    self.car = nil;
    self.webView = nil;
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
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate = self;
    HUD.labelText = @"Loading";
    HUD.square = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [HUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];

    if (_car.jupURl) {
        
        NSURL *url = [NSURL URLWithString:_car.jupURl];
        
        
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-113)];
        
        [_webView loadRequest:request];
        
        [_webView setAllowsInlineMediaPlayback:YES];
        [_webView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
        
    } else {
    NSString *str1 = [NSString stringWithFormat:@"%@",_car.specid];
    NSString *str2 = [NSString stringWithFormat:@"%@",_car.articleid];
    NSString *str3 = [NSString stringWithFormat:@"%@",_car.Id];
    NSString *str4 = [NSString stringWithFormat:@"%@",_car.seriesid];

    NSString *str = [NSString stringWithFormat:@"http://cont.app.autohome.com.cn/autov4.0/content/dealer/downprice-a1-pm2-v4.0.2-sp%@-n%@-t0-d%@-ss%@-nt0.html",str1,str2,str3,str4];
    NSURL *url = [NSURL URLWithString:str];
        
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-113)];
    
    [_webView loadRequest:request];
    
    [_webView setAllowsInlineMediaPlayback:YES];
    [_webView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
    
    }
    // Do any additional setup after loading the view.
}
- (void)myTask {
	// Do something usefull in here instead of sleeping ...
	sleep(2);
    [self performSelectorOnMainThread:@selector(AddAction) withObject:nil waitUntilDone:YES];
  
	
}

- (void)AddAction
{
    [self.view addSubview:_webView];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.view = nil;
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
