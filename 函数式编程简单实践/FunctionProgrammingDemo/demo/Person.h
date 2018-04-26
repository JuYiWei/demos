//
//  Person.h
//  FunctionProgrammingDemo
//
//  Created by 居祎炜 on 2018/4/26.
//  Copyright © 2018年 居祎炜. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Person;

typedef Person* (^eatBlock)(NSString *name);
typedef Person* (^runBlock)(NSInteger step);

@interface Person : NSObject

@property (nonatomic, copy) eatBlock eat;
@property (nonatomic, copy) runBlock run;
@property (nonatomic, copy) Person *pause;

+ (NSString *)makeMessage:(void(^)(Person *person))block;

@end
