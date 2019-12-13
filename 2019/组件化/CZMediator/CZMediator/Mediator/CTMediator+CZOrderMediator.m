//
//  CTMediator+CZOrderMediator.m
//  CZMediator
//
//  Created by juyiwei on 2019/12/12.
//  Copyright © 2019 居然是村长. All rights reserved.
//

#import "CTMediator+CZOrderMediator.h"

@implementation CTMediator (CZOrderMediator)

- (UIViewController *)orderRootController {
    UIViewController *viewController = [self performTarget:@"Order"
                                                    action:@"OrderRootController"
                                                    params:@{}
                                         shouldCacheTarget:NO
                                        ];
    return viewController;
}

- (UIViewController *)orderDetailControllerWithOrderId:(NSString *)orderId {
    UIViewController *viewController = [self performTarget:@"Order"
                                                    action:@"OrderDetailControllerWithParams:"
                                                    params:@{@"id":orderId}
                                         shouldCacheTarget:NO
                                        ];
    return viewController;
}

- (UIViewController *)noTargetOrder {
    UIViewController *viewController = [self performTarget:@"Order_no"
                                                    action:@"OrderRootController"
                                                    params:@{}
                                         shouldCacheTarget:NO
                                        ];
    return viewController;
}

- (UIViewController *)noActionOrder {
    UIViewController *viewController = [self performTarget:@"Order"
                                                    action:@"OrderRootController_no"
                                                    params:@{}
                                         shouldCacheTarget:NO
                                        ];
    return viewController;
}


@end
