//
//  CZBaseMediator+CZShopMediator.h
//  CZMediator
//
//  Created by juyiwei on 2019/12/12.
//  Copyright © 2019 居然是村长. All rights reserved.
//

#import "CTMediator.h"

NS_ASSUME_NONNULL_BEGIN

@interface CTMediator (CZShopMediator)

/** 店铺主入口 */
- (UIViewController *)shopRootController;

/** 无 类名，无重写测试 */
- (UIViewController *)noTargetShop;

/** 无 方法，无重写测试 */
- (UIViewController *)noActionShop;

@end

NS_ASSUME_NONNULL_END
