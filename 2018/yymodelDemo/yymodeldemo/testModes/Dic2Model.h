//
//  Dic2Model.h
//  yymodeldemo
//
//  Created by 居祎炜 on 2017/12/13.
//  Copyright © 2017年 居祎炜. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYModel/YYModel.h>

@interface AccountModel : NSObject
@property (nonatomic, copy) NSString *qq;
@property (nonatomic, copy) NSString *wx;
@property (nonatomic, copy) NSString *sina;
@end


@interface Dic2Model : NSObject

// 普通字典
@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, assign, getter=isLogin) BOOL login;
@property (nonatomic, strong) NSDate *birthDay;
@property (nonatomic, copy) NSString *birthDayString;
@property (nonatomic, copy) NSDecimalNumber *amount;

// 二级字典
@property (nonatomic, copy) NSString *qq;
@property (nonatomic, copy) NSString *wx;
@property (nonatomic, copy) NSString *sina;
@property (nonatomic, strong) AccountModel *account;


// 嵌套数组，不能自动转成 modle，需要手动写
@property (nonatomic, copy) NSArray<AccountModel *> *list;


@end






