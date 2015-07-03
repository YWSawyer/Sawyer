//
//  NowDownModel.m
//  ICViewPager
//
//  Created by lanou3g on 14-7-30.
//  Copyright (c) 2014年 Ilter Cengiz. All rights reserved.
//

#import "NowDownModel.h"
#import "Car.h"
@implementation NowDownModel
- (void)dealloc
{
    self.arr = nil;
}
+ (instancetype)defaultMange
{
    static NowDownModel *nowDownModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (nowDownModel == nil) {
            nowDownModel = [[NowDownModel alloc] init];
            [nowDownModel getDataCar];
        }
    });
    return nowDownModel;
}

- (void)getDataCar
{
    self.arr = [NSMutableArray array];
    NSString *str = @"http://api.app.yiche.com/dealer/api.ashx?method=bit.dealer.promotionranklist&cityid=201&serialid=&skip=1&sort=1&pageindex=1&pagesize=20&sign=b44cbc9a80c4b271581587fffb099527";
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:80];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            [self ext_mothed:dic];
        }
    }];
    
}

- (void)ext_mothed:(NSDictionary *)dict
{
    NSArray *arr = dict[@"Data"];
    for (NSDictionary *dic in arr) {
        Car *car = [[Car alloc] init];
        car.price = dic[@"ActPrice"];
        car.Id = dic[@"CarID"];
        car.imgurl = dic[@"CarImage"];
        car.specname = dic[@"CarName"];
        car.seriesname = dic[@"DealerName"];
        car.fctprice = dic[@"ReferPrice"];
        car.dealerprice = dic[@"ActPrice"];
        car.specpic = dic[@"CarImage"];
        car.jupURl = dic[@"NewsUrl"];
        [_arr addObject:car];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:DownPriceChangeValue object:nil];
}

@end
