//
//  CViewController.m
//  block
//
//  Created by 居祎炜 on 16/5/26.
//  Copyright © 2016年 居祎炜. All rights reserved.
//

#import "CViewController.h"
#import "TestView.h"

@interface CViewController ()

@end

@implementation CViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TestView *testView = [[TestView alloc] initWithFrame:CGRectMake(100, 100, 300, 300)];
    [self.view addSubview:testView];
    
    [testView testStackBlock:^(NSString *name) {
        self.view.backgroundColor = [UIColor redColor];
    }];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // po self
}


@end
