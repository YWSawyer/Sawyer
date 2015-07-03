//
//  TuManger.m
//  ICViewPager
//
//  Created by lanou3g on 14-7-30.
//  Copyright (c) 2014年 Ilter Cengiz. All rights reserved.
//

#import "TuManger.h"
#import "ListCar.h"
@implementation TuManger
- (void)dealloc
{
    self.arr = nil;
    self.tuArr = nil;
}
+ (instancetype)defaultsManger
{
    static TuManger *tuManger = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (tuManger == nil) {
            tuManger = [[TuManger alloc] init];
            [tuManger getData];
        }
    });
    return tuManger;
}

- (void)getData
{
    [_arr removeAllObjects];
    self.arr = [NSMutableArray array];
    NSString *str = @"http://mrobot.pcauto.com.cn/v2/photo/albums?groupId=89";
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:120];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            [self ext_mothed:dic];
        }
    }];
}

- (void)ext_mothed:(NSDictionary *)dict
{
    NSArray *arr = dict[@"groups"];
    for (NSDictionary *dd in arr) {
        ListCar *car = [[ListCar alloc] init];
        car.imgUrl = dd[@"cover"];
        car.ID = dd[@"id"];
        car.name = dd[@"name"];
        car.nubCount = dd[@"photoCount"];
        car.url = dd[@"url"];
        [_arr addObject:car];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:TukuTab object:nil];
}

- (void)getTuKu:(NSString *)str
{
    [_tuArr removeAllObjects];
    self.tuArr = [NSMutableArray array];
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:120];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            [self extMothed:dic];
        }
    }];
    
}

- (void)extMothed:(NSDictionary *)dict
{
    NSArray *arr = dict[@"photos"];
    for (NSDictionary *dd in arr) {
        ListCar *car = [[ListCar alloc] init];
        
        car.url = dd[@"thumb"];
        car.imgUrl = dd[@"url"];
        
        car.descriptions = dd[@"desc"];
        car.name = dd[@"name"];
        [_tuArr addObject:car];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:TuShow object:nil];
}



@end
