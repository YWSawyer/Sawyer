//http://app.api.autohome.com.cn/autov4.0/club/jingxuantopic-a2-pm2-v4.0.2-c122-p1-s20.html    改装有利
//http://app.api.autohome.com.cn/autov4.0/club/jingxuantopic-a2-pm2-v4.0.2-c187-p1-s20.html// 车木大人
//http://app.api.autohome.com.cn/autov4.0/club/jingxuantopic-a2-pm2-v4.0.2-c104-p1-s20.html 媳妇当车模
//http://app.api.autohome.com.cn/autov4.0/club/jingxuantopic-a2-pm2-v4.0.2-c121-p1-s20.html 精挑细选
//http://app.api.autohome.com.cn/autov4.0/club/jingxuantopic-a2-pm2-v4.0.2-c168-p1-s20.html 超级驾驶员
//http://app.api.autohome.com.cn/autov4.0/club/jingxuantopic-a2-pm2-v4.0.2-c106-p1-s20.html 现身说法
//http://app.api.autohome.com.cn/autov4.0/club/jingxuantopic-a2-pm2-v4.0.2-c118-p1-s20.html  高端阵地
//http://app.api.autohome.com.cn/autov4.0/club/jingxuantopic-a2-pm2-v4.0.2-c184-p1-s20.html  摩友天地
//http://app.api.autohome.com.cn/autov4.0/club/jingxuantopic-a2-pm2-v4.0.2-c110-p1-s20.html  美人记
//http://app.api.autohome.com.cn/autov4.0/club/jingxuantopic-a2-pm2-v4.0.2-c113-p1-s20.htm  海外购车
//http://app.api.autohome.com.cn/autov4.0/club/jingxuantopic-a2-pm2-v4.0.2-c112-p1-s20.html 新车直播
//  CHCarHandle.m
//http://app.api.autohome.com.cn/autov4.0/news/province-a2-pm2-v4.0.2-ts0.html 降价http://app.api.autohome.com.cn/autov4.0/dealer/pdspecs-a2-pm2-v4.0.2-pi0-c0-o0-b0-ss0-sp0-p1-s20.html
//http://app.api.autohome.com.cn/autov4.0/dealer/pdspecs-a2-pm2-v4.0.2-pi340000-c340300-o0-b0-ss0-sp0-p1-s20.html 安徽
//  QICheZhiJia
//
//  Created by lanou3g on 14-7-19.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "CHCarHandle.h"
#import "Car.h"
@interface CHCarHandle ()

@end

@implementation CHCarHandle

-(void)dealloc
{
    self.urlDic = nil;
    self.carArr = nil;
    self.carDic = nil;
}

+ (instancetype)sharedHandle
{
    static CHCarHandle *carHandle = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (carHandle == nil) {
            carHandle = [[CHCarHandle alloc] init];
            [carHandle getInfo];
        }
    });
    return carHandle;
}

- (void)getInfo
{
    self.carDic = [NSMutableDictionary dictionary];
    NSString *str1 = @"http://app.api.autohome.com.cn/autov4.0/news/newslist-a2-pm2-v4.0.2-c0-nt0-p1-s20-l0.html";
    NSString *key1 = @"最新";
    
    NSString *str2 = @"http://app.api.autohome.com.cn/autov4.0/news/videos-a2-pm2-v4.0.2-vt0-p1-s20.html";
    NSString *key2 = @"视频";
    
    NSString *str3 = @"http://app.api.autohome.com.cn/autov4.0/news/newslist-a2-pm2-v4.0.2-c0-nt1-p1-s20-l0.html";
    NSString *key3 = @"新闻";
    
    NSString *str4 = @"http://app.api.autohome.com.cn/autov4.0/news/newslist-a2-pm2-v4.0.2-c0-nt3-p1-s20-l0.html";
    NSString *key4 = @"测评";
    
    NSString *str5 = @"http://app.api.autohome.com.cn/autov4.0/news/newslist-a2-pm2-v4.0.2-c0-nt60-p1-s20-l0.html";
    NSString *key5 = @"导购";
    
    NSString *str6 = @"http://app.api.autohome.com.cn/autov4.0/news/newslist-a2-pm2-v4.0.2-c110100-nt2-p1-s20-l0.html";
    NSString *key6 = @"详情";
    
    NSString *str7 = @"http://app.api.autohome.com.cn/autov4.0/news/newslist-a2-pm2-v4.0.2-c0-nt82-p1-s20-l0.html";
    NSString *key7 = @"用车";
    
    NSString *str8 = @"http://app.api.autohome.com.cn/autov4.0/news/newslist-a2-pm2-v4.0.2-c0-nt97-p1-s20-l0.html";
    NSString *key8 = @"文化";
    
    NSString *str9 = @"http://app.api.autohome.com.cn/autov4.0/news/newslist-a2-pm2-v4.0.2-c0-nt102-p1-s20-l0.html";
    NSString *key9 = @"技术";
    
    NSString *str10 = @"http://app.api.autohome.com.cn/autov4.0/news/newslist-a2-pm2-v4.0.2-c0-nt107-p1-s20-l0.html";
    NSString *key10 = @"改装";
    
    NSString *str11 = @"http://app.api.autohome.com.cn/autov4.0/news/newslist-a2-pm2-v4.0.2-c0-nt100-p1-s20-l0.html";
    NSString *key11 = @"游记";
    
    NSString *str12 = @"http://app.api.autohome.com.cn/autov4.0/news/videos-a2-pm2-v4.0.2-vt8-p1-s20.html";
    NSString *key12 = @"原创视频";
    
    NSString *str13 = @"http://app.api.autohome.com.cn/autov4.0/news/shuokelist-a2-pm2-v4.0.2-p1-s20.html";
    NSString *key13 = @"说客";
    
//    NSString *str14 = @"http://app.api.autohome.com.cn/autov4.0/club/jingxuantopic-a2-pm2-v4.0.2-c0-p1-s20.html";
//    NSString *key14 = @"论坛";
    
    NSString *str15 = @"http://app.api.autohome.com.cn/autov4.0/club/jinghuahome-a2-pm2-v4.0.2-p1-s20.html";
    NSString *key15 = @"精华";
    
    NSString *str16 = @"http://app.api.autohome.com.cn/autov4.0/dealer/pdspecs-a2-pm2-v4.0.2-pi0-c0-o0-b0-ss0-sp0-p1-s20.html";
    NSString *key16 = @"降价";
    
    NSArray *arr = @[str1,str2,str3,str4,str5,str6,str7,str8,str9,str10,str11,str12,str13,str15,str16];
    NSArray *keyArr = @[key1,key2,key3,key4,key5,key6,key7,key8,key9,key10,key11,key12,key13,key15,key16];
    
    self.carArr = [NSMutableArray arrayWithArray:keyArr];
//    NSLog(@"%@  %@", arr,_carArr);
    self.urlDic = [NSMutableDictionary dictionaryWithObjects:arr forKeys:_carArr];
    
}

