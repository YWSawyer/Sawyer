//
//  CHCarHandle.h
//  QICheZhiJia
//
//  Created by lanou3g on 14-7-19.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHCarHandle : NSObject

+ (instancetype)sharedHandle;
- (void)getInfo;
- (void)getCarData:(NSString *)str;

- (void)getDownCarData:(NSString *)str withID:(NSString *)ID;
@property (nonatomic,strong) NSMutableArray *carArr;//存放key
@property (nonatomic,strong) NSMutableDictionary *carDic;//存放数据
@property (nonatomic,strong) NSMutableDictionary *urlDic;//本类内部存放url

@property (nonatomic,strong) NSMutableDictionary *downDic;
@property (nonatomic,strong) NSMutableArray *downArr;
@end
