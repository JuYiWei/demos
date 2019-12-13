//
//  CZBaseViewController.m
//  CZMediator
//
//  Created by juyiwei on 2019/12/12.
//  Copyright © 2019 居然是村长. All rights reserved.
//

#import "CZBaseViewController.h"

@interface CZBaseViewController ()

@end

@implementation CZBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.testLabel];
    self.testLabel.text = NSStringFromClass([self class]);
}

- (UILabel *)testLabel {
    if (!_testLabel) {
        _testLabel = [[UILabel alloc] initWithFrame:self.view.bounds];
        _testLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _testLabel;
}

@end
