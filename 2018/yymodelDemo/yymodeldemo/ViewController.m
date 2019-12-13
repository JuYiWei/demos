//
//  ViewController.m
//  yymodeldemo
//
//  Created by 居祎炜 on 2017/12/13.
//  Copyright © 2017年 居祎炜. All rights reserved.
//

#import "ViewController.h"
#import "Dic2Model.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self d2m];
}



- (void)d2m {
    NSDictionary *dic = @{
                          @"id": @123456,
                          @"n": @"Harry",
                          @"g": @18,
                          @"l": @1,
                          @"b": @"2011-12-09 12:13:14",
                          @"a": @2039765.987,
                          @"account" : @{@"qq": @"qqqqq",
                                         @"wx": @"wwwww",
                                         @"sina": @"sssss"
                                         },
                          @"list": @[@{@"qq": @"qqqqq11",
                                       @"wx": @"wwwww11",
                                       @"sina": @"sssss11"
                                       },
                                     @{@"qq": @"qqqqq22",
                                       @"wx": @"wwwww22",
                                       @"sina": @"sssss22"
                                       },
                                     @{@"qq": @"qqqqq33",
                                       @"wx": @"wwwww33",
                                       @"sina": @"sssss33"
                                       }]
                          };
    
    

    Dic2Model *user = [Dic2Model yy_modelWithJSON:dic];
    
    
    
    
    NSLog(@"%@", user);
    NSLog(@"%@", user.account.qq);
    NSLog(@"%@", user.list[0]);
    AccountModel *model = user.list[0];
    NSLog(@"%@",model.qq);

}


















@end
