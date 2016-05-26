//
//  TestView.h
//  block
//
//  Created by 居祎炜 on 16/5/26.
//  Copyright © 2016年 居祎炜. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestView : UIView


@property (nonatomic, copy) void(^outputBlock)(NSString *title);
@property (nonatomic, copy) UIColor *(^inputBlock)();
@property (nonatomic, copy) NSString *(^doubleBlock)(UIButton *button, NSString *title);


// 上面的翻译下来，set方法
- (void)setOutputBlock:(void (^)(NSString *))outputBlock;
- (void)setInputBlock:(UIColor *(^)())inputBlock;
- (void)setDoubleBlock:(NSString *(^)(UIButton *, NSString *))doubleBlock;



// 简单计算和 是否为0   (其他传入传出与上面类似)
+ (void)calculateA:(NSInteger)a
                 b:(NSInteger)b
              zero:(void(^)())zero
             other:(void(^)())other;





@end