- (void)getCarData:(NSString *)str
{
    NSString *strUrl = _urlDic[str];
    NSURL *url = [NSURL URLWithString:strUrl];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:120];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (data != nil) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            [self ext_mothed:dic withKey:str];
        }
             
    }];
    
}

- (void)getDownCarData:(NSString *)str withID:(NSString *)ID
{
    self.downArr = nil;
    self.downDic = nil;
    
    self.downDic = [NSMutableDictionary dictionary];
    self.downArr = [NSMutableArray array];
    NSString *strUrl = [NSString stringWithFormat:@"http://app.api.autohome.com.cn/autov4.0/dealer/pdspecs-a2-pm2-v4.0.2-pi%@-c%@-o0-b0-ss0-sp0-p1-s20.html",str,ID];
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
            [_downArr addObject:a];
        }
    }
    
    [_downDic setObject:arrayCar forKey:str];
    [[NSNotificationCenter defaultCenter] postNotificationName:AreaChange object:nil];

}


- (void)ext_mothed:(NSDictionary *)dic withKey:(NSString *)str
{
    
    
    NSDictionary *dict = dic[@"result"];
    NSArray *array = dict[@"focusimg"];
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
            
            NSDictionary *d = dic1[@"dealer"];
            a.city = d[@"city"];
            a.Id = d[@"id"];
            a.is24hour = d[@"is24hour"];
            a.name = d[@"name"];
            a.orderrange = d[@"orderrange"];
            a.phone = d[@"phone"];
            a.shortname = d[@"shortname"];
            [arrayCar addObject:a];
        }
    }
    
    //滚动视图
    NSMutableArray *arrq = [NSMutableArray array];
    if (array.count != 0) {
        for (NSDictionary *d in array) {
            Car *a = [[Car alloc] init];
            a.Id = d[@"id"];
            a.imgurl = d[@"imgurl"];
            a.jumppage = d[@"jumppage"];
            a.mediatype = d[@"mediatype"];
            a.pagecount = d[@"pagecount"];
            a.title = d[@"title"];
            a.type = d[@"type"];
            [arrq addObject:a];
        }
        [arrayCar addObject:arrq];
    }
    
    //其他全部
    NSArray *arr = dict[@"newslist"];
    if (arr.count == 0) {
        arr = dict[@"list"];
    }
    if (arr.count != 0) {
        
        for (NSDictionary *d in arr) {
            Car *c = [[Car alloc] init];
            c.Id = d[@"id"];
            c.smallimg = d[@"smallimg"];
            c.indexdetail = d[@"indexdetail"];
            c.intacttime = d[@"intacttime"];
            c.jumppage = d[@"jumppage"];
            c.mediatype = d[@"mediatype"];
            c.playcount = d[@"playcount"];
            c.pagecount = d[@"pagecount"];
            c.replycount = d[@"replycount"];
            c.smallpic = d[@"smallpic"];
            c.imgurl = d[@"imgurl"];
            c.time = d[@"time"];
            c.title = d[@"title"];
            c.type = d[@"type"];
            c.videoaddress = d[@"videoaddress"];
            c.shareaddress = d[@"shareaddress"];
            c.nickname = d[@"nickname"];
            c.lasttime = d[@"lasttime"];
            [arrayCar addObject:c];
//            NSLog(@"%@",c);
        }
    }
    
    [_carDic setObject:arrayCar forKey:str];
    [[NSNotificationCenter defaultCenter] postNotificationName:CHFirstValueChange object:nil];
}


@end
