//
//  DownAreaHandle.h
//  ICViewPager
//
//  Created by lanou3g on 14-7-24.
//  Copyright (c) 2014年 Ilter Cengiz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DownAreaHandle : NSObject
@property (nonatomic, strong) NSMutableArray *arr;
@property (nonatomic, strong) NSMutableDictionary *dic;
@property (nonatomic, strong) NSMutableArray *grpArr;
@property (nonatomic, strong) NSMutableDictionary *grpDic;
@property (nonatomic, strong) NSMutableArray *moSubSubArr;

//xinDownCar主界面



+ (instancetype)shareHandle;
- (void)ModSubSubCar:(NSString *)st with:(NSString *)str with:(NSString *)strr with:(NSString *)numStr;
- (void)getDownCarData:(NSString *)str withID:(NSString *)ID;
@end
