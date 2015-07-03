//
//  ShowViewController.m
//  ICViewPager
//http://www.autohome.com.cn/drive/201407/%@.html
//  Created by lanou3g on 14-7-21.
//  Copyright (c) 2014年 Ilter Cengiz. All rights reserved.
//http://cont.app.autohome.com.cn/autov4.0/content/news/newsinfo-a2-pm2-v4.0.2-i827253.html
//http://cont.app.autohome.com.cn/autov4.0/content/news/newsinfo-a2-pm2-v4.0.2-i826564.html
//http://www.autohome.com.cn/advice/201407/826564.html

#import "ShowViewController.h"
#import "MBProgressHUD.h"
#import "TFHpple.h"
@interface ShowViewController ()<MBProgressHUDDelegate>
{
    MBProgressHUD *HUD;

}


@property (nonatomic,strong)UIWebView *webView;
@property (nonatomic, retain) NSArray *listArray;
@property (nonatomic, assign) NSInteger pageTotal;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, retain) UIImage *imageUrl;
@property (nonatomic, retain) NSString *details;

@end

@implementation ShowViewController
- (void)dealloc{
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
    self.navigationController.navigationBar.hidden = NO;
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
//    HUD.delegate = self;
    HUD.labelText = @"Loading";
    HUD.square = YES;

    self.view.backgroundColor = [UIColor whiteColor];
    
    [HUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
    
    NSString *strr = [NSString stringWithFormat:@"%@",_car.mediatype];
    

    if ([strr isEqualToString:@"2"]) {
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://shuoke.autohome.com.cn/article/%@.html",_car.Id]];
//        NSLog(@"....%@",url);
        
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-113)];

        
        [_webView loadRequest:request];
        
        [_webView setAllowsInlineMediaPlayback:YES];
        [_webView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
        

    } else if ([strr isEqualToString:@"1"]){
        
        self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-113)];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.autohome.com.cn/drive/201407/%@.html",_car.Id]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
//         NSLog(@"......%@",url);
        
        [_webView loadRequest:request];
        
        [_webView setAllowsInlineMediaPlayback:YES];
        [_webView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
        
 
        
    } else if([strr isEqualToString:@"3"]){
        
        self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-113)];
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://v.autohome.com.cn/v_4_%@.html",_car.Id]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
//         NSLog(@"...%@",url);
        
        [_webView loadRequest:request];
    
        
        [_webView setAllowsInlineMediaPlayback:YES];
        [_webView setScalesPageToFit:YES];

        

    } else if ([strr isEqualToString:@"0"]){
        self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-113)];
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.autohome.com.cn/news/201407/%@.html",_car.Id]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
//        NSLog(@"...%@",url);
        
        [_webView loadRequest:request];
        
        
        [_webView setAllowsInlineMediaPlayback:YES];
        [_webView setScalesPageToFit:YES];
        
    } else {
       
        self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-113)];
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://shuoke.autohome.com.cn/article/%@.html",_car.Id]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
//        NSLog(@"...%@",url);
        
        [_webView loadRequest:request];
        
        
        [_webView setAllowsInlineMediaPlayback:YES];
        [_webView setScalesPageToFit:YES];
    }
 
  
    
    // Do any additional setup after loading the view.
}

- (void)myTask
{
    sleep(2);
    [self performSelectorOnMainThread:@selector(AddAction) withObject:nil waitUntilDone:YES];

}
- (void)AddAction
{
    [self.view addSubview:_webView];
}
//- (void)viewDidDisappear:(BOOL)animated
//{
//    self.view = nil;
//}

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
