//
//  ViewController.m
//  FunctionProgrammingDemo
//
//  Created by 居祎炜 on 2018/4/26.
//  Copyright © 2018年 居祎炜. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

typedef NSInteger(^typeOfBlock)(NSInteger a, NSInteger b);

@interface ViewController ()

@property (nonatomic, copy) NSInteger(^block)(NSInteger a, NSInteger b);
@property (nonatomic, copy) typeOfBlock typeBlock;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *resMessage = [Person makeMessage:^(Person *person) {
        person.eat(@"橘子").run(12).pause.eat(@"苹果");
    }];
    
    NSLog(@"最终结果：%@", resMessage);
    
    [self blockTest];
}


// 定义方法
- (NSInteger)sumWithA:(NSInteger)a b:(NSInteger)b {
    return a+b;
}

// 定义 block
NSInteger (^sum)(NSInteger, NSInteger) = ^(NSInteger a, NSInteger b) {
    return a+b;
};

// test
- (void)blockTest {
    NSInteger res1 = [self sumWithA:1 b:2];
    NSInteger res2 = sum(1,2);
    
    self.block = ^(NSInteger a, NSInteger b) {
        return a + b;
    };
    NSInteger res3 = self.block(1,2);
    
    
    [self setTypeBlock:^NSInteger(NSInteger a, NSInteger b) {
        NSLog(@"%zi,%zi", a, b);
        return a + b;
    }];
    
    NSInteger res4 = self.typeBlock(2, 3);
    
    NSLog(@"1");
}


// getter
//- (typeOfBlock)typeBlock {
//    return ^NSInteger(NSInteger a, NSInteger b) {
//        return a+b;
//    };
//}

// setter 1
- (void)setTypeBlock:(typeOfBlock)typeBlock {
    if (!_typeBlock) {
        _typeBlock = typeBlock;
    }
}

// setter 2
//- (void)setTypeBlock2:(typeOfBlock)typeBlock {
//    if (typeBlock) {
//        NSInteger res = typeBlock(2, 3);
//        NSLog(@"这里是 res：%zi", res);
//    }
//}


@end
