//
//  CTMediator.m
//  CTMediator
//
//  Created by casa on 16/3/13.
//  Copyright © 2016年 casa. All rights reserved.
//

#import "CTMediator.h"
#import <objc/runtime.h>
#import "Action_RemoteConfig.h"

NSString * const kCTMediatorParamsKeySwiftTargetModuleName = @"kCTMediatorParamsKeySwiftTargetModuleName";

@interface CTMediator ()

@property (nonatomic, strong) NSMutableDictionary *cachedTarget;

@end

@implementation CTMediator

#pragma mark - public methods
+ (instancetype)sharedInstance
{
    static CTMediator *mediator;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mediator = [[CTMediator alloc] init];
    });
    return mediator;
}

#pragma mark - 远程调用

- (id)performActionWithUrl:(NSURL *)url completion:(void (^)(NSDictionary *))completion
{
    // 解析 URL
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    NSString *urlString = [url query];
    NSString *targetString = url.host;
    NSString *actionName = [url.path stringByReplacingOccurrencesOfString:@"/" withString:@""];
    // 本地维护了一组合法的远程调用事件接口
    NSString *actionLocalKey = [NSString stringWithFormat:@"%@_%@", targetString, actionName];
    NSString *actionString = [[Action_RemoteConfig sharedInstance] actions][actionLocalKey];
    for (NSString *param in [urlString componentsSeparatedByString:@"&"]) {
        NSArray *elts = [param componentsSeparatedByString:@"="];
        if([elts count] < 2) continue;
        [params setObject:[elts lastObject] forKey:[elts firstObject]];
    }
    
    id result;
    if (!actionString || ![actionString isKindOfClass:[NSString class]]) {
        // 非法远程调用
        result = [self performNotFoundFinalResponseWithTargetString:targetString selectorString:actionName originParams:params];
    } else {
        // 修正 actionString，处理远程调用
        result = [self performTarget:url.host action:actionString params:params shouldCacheTarget:NO];
    }
    if (completion) {
        if (result) {
            completion(@{@"result":result});
        } else {
            completion(nil);
        }
    }
    return result;
}

#pragma mark - 本地调用

- (id)performTarget:(NSString *)targetName action:(NSString *)actionName params:(NSDictionary *)params shouldCacheTarget:(BOOL)shouldCacheTarget
{
    NSString *swiftModuleName = params[kCTMediatorParamsKeySwiftTargetModuleName];
    
    // 通用对象获取
    NSString *targetClassString = nil;
    if (swiftModuleName.length > 0) {
        targetClassString = [NSString stringWithFormat:@"%@.Target_%@", swiftModuleName, targetName];
    } else {
        targetClassString = [NSString stringWithFormat:@"Target_%@", targetName];
    }
    // 取缓存的对象
    NSObject *target = self.cachedTarget[targetClassString];
    if (target == nil) {
        Class targetClass = NSClassFromString(targetClassString);
        target = [[targetClass alloc] init];
    }

    // 通用方法获取, Action 的 ‘:’ 在外部手动添加，这样可以支持 无参数方法
    NSString *actionString = [NSString stringWithFormat:@"Action_%@", actionName];
    SEL action = NSSelectorFromString(actionString);
    
    if (target == nil) {
        // 对象不存在，转向 Target_Base 的 Action_NotFoundTarget： 统一处理
        return [self performNoTargetResponseWithTargetString:targetClassString selectorString:actionString originParams:params];
    }
    
    // 按需缓存对象
    if (shouldCacheTarget) {
        self.cachedTarget[targetClassString] = target;
    }
    
    if ([target respondsToSelector:action]) {
        // 正常情况，对象执行方法
        return [self safePerformAction:action target:target params:params];
    } else {
        // 方法不存在，转向 target 的 Action_NotFoundAction： 统一处理
        SEL action = NSSelectorFromString(@"Action_NotFoundAction:");
        if ([target respondsToSelector:action]) {
            return [self performNoActionResponseWithTargetString:targetClassString selectorString:actionString originParams:params];
        } else {
            // 转向 Target_Base 的 Action_NotFoundActionFinal： 统一处理
            [self.cachedTarget removeObjectForKey:targetClassString];
            return [self performNotFoundFinalResponseWithTargetString:targetClassString selectorString:actionString originParams:params];
        }
    }
}

