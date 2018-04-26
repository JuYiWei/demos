//
//  ViewController.m
//  lottie
//
//  Created by 居祎炜 on 2018/2/5.
//  Copyright © 2018年 居祎炜. All rights reserved.
//

#import "ViewController.h"
#import <Lottie/Lottie.h>

@interface ViewController ()
{
    
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    LOTAnimationView *animation = [LOTAnimationView animationNamed:@"data2"];
    animation.frame = self.view.bounds;
    animation.loopAnimation = YES;
    animation.backgroundColor = [UIColor redColor];
    [self.view addSubview:animation];
    
    [animation playWithCompletion:^(BOOL animationFinished) {
        
    }];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

}


@end
