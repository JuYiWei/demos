//
//  Target_Default.h
//  CZMediator
//
//  Created by juyiwei on 2019/12/12.
//  Copyright © 2019 居然是村长. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/** 开放事件 模块基类 */
@interface Target_Default : NSObject

/** 未找到 方法，可重写实现 */
- (UIViewController *)Action_NotFoundAction:(id)parama;

@end

NS_ASSUME_NONNULL_END
