//
//  ImageMaskViewController.m
//  maskDemo
//
//  Created by 居祎炜 on 2018/4/24.
//  Copyright © 2018年 居祎炜. All rights reserved.
//

#import "ImageMaskViewController.h"

@interface ImageMaskViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *baseView;
@property (weak, nonatomic) IBOutlet UIImageView *baseView2;

@end

@implementation ImageMaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 只用了 透明
    UIImageView *maskView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mask"]];
    maskView.frame = self.baseView.bounds;
    self.baseView.maskView = maskView;

    
    // 透明度变化
    UIImageView *maskView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mask2"]];
    maskView2.frame = self.baseView2.bounds;
    self.baseView2.maskView = maskView2;
    
}

@end
