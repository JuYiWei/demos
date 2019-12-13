//
//  CTMediator+CZOrderMediator.h
//  CZMediator
//
//  Created by juyiwei on 2019/12/12.
//  Copyright © 2019 居然是村长. All rights reserved.
//

#import "CTMediator.h"

NS_ASSUME_NONNULL_BEGIN

/** 中间者 - 订单模块 */
@interface CTMediator (CZOrderMediator)

/** 订单主入口 */
- (UIViewController *)orderRootController;

/** 订单详情 */
- (UIViewController *)orderDetailControllerWithOrderId:(NSString *)orderId;

/** 无 类名，有重写测试 */
- (UIViewController *)noTargetOrder;

/** 无 方法，有重写测试 */
- (UIViewController *)noActionOrder;

@end

NS_ASSUME_NONNULL_END
