//
//  ListCar.h
//  ICViewPager
//
//  Created by lanou3g on 14-7-23.
//  Copyright (c) 2014年 Ilter Cengiz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListCar : NSObject
//全车展示
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *imgUrl;
@property (nonatomic, copy) NSString *carName;
//搜车
@property (nonatomic, copy) NSString *levelid;
@property (nonatomic, copy) NSString *levelname;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *descriptions;
@property (nonatomic, copy) NSString *paramisshow;

@property (nonatomic, copy) NSString *nubCount;
@property (nonatomic, copy) NSString *url;
@end
