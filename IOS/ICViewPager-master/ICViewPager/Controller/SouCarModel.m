//
//  SouCarModel.m
//  ICViewPager
//
//  Created by lanou3g on 14-7-29.
//  Copyright (c) 2014年 Ilter Cengiz. All rights reserved.
//

#import "SouCarModel.h"
#import "Car.h"
#import "ListCar.h"
@implementation SouCarModel
- (void)dealloc
{
    self.carArr = nil;
    self.arr = nil;
    self.keyArr = nil;
    self.dic = nil;
    self.subKeyArr = nil;
    self.subDic = nil;
}

+ (instancetype)sharedHanle
{
    static SouCarModel *souCarModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (souCarModel == nil) {
            souCarModel = [[SouCarModel alloc] init];
            
            
            [souCarModel getData];
        }
    });
    return souCarModel;
}

- (void)getData
{
    self.subDic = [NSMutableDictionary dictionary];
    self.subKeyArr = [NSMutableArray array];
    self.carArr = [NSMutableArray array];
    
    self.keyArr = [NSMutableArray arrayWithObjects:@"价格", @"级别", @"排量", @"变速箱", nil];
    
    self.arr = [NSMutableArray array];
    
    NSArray *ar1 = @[@"5万以下",@"5-8万",@"8-10万",@"10-15万",@"15-20万",@"20-25万",@"25-35万",@"35-50万",@"50-100万",@"100万以上"];
    NSArray *key1 = @[@"?",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10"];
    
    NSMutableArray *array1 = [NSMutableArray array];
    for (int i = 0; i <ar1.count; i ++) {
        
        Car *a = [[Car alloc] init];
        a.name = ar1[i];
        a.Id = key1[i];
        
        [array1 addObject:a];
        
    }
    [_arr addObject:array1];
    
    NSArray *ar2 = @[@"微型车",@"小型车",@"紧凑型车",@"中型车",@"中大型车",@"豪华型车",@"跑车",@"MPV",@"全部SUV",@"小型SUV",@"紧凑型SUV",@"中型SUV",@"中大型SUV",@"全部尺寸SUV",@"全部商务车",@"微面",@"微卡",@"皮卡"];
    NSArray *key2 = @[@"?",@"76",@"110",@"73",@"72",@"71",@"70",@"111",@"74",@"75",@"131",@"132",@"133",@"134",@"135",@"112",@"77",@"93",@"94"];
    
    NSMutableArray *array2 = [NSMutableArray array];
    for (int i = 0; i <ar2.count; i ++) {
        Car *a = [[Car alloc] init];
        a.name = ar2[i];
        a.Id = key2[i];
        [array2 addObject:a];
    }
    
    [_arr addObject:array2];
    
    NSArray *ar3 = @[@"1.0以下",@"1.0-1.5L",@"1.5-2.0L",@"2.0-2.5L",@"2.5-3.0L",@"3.0以上"];
    NSArray *key3 = @[@"?",@"1",@"2",@"3",@"4",@"5",@"6"];
    
    NSMutableArray *array3 = [NSMutableArray array];
    for (int i = 0; i < ar3.count; i ++) {
        Car *a = [[Car alloc] init];
        a.name = ar3[i];
        a.Id = key3[i];
        [array3 addObject:a];
    }
    [_arr addObject:array3];
    
    NSArray *ar4 = @[@"手动",@"自动",@"自动AT",@"手自一体",@"无级变速",@"双离合",@"AMT",@"ISR",@"固定齿比"];
    NSArray *key4 = @[@"?",@"1",@"9999",@"2",@"3",@"4",@"5",@"6",@"8",@"7"];
    NSMutableArray *array4 = [NSMutableArray array];
    for (int i = 0; i < ar4.count; i++) {
        Car *a = [[Car alloc] init];
        a.name = ar4[i];
        a.Id = key4[i];
        
        [array4 addObject:a];
    }
    [_arr addObject:array4];
    
    self.dic = [NSMutableDictionary dictionaryWithObjects:_arr forKeys:_keyArr];
}

- (void)getTotalPrice:(NSString *)price withJb:(NSString *)jb wirhPl:(NSString *)pl withGbox:(NSString *)gbox
{
    NSMutableString *str = [NSMutableString string];
    if (price) {
        [str appendString:[NSString stringWithFormat:@"price=%@",price]];
    }
    if (jb) {
        [str appendString:[NSString stringWithFormat:@"&jb=%@",jb]];
    }
    if (pl) {
        [str appendString:[NSString stringWithFormat:@"&pl=%@",pl]];
    }
    if (gbox) {
        [str appendString:[NSString stringWithFormat:@"&bsx=%@",gbox]];
    }
    NSString *urlStr = [NSString stringWithFormat:@"http://mrobot.pcauto.com.cn/v2/price/models/search?%@&pageNo=1&fmt=total&v=4.3.0",str];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSString *totalStr = dic[@"total"];
            self.str = [NSString stringWithFormat:@"%@",totalStr];
            NSDictionary *d = [NSDictionary dictionaryWithObject:totalStr forKey:@"total"];
            [[NSNotificationCenter defaultCenter] postNotificationName:SouCarModelTotal object:nil userInfo:d];
        }
    }];
}




