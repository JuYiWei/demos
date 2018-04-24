//
//  ViewController.m
//  sizeClassDemo
//
//  Created by 居祎炜 on 2018/4/18.
//  Copyright © 2018年 居祎炜. All rights reserved.
//

#import "ViewController.h"
#import "UIView+JYWScreen.h"
#import "TestCell.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TestCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TestCell class])];
    
    return cell;
}




@end
