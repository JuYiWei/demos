//
//  Dic2Model.m
//  yymodeldemo
//
//  Created by 居祎炜 on 2017/12/13.
//  Copyright © 2017年 居祎炜. All rights reserved.
//

#import "Dic2Model.h"

@implementation AccountModel
- (NSString *)description { return [self yy_modelDescription]; }
@end

@implementation Dic2Model

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"userId" : @[@"id",@"ID",@"userId"],
             @"name" : @"n",
             @"age" : @"g",
             @"login" : @"l",
             @"birthDay" : @"b",
             @"birthDayString" : @"b",
             @"amount" : @"a",
             
             @"account": @"account",
             @"qq" : @"account.qq",
             @"wx" : @"account.wx",
             @"sina" : @"account.sina",
             };
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSString *birthDayString = dic[@"b"];
    if ([birthDayString isKindOfClass:[NSString class]]) {
        _birthDay = [NSDate date];// 测试修改数据而已
    }
    
    NSArray *list = dic[@"list"];
    if ([list isKindOfClass:[NSArray class]]) {
        __block NSMutableArray *arr = [NSMutableArray array];
        [list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            AccountModel *account = [AccountModel yy_modelWithJSON:obj];
            [arr addObject:account];
        }];
        _list = arr;
    }

    return YES;
}

-(nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{
             @"list"       : [AccountModel class]
             };
}

- (NSString *)description {
    return [self yy_modelDescription];
}

@end

