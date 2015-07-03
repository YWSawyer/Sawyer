//
//  AppDelegate.m
//  ICViewPager
//
//  Created by Ilter Cengiz on 28/08/2013.
//  Copyright (c) 2013 Ilter Cengiz. All rights reserved.
//

#import "AppDelegate.h"
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:Nil];
    
    hostReach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    
    [hostReach startNotifier];
    // Override point for customization after application launch.
    return YES;
}
- (void)reachabilityChanged:(NSNotification *)note
{
    Reachability *curReach = [note object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    [self updateInterfaceWithReachability:curReach];
}

- (void)updateInterfaceWithReachability:(Reachability *)curReach
{
    NetworkStatus status = [curReach currentReachabilityStatus];
    //    if (status == NotReachable) {
    switch (status) {
        case NotReachable:{
            // 没有网络连接
            NSLog(@"没有网络");
            
            UIAlertView *aler = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"当前无网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
            [aler show];
            
            break;
        }
        case ReachableViaWWAN:{
            // 使用3G网络
            NSLog(@"使用3G/2G网络");
            UIAlertView *aler = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"正在使用3G/2G网络,是否继续" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
            [aler show];
            break;
        }
        case ReachableViaWiFi:
            // 使用WiFi网络
            NSLog(@"使用WiFi网络");
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.window.bounds.size.width/3, self.window.bounds.size.height - 74, self.window.bounds.size.width/3, 20)];
            label.font = [UIFont systemFontOfSize:11];
            label.textAlignment = NSTextAlignmentCenter;
            label.backgroundColor = [UIColor lightGrayColor];
            label.text = @"使用WiFi网络";
            [self.window addSubview:label];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                  sleep(3);
                dispatch_async(dispatch_get_main_queue(), ^{
                    [label removeFromSuperview];
                });
            });

            
            
            break;
    }
    //    }
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
