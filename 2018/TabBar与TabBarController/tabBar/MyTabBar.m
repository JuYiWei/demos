//
//  MyTabBar.m
//  tabBar
//
//  Created by 居祎炜 on 16/5/20.
//  Copyright © 2016年 居祎炜. All rights reserved.
//

#import "MyTabBar.h"

@interface MyTabBar()<UITabBarDelegate>

@end

@implementation MyTabBar

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    
    UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"111"
                                                        image:[UIImage imageNamed:@"tabbar_icon0_normal"]
                                                selectedImage:[UIImage imageNamed:@"tabbar_icon0_selected"]];
    
    UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"222"
                                                        image:[UIImage imageNamed:@"tabbar_icon1_normal"]
                                                selectedImage:[UIImage imageNamed:@"tabbar_icon1_selected"]];
    
    UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"333"
                                                        image:[UIImage imageNamed:@"tabbar_icon2_normal"]
                                                selectedImage:[UIImage imageNamed:@"tabbar_icon2_selected"]];
    
    UITabBarItem *item4 = [[UITabBarItem alloc] initWithTitle:@"444"
                                                        image:[UIImage imageNamed:@"tabbar_icon3_normal"]
                                                selectedImage:[UIImage imageNamed:@"tabbar_icon3_selected"]];
    
    UITabBarItem *item5 = [[UITabBarItem alloc] initWithTitle:@"555"
                                                        image:[UIImage imageNamed:@"tabbar_icon4_normal"]
                                                selectedImage:[UIImage imageNamed:@"tabbar_icon4_selected"]];
    
    UITabBarItem *item6 = [[UITabBarItem alloc] initWithTitle:@"666"
                                                        image:[UIImage imageNamed:@"tabbar_icon5_normal"]
                                                selectedImage:[UIImage imageNamed:@"tabbar_icon5_selected"]];
    
    UITabBarItem *item7 = [[UITabBarItem alloc] initWithTitle:@"777"
                                                        image:[UIImage imageNamed:@"tabbar_icon6_normal"]
                                                selectedImage:[UIImage imageNamed:@"tabbar_icon6_selected"]];
    
    
    [self setItems:@[item1,item2,item3,item4,item5,item6,item7]];
    
    self.barStyle = UIBarStyleDefault;// 黑 和 白
    self.translucent = YES;// 透明属性
    self.delegate = self;
    self.tintColor = [UIColor redColor];// 无效了。
    self.barTintColor = [UIColor yellowColor];// Bar 的color，设置图片无效
    self.selectedImageTintColor = [UIColor greenColor];// 选中图片的 tintColor
    
    //    tabBar.selectionIndicatorImage = [UIImage imageNamed:@"navigation_backIcon"];// 默认的选中图片
    //    tabBar.backgroundImage = [UIImage imageNamed:@"navigation_backIcon"];// 背景图
    //    tabBar.shadowImage = [UIImage imageNamed:@"navigation_backIcon"];// 上面的1px阴影
    
    // item 定位
    self.itemWidth = 200.;
    self.itemSpacing = 10.;
    self.itemPositioning =  UITabBarItemPositioningCentered;// 虽然注释写了使用这种定位，可以使用上面2个属性，实测无效，请告诉我为啥
    

}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    tabBar.selectedItem.badgeValue = @([tabBar.selectedItem.badgeValue integerValue] +1).stringValue;
    tabBar.selectedItem.titlePositionAdjustment = UIOffsetMake(2, 2);
}



@end
