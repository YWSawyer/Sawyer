//
//  CarManger.h
//  ICViewPager
//
//  Created by lanou3g on 14-7-22.
//  Copyright (c) 2014年 Ilter Cengiz. All rights reserved.
//http://app.api.autohome.com.cn/autov4.0/dealer/pdspecs-a2-pm2-v4.0.2-pi0-c110100-o0-b15-ss65-sp17078-p1-s20.html

#import <Foundation/Foundation.h>
#import "ListCar.h"
@interface CarManger : NSObject

+ (instancetype)defaultManger;
- (void)FindCar:(NSString *)st;
- (void)ModFinCar:(NSString *)st;//
- (void)ModSubCar:(NSString *)stt;



@property (nonatomic, strong) NSMutableArray *arr;
@property (nonatomic, strong) NSMutableDictionary *dic;

@property (nonatomic, strong) NSMutableArray *FinArr;
@property (nonatomic, strong) NSMutableDictionary *FinDic;


@property (nonatomic, strong) NSMutableArray *MoArr;//筛选车标
@property (nonatomic, strong) NSMutableDictionary *MoDic;

@property (nonatomic, strong) NSMutableArray *moSubArr;
@property (nonatomic, strong) NSMutableDictionary *moSubDic;

@property (nonatomic, strong) NSMutableDictionary *moSubSubDic;
@property (nonatomic, strong) NSMutableArray *moSubSubArr;

@end
