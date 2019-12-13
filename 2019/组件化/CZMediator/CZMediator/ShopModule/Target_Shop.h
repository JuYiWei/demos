//
//  Target_Shop.h
//  CZMediator
//
//  Created by juyiwei on 2019/12/12.
//  Copyright © 2019 居然是村长. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/** 开放事件 - 店铺模块 */
@interface Target_Shop : NSObject

/** 店铺主入口 */
- (UIViewController *)Action_ShopRootController;

@end

NS_ASSUME_NONNULL_END
