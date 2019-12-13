//
//  ViewController.m
//  notification
//
//  Created by 居祎炜 on 16/5/18.
//  Copyright © 2016年 居祎炜. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"1");
    
    UILocalNotification *localNote = [[UILocalNotification alloc] init];
    
    localNote.fireDate = [NSDate dateWithTimeIntervalSinceNow:3.];
    
    localNote.alertBody = @"吃饭了吗?";
    localNote.alertAction = @"查看具体的消息";
    localNote.hasAction = YES;
    localNote.alertLaunchImage = @"icon";
    localNote.alertTitle = @"标题";
    localNote.soundName = UILocalNotificationDefaultSoundName;
    localNote.applicationIconBadgeNumber = 1;

    localNote.userInfo = @{@"name" : @"张三", @"toName" : @"李四"};
    
    localNote.repeatInterval = NSDayCalendarUnit;

    localNote.category = @"alert";
    
    
    // 3.调度通知
    [[UIApplication sharedApplication] scheduleLocalNotification:localNote];
    
}

@end
