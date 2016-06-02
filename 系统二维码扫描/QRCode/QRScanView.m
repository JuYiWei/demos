//
//  QRScanView.m
//  QRCode
//
//  Created by 居祎炜 on 16/6/2.
//  Copyright © 2016年 居祎炜. All rights reserved.
//

#import "QRScanView.h"

#define CZScanBackgroundColor [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5]

@implementation QRScanView

- (void)configScanRect:(CGRect)scranRect {
    
    // 扫描区域
    UIView *sacnView = [[UIView alloc] initWithFrame:scranRect];
    sacnView.backgroundColor = [UIColor clearColor];
    [self addSubview:sacnView];
    
    
    // 下面 是 扫描周边区域，马蛋，水平不够，只好贴4个view了；
    CGRect leftRect = CGRectMake(0, 0, CGRectGetMinX(scranRect), CGRectGetHeight([UIScreen mainScreen].bounds));
    CGRect rightRect = CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds) - CGRectGetMinX(scranRect), 0, CGRectGetMinX(scranRect), CGRectGetHeight([UIScreen mainScreen].bounds));
    CGRect topRect = CGRectMake(CGRectGetMinX(scranRect), 0, CGRectGetWidth([UIScreen mainScreen].bounds) - 2 * CGRectGetMinX(scranRect), CGRectGetMinY(scranRect));
    CGRect bottomRect = CGRectMake(CGRectGetMinX(scranRect), CGRectGetMaxY(scranRect), CGRectGetWidth([UIScreen mainScreen].bounds) - 2 * CGRectGetMinX(scranRect), CGRectGetHeight(scranRect));
    
    UIView *leftView = [[UIView alloc] initWithFrame:leftRect];
    leftView.backgroundColor = CZScanBackgroundColor;
    [self addSubview:leftView];
    
    UIView *rightView = [[UIView alloc] initWithFrame:rightRect];
    rightView.backgroundColor = CZScanBackgroundColor;
    [self addSubview:rightView];
    
    UIView *topView = [[UIView alloc] initWithFrame:topRect];
    topView.backgroundColor = CZScanBackgroundColor;
    [self addSubview:topView];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:bottomRect];
    bottomView.backgroundColor = CZScanBackgroundColor;
    [self addSubview:bottomView];
    
}

- (instancetype)initWithScanRect:(CGRect)scranRect {
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        
        [self configScanRect:scranRect];
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}





@end
