//
//  Target_Order.m
//  CZMediator
//
//  Created by juyiwei on 2019/12/12.
//  Copyright © 2019 居然是村长. All rights reserved.
//

#import "Target_Order.h"
#import "CZOrderRootController.h"
#import "CZOrderDetailController.h"

@implementation Target_Order

- (UIViewController *)Action_OrderRootController {
    CZOrderRootController *viewController = [[CZOrderRootController alloc] init];
    return viewController;
}

- (UIViewController *)Action_OrderDetailControllerWithParams:(NSDictionary *)params {
    NSString *aid = params[@"id"];
    CZOrderDetailController *viewController = [[CZOrderDetailController alloc] initWithOrderId:aid];
    return viewController;
}

#pragma mark - Rewrite

- (UIViewController *)Action_NotFoundTarget:(id)parama {
    NSLog(@"没有对象，重写一个 %@", parama);
    UIViewController *viewController = [[UIViewController alloc] init];
    viewController.view.backgroundColor = [UIColor redColor];
    return viewController;
}

- (UIViewController *)Action_NotFoundAction:(id)parama {
    NSLog(@"没有方法，重写一个 %@", parama);
    UIViewController *viewController = [[UIViewController alloc] init];
    viewController.view.backgroundColor = [UIColor orangeColor];
    return viewController;
}


@end
