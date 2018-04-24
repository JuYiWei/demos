//
//  TestViewController.m
//  maskDemo
//
//  Created by 居祎炜 on 2018/4/24.
//  Copyright © 2018年 居祎炜. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *baseView;
@property (nonatomic, strong) UIImageView *maskView;
@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    CALayer *mask = [self mask:self.baseView];
    self.baseView.layer.mask = mask;
    
    
}

- (CALayer *)mask:(UIImageView *)imageView {
    CAShapeLayer *mask = [CAShapeLayer layer];
    CGFloat h = imageView.bounds.size.width;
    mask.frame = imageView.bounds;
    mask.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(h/2, h/2) radius:h/2 startAngle:0 endAngle:2*M_PI clockwise:YES].CGPath;
    mask.fillColor = [UIColor redColor].CGColor;
    
    return mask;
}









@end


















