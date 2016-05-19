//
//  MyTabBarController.m
//  tabBar
//
//  Created by 居祎炜 on 16/5/19.
//  Copyright © 2016年 居祎炜. All rights reserved.
//

#import "MyTabBarController.h"
#import "AViewController.h"
#import "BViewController.h"
#import "LoginViewController.h"

@interface MyTabBarController ()<UITabBarControllerDelegate>

@end

@implementation MyTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    
//    [self setViewControllers:@[] animated:YES];// 设置childViewController
    

    [self.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"%@",obj);
    }];
    
//    self.tabBar;
    self.delegate = self;

    

}


#pragma mark - 一般使用

// 是否可以点击
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
    BOOL isLogin = NO;
    // 比如没有登录不能进 B控制器
    if (!isLogin && [viewController isKindOfClass:[BViewController class]]) {
        NSLog(@"你还没登录，不能看");
        
        [self presentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"]
                           animated:YES
                         completion:nil];
        
        return NO;
    }
    
    return YES;
}

// 点击选中时
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    NSLog(@"%zi",self.selectedIndex);
    NSLog(@"%@",self.selectedViewController);
}


#pragma mark - 下面的一般不用到

// 更多 开始编辑
- (void)tabBarController:(UITabBarController *)tabBarController willBeginCustomizingViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers {
}

// 更多 将要结束编辑
- (void)tabBarController:(UITabBarController *)tabBarController willEndCustomizingViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers changed:(BOOL)changed {
}

// 更多 已经结束编辑
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers changed:(BOOL)changed {
}


// 屏幕旋转是，tabBarController 支持的方向，多选
- (UIInterfaceOrientationMask)tabBarControllerSupportedInterfaceOrientations:(UITabBarController *)tabBarController {
    return UIInterfaceOrientationMaskAll;
}

// 子视图指定方向，还跟子控制器有关，比较复杂。
- (UIInterfaceOrientation)tabBarControllerPreferredInterfaceOrientationForPresentation:(UITabBarController *)tabBarController {
    return self.selectedViewController.preferredInterfaceOrientationForPresentation;
}


#pragma mark - 下面的动画转场，在研究，好复杂的样子

//// 自定义 切换 交互式
//- (nullable id <UIViewControllerInteractiveTransitioning>)tabBarController:(UITabBarController *)tabBarController
//                               interactionControllerForAnimationController: (id <UIViewControllerAnimatedTransitioning>)animationController {
//}

//// 自定义 切换 动画
//- (nullable id <UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController
//                     animationControllerForTransitionFromViewController:(UIViewController *)fromVC
//                                                       toViewController:(UIViewController *)toVC {
//}


@end
