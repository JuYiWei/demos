//
//  Action_RemoteConfig.m
//  CZMediator
//
//  Created by juyiwei on 2019/12/13.
//  Copyright © 2019 居然是村长. All rights reserved.
//

#import "Action_RemoteConfig.h"
#import <CommonCrypto/CommonDigest.h>

@implementation Action_RemoteConfig

#pragma mark - public methods
+ (instancetype)sharedInstance
{
    static Action_RemoteConfig *config;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        config = [[Action_RemoteConfig alloc] init];
    });
    return config;
}

- (NSDictionary *)actions {
    if (!_actions) {
        _actions = @{
            [Action_RemoteConfig openAPIWithTarget:@"Order" action:@"OrderRootController"]:@"OrderRootController",
            [Action_RemoteConfig openAPIWithTarget:@"Order" action:@"OrderDetailControllerWithParams:"]:@"OrderDetailControllerWithParams:",
        };
        NSLog(@"支持的远程调用：%@", _actions);
    }
    return _actions;
}

/** 加前缀 */
+ (NSString *)openAPIWithTarget:(NSString *)targetString action:(NSString *)actionString {
    return [NSString stringWithFormat:@"%@_OPEN_API%@", targetString, actionString];
}

@end
