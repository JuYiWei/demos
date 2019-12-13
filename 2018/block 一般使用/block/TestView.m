//
//  TestView.m
//  block
//
//  Created by 居祎炜 on 16/5/26.
//  Copyright © 2016年 居祎炜. All rights reserved.
//

#import "TestView.h"

@implementation TestView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
        button1.frame = CGRectMake(0, 0, 100, 100);
        button1.backgroundColor = [UIColor redColor];
        [self addSubview:button1];
        
        
        UIButton *button2 = [UIButton buttonWithType:UIButtonTypeSystem];
        button2.frame = CGRectMake(100, 100, 100, 100);
        button2.backgroundColor = [UIColor greenColor];
        [self addSubview:button2];
        
        UIButton *button3 = [UIButton buttonWithType:UIButtonTypeSystem];
        button3.frame = CGRectMake(0, 200, 300, 100);
        button3.backgroundColor = [UIColor orangeColor];
        [button3 setTitle:@"1" forState:UIControlStateNormal];
        [self addSubview:button3];
        
        
        [button1 addTarget:self action:@selector(button1Action:) forControlEvents:UIControlEventTouchUpInside];
        [button2 addTarget:self action:@selector(button2Action:) forControlEvents:UIControlEventTouchUpInside];
        [button3 addTarget:self action:@selector(button3Action:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return self;
}

- (void)button1Action:(UIButton *)button {
    if (self.outputBlock) {
        self.outputBlock(@"输出");
    }
}

- (void)button2Action:(UIButton *)button {
    if (self.inputBlock) {
        button.backgroundColor =  self.inputBlock();
    }
}


- (void)button3Action:(UIButton *)button {
    if (self.doubleBlock) {
        [button setTitle:self.doubleBlock(button, button.titleLabel.text)
                forState:UIControlStateNormal];
    }
}



+ (void)calculateA:(NSInteger)a
                 b:(NSInteger)b
              zero:(void(^)())zero
             other:(void(^)())other {
    
    if (a + b == 0) {
        if (zero) {
            zero();
        }
        
    } else {
        if (other) {
            other();
        }
    }
}

 


@end
