//
//  ViewController.h
//  iDT
//
//  Created by 居祎炜 on 2018/1/11.
//  Copyright © 2018年 居祎炜. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


@end

@interface UIImage (info)

+(UIImage*)image:(UIImage *)image scaleToSize:(CGSize)size;
+(UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect;

@end