- (void)GetDataCarWithPrice:(NSString *)price withJb:(NSString *)jb withPl:(NSString *)pl withGbox:(NSString *)gbox
{
    [_carArr removeAllObjects];
    
    NSMutableString *stky = [NSMutableString string];
    if ([_str intValue] > 50) {
        [stky setString:@"50"];
    } else {
        [stky setString:_str];
    }
    NSMutableString *str = [NSMutableString string];
    if (price) {
        [str appendString:[NSString stringWithFormat:@"price=%@",price]];
    }
    if (jb) {
        [str appendString:[NSString stringWithFormat:@"&jb=%@",jb]];
    }
    if (pl) {
        [str appendString:[NSString stringWithFormat:@"&pl=%@",pl]];
    }
    if (gbox) {
        [str appendString:[NSString stringWithFormat:@"&bsx=%@",gbox]];
    }
    NSString *urlStr = [NSString stringWithFormat:@"http://mrobot.pcauto.com.cn/v2/price/models/search?%@&v=4.3.0&pageNo=1&pageSize=%@",str,stky];
    NSLog(@"%@",urlStr);
    
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:80];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSArray *arr = dic[@"data"];
            for (NSDictionary *d in arr) {
                ListCar *car = [[ListCar alloc] init];
                
                car.ID = d[@"serialId"];
                car.imgUrl = d[@"photo"];
                car.price = d[@"priceRange"];
                car.name = d[@"serialName"];
                [_carArr addObject:car];
            }
            
            [[NSNotificationCenter defaultCenter] postNotificationName:PushTableView object:nil];
        }
    }];
   
}

- (void)getSubSubTabData:(NSString *)str
{
    [_subKeyArr removeAllObjects];
    [_subDic removeAllObjects];
    NSString *urlStr = [NSString stringWithFormat:@"http://mrobot.pcauto.com.cn/v3/price/getModelListBySerialId_v4/%@",str];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:80];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            [self ext_mothed:dic];
        }
    }];
}

- (void)ext_mothed:(NSDictionary *)dic
{
    NSArray *arr = dic[@"sections"];
    
    for (NSDictionary *dd in arr) {
        NSString *keyStr = dd[@"title"];
        [_subKeyArr addObject:keyStr];
        NSArray *ar1 = dd[@"data"];
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *d in ar1) {
            Car *car = [[Car alloc] init];
            car.price = d[@"minPrice"];
            car.imgurl = d[@"photo"];
            car.name = d[@"title"];
            car.nickname = d[@"config"];
            car.Id = d[@"id"];
            [array addObject:car];
        }
        [_subDic setObject:array forKey:keyStr];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:subSubTabRefresh object:nil userInfo:nil];
}

@end
