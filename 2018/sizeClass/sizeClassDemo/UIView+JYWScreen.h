//
//  UIView+JYWScreen.h
//  sizeClassDemo
//
//  Created by 居祎炜 on 2018/4/18.
//  Copyright © 2018年 居祎炜. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, JYWAdaptScreenWidth) {
    JYWAdaptScreenWidth320 = 320, // 4s,5,5s,se
    JYWAdaptScreenWidth375 = 375, // 6,x
    JYWAdaptScreenWidth414 = 414, // 6plus
    
    JYWAdaptScreenWidth438 = 438, // 9.7V
    JYWAdaptScreenWidth504 = 504, // 10.5V
    JYWAdaptScreenWidth639 = 639, // 12.9V
    
    JYWAdaptScreenWidth694 = 694, // 9.7H
    JYWAdaptScreenWidth782 = 782, // 10.5H
    JYWAdaptScreenWidth981 = 981, // 12.9H
    JYWAdaptScreenWidthLarge // 更大
}; // 7.9 我记得 跟 9.7 是一样的分辨率

typedef NS_ENUM(NSUInteger, JYWAdaptScreenWidthSimple) {
    JYWAdaptScreenWidthSimple300 = 320, // 4s,5,5s,se,6,x
    JYWAdaptScreenWidthSimple400 = 400, // 6plus,9.7V
    
    JYWAdaptScreenWidthSimple500 = 500, // 10.5V
    JYWAdaptScreenWidthSimple600 = 600, // 12.9V,9.7H
    JYWAdaptScreenWidthSimple700 = 700, // 10.5H
    JYWAdaptScreenWidthSimple800 = 800, // 无
    JYWAdaptScreenWidthSimple900 = 900, // 12.9H
    JYWAdaptScreenWidthSimpleLarge // 更大
};

// 一般直接使用 self.view（vc 的 view）计算屏幕宽度，用于适配
@interface UIView (JYWScreen)


/**
 详细的实际宽度结果，以真是机型宽度分类

 @return JYWAdaptScreenWidth
 */
- (JYWAdaptScreenWidth)jyw_screenWidth;



/**
 简洁的宽度结果，以宽度范围分类，粒度 100px

 @return JYWAdaptScreenWidth
 */
- (JYWAdaptScreenWidthSimple)jyw_screenWidthSymple;




@end
