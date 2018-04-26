//
//  ViewController.m
//  localStringDemo
//
//  Created by 居祎炜 on 2018/4/20.
//  Copyright © 2018年 居祎炜. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
    @property (weak, nonatomic) IBOutlet UILabel *testLabel;
    @property (weak, nonatomic) IBOutlet UILabel *myLabel;
    @end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.testLabel.text = NSLocalizedString(@"test", @"local");
    self.myLabel.text = NSLocalizedStringFromTable(@"my-test", @"Test", nil);
    
    
}


@end
