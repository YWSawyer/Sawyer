//
//  DownAreaHandle.m
//  ICViewPager
//
//  Created by lanou3g on 14-7-24.
//  Copyright (c) 2014年 Ilter Cengiz. All rights reserved.
//

#import "DownAreaHandle.h"
#import "Area.h"
#import "City.h"
#import "Car.h"

@interface DownAreaHandle ()
@property (nonatomic, strong) NSMutableDictionary *strDic;

@end

@implementation DownAreaHandle
- (void)dealloc
{
    self.dic = nil;
    self.arr = nil;
    self.grpArr = nil;
    self.grpDic = nil;
    self.moSubSubArr = nil;
    self.strDic = nil;
}

+ (instancetype)shareHandle
{
    static DownAreaHandle *arewHandle = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (arewHandle == nil) {
            arewHandle = [[DownAreaHandle alloc]init];
            [arewHandle getDownData];
        }
    });
    return arewHandle;
}

- (void)getDownData
{
    self.strDic = [NSMutableDictionary dictionary];
    self.moSubSubArr = [NSMutableArray array];
    self.dic = [NSMutableDictionary dictionary];
    self.grpArr = [NSMutableArray array];
    self.grpDic = [NSMutableDictionary dictionary];
    self.arr = [NSMutableArray array];
    NSString *str = @"http://app.api.autohome.com.cn/autov4.0/news/province-a2-pm2-v4.0.2-ts0.html";
    NSURL *url = [NSURL URLWithString:str];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:120];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data != nil) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            [self ext_mothed:dic];
        }
    }];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)ext_mothed:(NSDictionary *)dict
{
    NSDictionary *dic = dict[@"result"];
    NSArray *array = dic[@"provinces"];
    for (NSDictionary *d in array) {
        Area *ar = [[Area alloc]init];
        ar.name = d[@"name"];
        ar.ID = d[@"id"];
        ar.firstletter = d[@"firstletter"];
        [_arr addObject:ar];
        
        NSArray *a = d[@"citys"];
        
        NSMutableArray *arr_1 = [NSMutableArray array];
        for (NSDictionary *dd in a) {
            City *city = [[City alloc]init];
            city.name = dd[@"name"];
            city.ID = dd[@"id"];
            city.firstletter = dd[@"firstletter"];
            [arr_1 addObject:city];
        }
        [_dic setObject:arr_1 forKey:ar.ID];
    }
    
    for (Area *a in _arr) {
        
        if (![_grpArr containsObject:a.firstletter]) {
            [_grpArr addObject:a.firstletter];
            [_grpArr sortUsingSelector:@selector(compare:)];
        }
    }
    for (NSString *str in _grpArr) {
        NSMutableArray *array1 = [NSMutableArray array];
        for (Area *a in _arr) {
            if ([str isEqualToString:a.firstletter]) {
                [array1 addObject:a];
            }
        }
        [_grpDic setObject:array1 forKey:str];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:DownAreaControllerRefreshData object:nil];
}




