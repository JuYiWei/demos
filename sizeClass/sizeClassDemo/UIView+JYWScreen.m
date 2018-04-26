//
//  UIView+JYWScreen.m
//  sizeClassDemo
//
//  Created by 居祎炜 on 2018/4/18.
//  Copyright © 2018年 居祎炜. All rights reserved.
//

#import "UIView+JYWScreen.h"

@implementation UIView (JYWScreen)

- (JYWAdaptScreenWidth)jyw_screenWidth {
    CGFloat width = CGRectGetWidth(self.bounds);
    JYWAdaptScreenWidth res;
    if (width <= JYWAdaptScreenWidth320) {
        res = JYWAdaptScreenWidth320;
    } else if (width <= JYWAdaptScreenWidth375) {
        res = JYWAdaptScreenWidth375;
    } else if (width <= JYWAdaptScreenWidth414) {
        res = JYWAdaptScreenWidth414;
    } else if (width <= JYWAdaptScreenWidth438) {
        res = JYWAdaptScreenWidth438;
    } else if (width <= JYWAdaptScreenWidth504) {
        res = JYWAdaptScreenWidth504;
    } else if (width <= JYWAdaptScreenWidth639) {
        res = JYWAdaptScreenWidth639;
    } else if (width <= JYWAdaptScreenWidth694) {
        res = JYWAdaptScreenWidth694;
    } else if (width <= JYWAdaptScreenWidth782) {
        res = JYWAdaptScreenWidth782;
    } else if (width <= JYWAdaptScreenWidth981) {
        res = JYWAdaptScreenWidth981;
    } else {
        res = JYWAdaptScreenWidthLarge;
    }
    
    return res;
}

- (JYWAdaptScreenWidthSimple)jyw_screenWidthSymple {
    CGFloat width = CGRectGetWidth(self.bounds);
    JYWAdaptScreenWidth res;
    if (width <= JYWAdaptScreenWidthSimple300) {
        res = JYWAdaptScreenWidthSimple300;
    } else if (width <= JYWAdaptScreenWidthSimple400) {
        res = JYWAdaptScreenWidthSimple400;
    } else if (width <= JYWAdaptScreenWidthSimple500) {
        res = JYWAdaptScreenWidthSimple500;
    } else if (width <= JYWAdaptScreenWidthSimple600) {
        res = JYWAdaptScreenWidthSimple600;
    } else if (width <= JYWAdaptScreenWidthSimple700) {
        res = JYWAdaptScreenWidthSimple700;
    } else if (width <= JYWAdaptScreenWidthSimple800) {
        res = JYWAdaptScreenWidthSimple800;
    } else if (width <= JYWAdaptScreenWidthSimple900) {
        res = JYWAdaptScreenWidthSimple900;
    } else {
        res = JYWAdaptScreenWidthSimpleLarge;
    }
    return res;
}



@end
