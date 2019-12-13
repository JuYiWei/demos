//
//  Target_Order.h
//  CZMediator
//
//  Created by juyiwei on 2019/12/12.
//  Copyright © 2019 居然是村长. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/** 开放事件 - 订单模块 */
@interface Target_Order : NSObject

/** 订单主入口 */
- (UIViewController *)Action_OrderRootController;

/** 订单详情 */
- (UIViewController *)Action_OrderDetailControllerWithParams:(NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
