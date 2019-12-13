//
//  ViewController.m
//  CZMediator
//
//  Created by juyiwei on 2019/12/12.
//  Copyright © 2019 居然是村长. All rights reserved.
//

#import "ViewController.h"
#import "CTMediator+CZOrderMediator.h"
#import "CTMediator+CZShopMediator.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *menuTableView;
@property (nonatomic, strong) NSArray *menuArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.menuTableView];
    
    self.menuArr = @[@"正确情况：有参数",
                     @"正常情况：无参数",
                     
                     @"异常情况：无对象，无方法，有重写",
                     @"异常情况：有对象，无方法，有重写",
                     
                     @"异常情况：无对象，无方法，无重写",
                     @"异常情况：有对象，无方法，无重写",
                     
                     @"正常情况：URL，带参数",
                     @"正常情况：URL，不带参数",
                     
                     @"异常情况：URL 无对象",
                     @"异常情况：URL 无方法",
    ];
}

#pragma mark - Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.menuArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    cell.textLabel.text = self.menuArr[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
    UIViewController *controller;
    switch (indexPath.row) {
        case 0:
            controller = [[CTMediator sharedInstance] orderDetailControllerWithOrderId:@"123"];
            break;
        case 1:
            controller = [[CTMediator sharedInstance] orderRootController];
            break;
        case 2:
            controller = [[CTMediator sharedInstance] noTargetOrder];
            break;
        case 3:
            controller = [[CTMediator sharedInstance] noActionOrder];
            break;
        case 4:
            controller = [[CTMediator sharedInstance] noTargetShop];
            break;
        case 5:
            controller = [[CTMediator sharedInstance] noActionShop];
            break;
        case 6:
            controller = [[CTMediator sharedInstance] performActionWithUrl:[NSURL URLWithString:@"qk://Order/OPEN_API/OrderDetailControllerWithParams:?id=123"] completion:^(NSDictionary *info) {
                
            }];
            break;
            
        case 7:
            controller = [[CTMediator sharedInstance] performActionWithUrl:[NSURL URLWithString:@"qk://Order/OPEN_API/OrderRootController"] completion:^(NSDictionary *info) {
                
            }];
            break;
        case 8:
            controller = [[CTMediator sharedInstance] performActionWithUrl:[NSURL URLWithString:@"qk://Order_no/OrderRootController:?id=123"] completion:^(NSDictionary *info) {
                
            }];
            break;
        case 9:
            controller = [[CTMediator sharedInstance] performActionWithUrl:[NSURL URLWithString:@"qk://Order/OrderDetailControllerWithParams_no:?id=123"] completion:^(NSDictionary *info) {
                
            }];
            break;
    }
    
    if (controller) {
        [self.navigationController pushViewController:controller animated:YES];
    }

}

#pragma mark - Getter

- (UITableView *)menuTableView {
    if (!_menuTableView) {
        _menuTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _menuTableView.frame = self.view.bounds;
        _menuTableView.dataSource = self;
        _menuTableView.delegate = self;
        [_menuTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    return _menuTableView;
}

@end
