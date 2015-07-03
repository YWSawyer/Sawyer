//
//  CarManger.m
//  ICViewPager
//
//  Created by lanou3g on 14-7-22.
//  Copyright (c) 2014年 Ilter Cengiz. All rights reserved.
//

#import "CarManger.h"
#import "ListCar.h"
#import "Car.h"
@interface CarManger ()
@property (nonatomic, strong) NSMutableDictionary *StrDic;
@end

@implementation CarManger
- (void)dealloc
{
    self.arr = nil;
    self.dic = nil;
    self.FinArr = nil;
    self.StrDic = nil;
    self.MoArr = nil;
    self.MoDic = nil;
    self.moSubArr = nil;
    self.moSubDic = nil;
    self.moSubSubArr = nil;
    self.moSubSubDic = nil;

}

+ (instancetype)defaultManger
{
    static CarManger *carManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (carManager == nil) {
            carManager = [[CarManger alloc] init];
            [carManager getData];
        }
    });
    return carManager;
}

- (void)getData
{
    self.arr = [NSMutableArray array];
    self.dic = [NSMutableDictionary dictionary];
    self.StrDic = [NSMutableDictionary dictionary];
   
    self.moSubSubArr = [NSMutableArray array];

    //http://app.api.autohome.com.cn/autov4.0/cars/brandsdealer-a2-pm2-v4.0.2-ts0.html
    NSString *str = @"http://app.api.autohome.com.cn/autov4.0/cars/brands-a2-pm2-v4.0.2-ts635416213335754426.html";
    NSURL *url = [NSURL URLWithString:str];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data != nil) {
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            [self ext_methed:dic];
        }
    }];
}

- (void)ext_methed:(NSDictionary *)dic
{
    NSDictionary *dict = dic[@"result"];
    NSArray *array = dict[@"brandlist"];
    
    for (NSDictionary *d in array) {
        NSString *str = d[@"letter"];
        [_arr addObject:str];
        [_arr sortUsingSelector:@selector(compare:)];
        NSArray *a = d[@"list"];
        NSMutableArray *arr = [NSMutableArray array];
        for (NSDictionary *subDic in a) {
            ListCar *car = [[ListCar alloc] init];
            
            car.ID = subDic[@"id"];
            car.imgUrl = subDic[@"imgurl"];
            car.carName = subDic[@"name"];
            [arr addObject:car];
        }
        [_dic setObject:arr forKey:str];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:TowTableViewContrellerRefreah object:nil];
}


- (void)FindCar:(NSString *)st
{
    self.FinArr = [NSMutableArray array];
    self.FinDic = [NSMutableDictionary dictionary];
    NSString *str = [NSString stringWithFormat:@"http://app.api.autohome.com.cn/autov4.0/cars/seriesprice-a2-pm2-v4.0.2-b%@-t2.html",st];
//    NSString *str = @"http://app.api.autohome.com.cn/autov4.0/cars/seriesprice-a2-pm2-v4.0.2-b35-t1.html";
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data != nil) {
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            [self getDic:dic];
        }
    }];
}

- (void)getDic:(NSDictionary *)dic
{
    NSDictionary *dict = dic[@"result"];
    NSArray *arr = dict[@"fctlist"];
    for (NSDictionary *d in arr) {
        NSString *str = d[@"name"];
        [_FinArr addObject:str];
        NSArray *array = d[@"serieslist"];
        NSMutableArray *arw = [NSMutableArray array];
        for (NSDictionary *dc in array) {
            ListCar *car = [[ListCar alloc] init];
            car.ID = dc[@"id"];
            car.name = dc[@"name"];
            car.imgUrl = dc[@"imgurl"];
            car.levelid = dc[@"levelid"];
            car.levelname = dc[@"levelname"];
            car.price = dc[@"price"];
            [arw addObject:car];
        }
        [_FinDic setObject:arw forKey:str];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:SubViewControllerReload object:nil];
}

- (void)ModFinCar:(NSString *)st
{
    _MoArr = nil;
    _MoDic = nil;
    self.MoArr = [NSMutableArray array];
    self.MoDic = [NSMutableDictionary dictionary];
    NSString *str = [NSString stringWithFormat:@"http://app.api.autohome.com.cn/autov4.0/cars/seriesprice-a2-pm2-v4.0.2-b%@-t1.html",st];
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:120];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data) {
            
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSDictionary *dict = dic[@"result"];
        NSArray *arr = dict[@"fctlist"];
        for (NSDictionary *dd in arr) {
            NSString *key = dd[@"name"];
            NSArray *a1 = dd[@"serieslist"];
            NSMutableArray *arrs = [NSMutableArray array];
            for (NSDictionary *d1 in a1) {
                ListCar *car = [[ListCar alloc] init];
                
                car.ID = d1[@"id"];
                car.levelid = d1[@"levelid"];
                car.name = d1[@"name"];
                car.levelname = d1[@"levelname"];
                car.price = d1[@"price"];
                [arrs addObject:car];
                if (![_MoArr containsObject:key]) {
                    [_MoArr addObject:key];
                }
            }
            [_MoDic setObject:arrs forKey:key];
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:MoControllerValueChange object:nil];
        }
    }];
}

- (void)ModSubCar:(NSString *)stt
{
    _moSubArr = nil;
    _moSubDic = nil;


    self.moSubArr = [NSMutableArray array];
    self.moSubDic = [NSMutableDictionary dictionary];
    NSLog(@"%@",stt);
    NSString *str = [NSString stringWithFormat:@"http://app.api.autohome.com.cn/autov4.0/cars/specslist-a2-pm2-v4.0.2-t0x000c-ss%@.html",stt];
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:80];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (data) {
            
 
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSDictionary *dict = dic[@"result"];
        NSArray *array = dict[@"list"];
        for (NSDictionary *d in array) {
            NSString *key = d[@"name"];
            NSMutableArray *ar_1 = [NSMutableArray array];
            NSArray *a = d[@"speclist"];
            for (NSDictionary *dd in a) {
                ListCar *car = [[ListCar alloc] init];
                car.descriptions = dd[@"description"];
                car.ID = dd[@"id"];
                car.name = dd[@"name"];
                car.paramisshow = dd[@"paramisshow"];
                car.price = dd[@"price"];
                [ar_1 addObject:car];
            }
 
            
            [_moSubArr addObject:key];
            [_moSubDic setObject:ar_1 forKey:key];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:MoControllerValueChange object:nil];
        }
    }];
}






@end
