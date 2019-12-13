//
//  CZOrderRootController.m
//  CZMediator
//
//  Created by juyiwei on 2019/12/12.
//  Copyright © 2019 居然是村长. All rights reserved.
//

#import "CZOrderRootController.h"
#import "CZOrderDetailController.h"

@interface CZOrderRootController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *orderTableView;

@end

@implementation CZOrderRootController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.orderTableView];
}

#pragma mark - Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    NSString *orderId = @(indexPath.row).stringValue;
    cell.textLabel.text = orderId;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *orderId = @(indexPath.row).stringValue;
    CZOrderDetailController  *orderDetailVc = [[CZOrderDetailController alloc] initWithOrderId:orderId];
    [self.navigationController pushViewController:orderDetailVc animated:YES];
}

#pragma mark - Getter

- (UITableView *)orderTableView {
    if (!_orderTableView) {
        _orderTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _orderTableView.frame = self.view.bounds;
        _orderTableView.dataSource = self;
        _orderTableView.delegate = self;
        [_orderTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    return _orderTableView;
}

@end
