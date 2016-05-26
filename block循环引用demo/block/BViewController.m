//
//  BViewController.m
//  block
//
//  Created by 居祎炜 on 16/5/26.
//  Copyright © 2016年 居祎炜. All rights reserved.
//

#import "BViewController.h"
#import "TestView.h"

@interface BViewController ()

@end

@implementation BViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    TestView *testView = [[TestView alloc] initWithFrame:CGRectMake(100, 100, 300, 300)];
    [self.view addSubview:testView];
    
    
    __weak typeof(self) weakself = self;
    // 虽然这里没有显示 waring，但是，self持有testView，testView持有block，block又持有self！
    [testView testStaticBlock:^{
        self.view.backgroundColor = [UIColor redColor];
//        weakself.view.backgroundColor = [UIColor redColor];
        NSString *name = @"村长";
        NSLog(@"%@",name);
    }];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // po self
}



@end