#pragma mark - 清除缓存

- (void)releaseCachedTargetWithTargetName:(NSString *)targetName
{
    NSString *targetClassString = [NSString stringWithFormat:@"Target_%@", targetName];
    [self.cachedTarget removeObjectForKey:targetClassString];
}

#pragma mark - private methods

- (id)performDefaultTargetActionResponseWithDefaultTargetString:(NSString *)defaultTargetString defaultSelectorString:(NSString *)defaultSelectorString targetString:(NSString *)targetString selectorString:(NSString *)selectorString originParams:(NSDictionary *)originParams
{
    NSObject *target = [[NSClassFromString(defaultTargetString) alloc] init];
    SEL action = NSSelectorFromString(defaultSelectorString);
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"targetString"] = targetString;
    params[@"selectorString"] = selectorString;
    params[@"originParams"] = originParams;
    
    return [self safePerformAction:action target:target params:params];
}

- (id)performNoTargetResponseWithTargetString:(NSString *)targetString selectorString:(NSString *)selectorString originParams:(NSDictionary *)originParams
{
    return [self performDefaultTargetActionResponseWithDefaultTargetString:@"Target_Default"
                                                     defaultSelectorString:@"Action_NotFoundTarget:"
                                                              targetString:targetString
                                                            selectorString:selectorString
                                                              originParams:originParams];
}

- (id)performNoActionResponseWithTargetString:(NSString *)targetString selectorString:(NSString *)selectorString originParams:(NSDictionary *)originParams
{
    return [self performDefaultTargetActionResponseWithDefaultTargetString:targetString
                                                     defaultSelectorString:@"Action_NotFoundAction:"
                                                              targetString:targetString
                                                            selectorString:selectorString
                                                              originParams:originParams];
}

- (id)performNotFoundFinalResponseWithTargetString:(NSString *)targetString selectorString:(NSString *)selectorString originParams:(NSDictionary *)originParams
{
    return [self performDefaultTargetActionResponseWithDefaultTargetString:@"Target_Default"
                                                     defaultSelectorString:@"Action_NotFoundFinal:"
                                                              targetString:targetString
                                                            selectorString:selectorString
                                                              originParams:originParams];
}

- (id)safePerformAction:(SEL)action target:(NSObject *)target params:(NSDictionary *)params
{
    NSMethodSignature* methodSig = [target methodSignatureForSelector:action];
    if(methodSig == nil) {
        return nil;
    }
    const char* retType = [methodSig methodReturnType];

    if (strcmp(retType, @encode(void)) == 0) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
        [invocation setArgument:&params atIndex:2];
        [invocation setSelector:action];
        [invocation setTarget:target];
        [invocation invoke];
        return nil;
    }

    if (strcmp(retType, @encode(NSInteger)) == 0) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
        [invocation setArgument:&params atIndex:2];
        [invocation setSelector:action];
        [invocation setTarget:target];
        [invocation invoke];
        NSInteger result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }

    if (strcmp(retType, @encode(BOOL)) == 0) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
        [invocation setArgument:&params atIndex:2];
        [invocation setSelector:action];
        [invocation setTarget:target];
        [invocation invoke];
        BOOL result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }

    if (strcmp(retType, @encode(CGFloat)) == 0) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
        [invocation setArgument:&params atIndex:2];
        [invocation setSelector:action];
        [invocation setTarget:target];
        [invocation invoke];
        CGFloat result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }

    if (strcmp(retType, @encode(NSUInteger)) == 0) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
        [invocation setArgument:&params atIndex:2];
        [invocation setSelector:action];
        [invocation setTarget:target];
        [invocation invoke];
        NSUInteger result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    return [target performSelector:action withObject:params];
#pragma clang diagnostic pop
}

#pragma mark - getters and setters
- (NSMutableDictionary *)cachedTarget
{
    if (_cachedTarget == nil) {
        _cachedTarget = [[NSMutableDictionary alloc] init];
    }
    return _cachedTarget;
}

@end
