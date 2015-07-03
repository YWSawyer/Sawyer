//
//  PlayViewController.m
//  ICViewPager
//
//  Created by lanou3g on 14-7-22.
//  Copyright (c) 2014年 Ilter Cengiz. All rights reserved.
//

#import "PlayViewController.h"
#import "MBProgressHUD.h"

@interface PlayViewController ()
@property (nonatomic, retain)UITapGestureRecognizer *tap;
@end

@implementation PlayViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    self.playView = [[PlayerView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    CGAffineTransform trabsform = CGAffineTransformMakeRotation(M_PI/2);
    [self.playView setTransform:trabsform];
    self.view = _playView;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden=YES;
    self.tabBarController.tabBar.hidden = YES;
    
//    self.tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showAction)];
//    
//    [self.view addGestureRecognizer:_tap];
    
    [self playMovieAction:self.str];
    // Do any additional setup after loading the view.
}

//- (void)showAction
//{
//    self.navigationController.navigationBar.hidden=YES;
//    self.tabBarController.tabBar.hidden = YES;
//    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        sleep(2);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            self.navigationController.navigationBar.hidden=YES;
//            self.tabBarController.tabBar.hidden = YES;
//        });
//    });
//}


- (void)playMovieAction:(id)sender
{
    NSString *str = self.str;
    
    NSURL *url = [NSURL URLWithString:str];
    
    [self prefersStatusBarHidden];
    
    self.playView.movie = [[MPMoviePlayerController alloc] initWithContentURL:url];
    _playView.movie.controlStyle = MPMovieControlStyleFullscreen;
    
    _playView.movie.initialPlaybackTime = -1;
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.view addSubview:hud];
    
    [hud showAnimated:YES whileExecutingBlock:^{
        [self.view addSubview:_playView.movie.view];
    } completionBlock:^{

        [hud removeFromSuperview];
    }];
    // 注册一个播放结束的通知，当播放结束时，监听到并且做一些处理
    //播放器自带有播放结束的通知，在此仅仅只需要注册观察者监听通知即可。
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(myMovieFinishedCallback:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:_playView.movie];
    [_playView.movie play];
}

-(void)myMovieFinishedCallback:(NSNotification*)notify
{
    //视频播放对象
    MPMoviePlayerController* theMovie = [notify object];
    //销毁播放通知
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerPlaybackDidFinishNotification
                                                  object:theMovie];
    [theMovie.view removeFromSuperview];
    self.navigationController.navigationBar.hidden=NO;
    self.tabBarController.tabBar.hidden = NO;
    
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    // 释放视频对象，此对象由上面建立视频对象时候所alloc,在此做释放操作
    // NSLog(@"视频播放完成");
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
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
