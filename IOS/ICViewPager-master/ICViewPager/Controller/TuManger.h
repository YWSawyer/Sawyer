//
//  TuManger.h
//  ICViewPager
//
//  Created by lanou3g on 14-7-30.
//  Copyright (c) 2014年 Ilter Cengiz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TuManger : NSObject

@property (nonatomic, strong) NSMutableArray *arr;

@property (nonatomic, strong) NSMutableArray *tuArr;

+ (instancetype)defaultsManger;
- (void)getTuKu:(NSString *)str;
@end