- (void)ModSubSubCar:(NSString *)st with:(NSString *)str with:(NSString *)strr with:(NSString *)numStr
{
    [_moSubSubArr removeAllObjects];
    
    NSMutableString *strNu = [NSMutableString stringWithString:numStr];
    if ([numStr intValue] < 20) {
        [strNu setString:@"20"];
    }
    [_strDic setObject:st forKey:@"st1"];
    [_strDic setObject:str forKey:@"str1"];
    [_strDic setObject:strr forKey:@"strr1"];
    
    NSString *strURL = [NSString stringWithFormat:@"http://app.api.autohome.com.cn/autov4.0/dealer/pdspecs-a2-pm2-v4.0.2-pi0-c0-o0-b%@-ss%@-sp%@-p1-s%@.html",st,str,strr,strNu];
    
    NSURL *url = [NSURL URLWithString:strURL];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:80];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSDictionary *dict = dic[@"result"];
            NSArray *array = dict[@"carlist"];
            
            for (NSDictionary *dd in array) {
                NSMutableArray *arr_1 = [NSMutableArray array];
                
                Car *a = [[Car alloc] init];
                a.articleid = dd[@"articleid"];
                
                
                a.dealerprice = dd[@"dealerprice"];
                a.fctprice = dd[@"fctprice"];
                a.enddate = dd[@"enddate"];
                a.orderrangetitle = dd[@"orderrangetitle"];
                a.specid = dd[@"specid"];
                a.seriesid = dd[@"seriesid"];
                a.imgurl = dd[@"specpic"];
                a.styledinventorystate = dd[@"styledinventorystate"];
                a.specname = dd[@"specname"];
                a.seriesname = dd[@"seriesname"];
                a.specpic = dd[@"specpic"];
                
                NSDictionary *d = dd[@"dealer"];
                
                a.city = d[@"city"];
                a.Id = d[@"id"];
                a.name = d[@"name"];
//                a.specprice = d[@"specprice"];
                a.phone = d[@"phone"];
                a.orderrange = d[@"orderrange"];
                [arr_1 addObject:a];
                [_moSubSubArr addObject:a];
                
            }
            
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:MoControllerChange111 object:nil];
    }];
}


- (void)getDownCarData:(NSString *)str withID:(NSString *)ID
{
    _moSubSubArr = nil;
    NSString *st1 = _strDic[@"st1"];
    NSString *str1 = _strDic[@"str1"];
    NSString *strr1 = _strDic[@"strr1"];
    
    
    
    NSMutableString *st_1 = [NSMutableString stringWithFormat:@"0"];
    NSMutableString *str_1 = [NSMutableString stringWithFormat:@"0"];
    NSMutableString *strr_1 = [NSMutableString stringWithFormat:@"0"];
    
    if (st1 && str1 && strr1) {
        st_1 = [NSMutableString stringWithFormat:@"%@",st1];
        str_1 = [NSMutableString stringWithFormat:@"%@",str1];
        strr_1 = [NSMutableString stringWithFormat:@"%@",strr1];
    }

    NSLog(@"%@   %@",ID,str);
    NSString *strUrl = [NSString stringWithFormat:@"http://app.api.autohome.com.cn/autov4.0/dealer/pdspecs-a2-pm2-v4.0.2-pi%@-c%@-o0-b%@-ss%@-sp%@-p1-s20.html",str,ID,st_1,str_1,strr_1];
    NSURL *url = [NSURL URLWithString:strUrl];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:120];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if (data != nil) {
            
            [self mothed:dic withKey:str];
        }
        
    }];
}


- (void)mothed:(NSDictionary *)dic withKey:(NSString *)str
{
    NSDictionary *dict = dic[@"result"];
    NSArray *ar = dict[@"carlist"];
    NSMutableArray *arrayCar = [NSMutableArray array];
    //降价
    if (ar.count != 0) {
        for (NSDictionary *dic1 in ar) {
            Car *a = [[Car alloc] init];
            a.articleid = dic1[@"articleid"];
            a.seriesname = dic1[@"seriesname"];
            a.orderrangetitle = dic1[@"orderrangetitle"];
            a.specpic = dic1[@"specpic"];
            a.styledinventorystate = dic1[@"styledinventorystate"];
            a.enddate = dic1[@"enddate"];
            a.dealerprice = dic1[@"dealerprice"];
            a.fctprice = dic1[@"fctprice"];
            a.specname = dic1[@"specname"];
            a.seriesid = dic1[@"specid"];
            a.specid = dic1[@"specid"];
            
            NSDictionary *d = dic1[@"dealer"];
            a.city = d[@"city"];
            a.Id = d[@"id"];
            a.is24hour = d[@"is24hour"];
            a.name = d[@"name"];
            a.orderrange = d[@"orderrange"];
            a.phone = d[@"phone"];
            a.shortname = d[@"shortname"];
            
            
            [arrayCar addObject:a];
            [_moSubSubArr addObject:a];
        }
    }
    

    [[NSNotificationCenter defaultCenter] postNotificationName:MoControllerChange111 object:nil];
    
}



@end
