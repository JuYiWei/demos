//
//  AViewController.m
//  tabBar
//
//  Created by 居祎炜 on 16/5/19.
//  Copyright © 2016年 居祎炜. All rights reserved.
//

#import "AViewController.h"
#import "MyTabBar.h"

@interface AViewController ()<UITabBarDelegate>

@end

@implementation AViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    MyTabBar *tabbar = [[MyTabBar alloc] initWithFrame:CGRectMake(0, 100, CGRectGetWidth(self.view.bounds), 44)];
    [self.view addSubview:tabbar];
    
}


@end
