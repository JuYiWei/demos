//
//  AvatarViewController.m
//  maskDemo
//
//  Created by 居祎炜 on 2018/4/24.
//  Copyright © 2018年 居祎炜. All rights reserved.
//

#import "LayerViewController.h"

@interface LayerViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *baseView;
@property (weak, nonatomic) IBOutlet UIImageView *baseView2;
@end

@implementation LayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.baseView.layer.mask = [self avatorMask:self.baseView];
    self.baseView2.layer.mask = [self gradientMask:self.baseView2];
}

- (CALayer *)avatorMask:(UIView *)baseView {
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = baseView.bounds;
    CGFloat w = baseView.bounds.size.width;
    CGFloat h = baseView.bounds.size.height;
    CGFloat radius = h > w ? w/2.0 : h/2.0;
    maskLayer.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(radius, radius) radius:radius startAngle:0 endAngle:2*M_PI clockwise:YES].CGPath;
    maskLayer.fillColor = [UIColor whiteColor].CGColor;
    
    return maskLayer;
}

- (CALayer *)gradientMask:(UIView *)baseView {
    CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
    gradientLayer.frame = baseView.bounds;
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithWhite:1 alpha:0.2].CGColor,
                            (__bridge id)[UIColor colorWithWhite:1 alpha:1].CGColor,
                             (__bridge id)[UIColor colorWithWhite:1 alpha:0.5].CGColor,
                            ];
    gradientLayer.locations = @[@(0.2), @(0.5), @(0.8)];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
    gradientLayer.type = kCAGradientLayerAxial;

    return gradientLayer;
}






@end
