//
//  CZBaseMediator+CZShopMediator.m
//  CZMediator
//
//  Created by juyiwei on 2019/12/12.
//  Copyright © 2019 居然是村长. All rights reserved.
//

#import "CTMediator+CZShopMediator.h"

@implementation CTMediator (CZShopMediator)

- (UIViewController *)shopRootController {
    UIViewController *viewController = [self performTarget:@"Shop"
                                                    action:@"ShopRootController"
                                                    params:@{}
                                         shouldCacheTarget:NO
                                        ];
    return viewController;
}

- (UIViewController *)noTargetShop {
    UIViewController *viewController = [self performTarget:@"Shop_no"
                                                    action:@"ShopRootController"
                                                    params:@{}
                                         shouldCacheTarget:NO
                                        ];
    return viewController;
}

- (UIViewController *)noActionShop {
    UIViewController *viewController = [self performTarget:@"Shop"
                                                    action:@"ShopRootController_no"
                                                    params:@{}
                                         shouldCacheTarget:NO
                                        ];
    return viewController;
}

@end
