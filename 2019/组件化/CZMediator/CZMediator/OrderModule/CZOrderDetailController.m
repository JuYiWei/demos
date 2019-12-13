//
//  CZOrderDetailController.m
//  CZMediator
//
//  Created by juyiwei on 2019/12/12.
//  Copyright © 2019 居然是村长. All rights reserved.
//

#import "CZOrderDetailController.h"

@interface CZOrderDetailController ()

@property (nonatomic, copy) NSString *orderId;

@end

@implementation CZOrderDetailController

- (instancetype)initWithOrderId:(NSString *)orderId {
    self = [super init];
    if (self) {
        self.orderId = orderId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.testLabel.text = [NSString stringWithFormat:@"orderId:%@", self.orderId];
    });
}

@end
