//
//  ViewController.m
//  block
//
//  Created by 居祎炜 on 16/5/26.
//  Copyright © 2016年 居祎炜. All rights reserved.
//

#import "ViewController.h"
#import "TestView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    
    TestView *testView = [[TestView alloc] initWithFrame:CGRectMake(100, 100, 300, 300)];
    [self.view addSubview:testView];
    
    
    [testView setInputBlock:^UIColor *{
        return [UIColor blueColor];
    }];
    
    [testView setOutputBlock:^(NSString *title) {
        NSLog(@"%@",title);
    }];
    
    [testView setDoubleBlock:^NSString *(UIButton *button, NSString *title) {
        return [NSString stringWithFormat:@"%@+%@",button.titleLabel.text,title];
    }];

    
    [TestView calculateA:2 b:-2 zero:^{
        NSLog(@"一库");
    } other:^{
        NSLog(@"a sa ki");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
