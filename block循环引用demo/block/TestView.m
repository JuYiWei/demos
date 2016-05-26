//
//  TestView.m
//  block
//
//  Created by 居祎炜 on 16/5/26.
//  Copyright © 2016年 居祎炜. All rights reserved.
//

#import "TestView.h"

static staticBlock TEMPBLOCK;

@implementation TestView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
        [button1 setTitle:@"malloc" forState:UIControlStateNormal];
        button1.frame = CGRectMake(0, 0, 100, 100);
        button1.backgroundColor = [UIColor redColor];
        [self addSubview:button1];
        
        
        UIButton *button2 = [UIButton buttonWithType:UIButtonTypeSystem];
        [button2 setTitle:@"ststic" forState:UIControlStateNormal];
        button2.frame = CGRectMake(100, 100, 100, 100);
        button2.backgroundColor = [UIColor greenColor];
        [self addSubview:button2];
 
        [button1 addTarget:self action:@selector(button1Action:) forControlEvents:UIControlEventTouchUpInside];
        [button2 addTarget:self action:@selector(button2Action:) forControlEvents:UIControlEventTouchUpInside];
 
        
        
    }
    return self;
}

- (void)button1Action:(UIButton *)button {
    if (self.testMallocBlock) {
        self.testMallocBlock(button);
    }
}

- (void)button2Action:(UIButton *)button {
    if (TEMPBLOCK) {
        TEMPBLOCK();
    }
}

- (void)testStaticBlock:(staticBlock)block {
    if (block) {
        TEMPBLOCK = block;
    }
}

- (void)testStackBlock:(void(^)(NSString *name))block {
    if (block) {
        block(@"试试");
    }
}




@end
