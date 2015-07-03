//
//  SouCarModel.h
//  ICViewPager
//
//  Created by lanou3g on 14-7-29.
//  Copyright (c) 2014年 Ilter Cengiz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SouCarModel : NSObject
+ (instancetype)sharedHanle;
@property (nonatomic, strong) NSMutableArray *arr;
@property (nonatomic, strong) NSMutableDictionary *dic;
@property (nonatomic, strong) NSMutableArray *keyArr;
@property (nonatomic, copy) NSString *str;

@property (nonatomic, strong) NSMutableArray *carArr;
@property (nonatomic, strong) NSMutableArray *subKeyArr;
@property (nonatomic, strong) NSMutableDictionary *subDic;

- (void)getTotalPrice:(NSString *)price withJb:(NSString *)jb wirhPl:(NSString *)pl withGbox:(NSString *)gbox;
- (void)GetDataCarWithPrice:(NSString *)price withJb:(NSString *)jb withPl:(NSString *)pl withGbox:(NSString *)gbox;
- (void)getSubSubTabData:(NSString *)str;
@end
