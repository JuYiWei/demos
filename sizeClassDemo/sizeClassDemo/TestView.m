//
//  TestView.m
//  sizeClassDemo
//
//  Created by 居祎炜 on 2018/4/18.
//  Copyright © 2018年 居祎炜. All rights reserved.
//

#import "TestView.h"

@implementation TestView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.borderWidth =1;
    self.layer.borderColor = [UIColor darkGrayColor].CGColor;
}

@end
