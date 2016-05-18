//
//  AppDelegate.m
//  notification
//
//  Created by 居祎炜 on 16/5/18.
//  Copyright © 2016年 居祎炜. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [self locationNotificationConfigWithApplication:application options:launchOptions];
    
    return YES;
}

// 本地通知注册 配置
- (void)locationNotificationConfigWithApplication:(UIApplication *)application options:(NSDictionary *)launchOptions {
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        
        // categorys 可以为空，
        
        //1.创建消息上面要添加的动作(按钮的形式显示出来)
        UIMutableUserNotificationAction *action = [[UIMutableUserNotificationAction alloc] init];
        action.identifier = @"action";//按钮的标示
        action.title=@"进入app";//按钮的标题
        action.activationMode = UIUserNotificationActivationModeForeground;//当点击的时候启动程序
        //    action.authenticationRequired = YES;
        //    action.destructive = YES;
        
        UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];
        action2.identifier = @"action2";
        action2.title=@"知道了";
        action2.activationMode = UIUserNotificationActivationModeBackground;//当点击的时候不启动程序，在后台处理
        action.authenticationRequired = YES;//需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
        action.destructive = YES;
        
        //2.创建动作(按钮)的类别集合
        UIMutableUserNotificationCategory *categorys = [[UIMutableUserNotificationCategory alloc] init];
        categorys.identifier = @"alert";//这组动作的唯一标示,推送通知的时候也是根据这个来区分,在使用推送时选择indentifier
        [categorys setActions:@[action,action2] forContext:(UIUserNotificationActionContextDefault)];
        
        
        //3.创建UIUserNotificationSettings，并设置消息的显示类类型
        UIUserNotificationSettings *notiSettings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIRemoteNotificationTypeSound) categories:[NSSet setWithObjects:categorys, nil]];
        
        [application registerUserNotificationSettings:notiSettings];
        
    }else{
        [application registerForRemoteNotificationTypes: UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound];
    }
    
    
    // 1.如果是正常启动应用程序,那么launchOptions参数是null;  2.如果是通过其它方式启动应用程序,那么launchOptions就值;
    if (launchOptions[UIApplicationLaunchOptionsLocalNotificationKey]) {
        // 当被杀死状态收到本地通知时执行的跳转代码
        NSLog(@"有消息，但是app是，重新启动时");
    }
    // 脚标清零
    [application setApplicationIconBadgeNumber:0];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // app 重新激活，脚标清零
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {

    // 如果是应用程序在前台,依然会收到通知,但是收到通知之后不应该跳转
    if (application.applicationState == UIApplicationStateActive) {
        NSLog(@"应用在前台");
    };
    
    if (application.applicationState == UIApplicationStateInactive) {
        // 当应用在后台收到本地通知时执行的跳转代码
        NSLog(@"应用后台点击消息时进入app");
    }
    
    // UIApplicationStateBackground 这个 多次测试，还不知道什么用，请告知。
}


// 本地通知 iOS 8 外部点击回调
- (void)application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void(^)())completionHandler {

        if ([identifier isEqualToString:@"action2"]) {
            NSLog(@"action2");
        } else {
            NSLog(@"action");
        }
    
    if (completionHandler) {
        completionHandler();
    }
}



@end
