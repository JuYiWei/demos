//
//  BViewController.m
//  cell
//
//  Created by 居祎炜 on 16/5/30.
//  Copyright © 2016年 居祎炜. All rights reserved.
//

#import "BViewController.h"
#import "TestCell.h"

@interface BViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation BViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"iOS 8 以上，系统支持左滑";
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TestCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TestCell"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.;
}


-(NSArray<UITableViewRowAction*>*)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewRowAction *rowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault
                                                                         title:@"删除"
                                                                       handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
                                                                           NSLog(@"删除");
                                                                       }];
    
    UITableViewRowAction *rowActionSec = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault
                                                                            title:@"标记"
                                                                          handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
                                                                              NSLog(@"标记");
                                                                          }];
    rowActionSec.backgroundColor = [UIColor greenColor];
    NSArray *arr = @[rowAction,rowActionSec];
    return arr;
}



@end
