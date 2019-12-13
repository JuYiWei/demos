//
//  Target_Default.m
//  CZMediator
//
//  Created by juyiwei on 2019/12/12.
//  Copyright © 2019 居然是村长. All rights reserved.
//

#import "Target_Default.h"
#import "CZNotFoundController.h"

@implementation Target_Default

- (UIViewController *)Action_NotFoundAction:(id)parama {
    NSLog(@"没有方法，方法可重写 %@", parama);
    UIViewController *viewController = [[CZNotFoundController alloc] init];
    viewController.title = @"no action";
    return viewController;
}

#pragma mark - Private

- (UIViewController *)Action_NotFoundTarget:(id)parama {
    NSLog(@"没有对象 %@", parama);
    UIViewController *viewController = [[CZNotFoundController alloc] init];
        viewController.title = @"no target";
    return viewController;
}

- (UIViewController *)Action_NotFoundFinal:(id)parama {
    NSLog(@"最终处理 %@", parama);
    UIViewController *viewController = [[CZNotFoundController alloc] init];
    viewController.title = @"final";
    return viewController;
}

@end
