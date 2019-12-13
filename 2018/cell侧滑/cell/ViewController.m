//
//  ViewController.m
//  cell
//
//  Created by 居祎炜 on 16/5/30.
//  Copyright © 2016年 居祎炜. All rights reserved.
//

#import "ViewController.h"
#import "TestCell.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, SWTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"第三方库，支持左右滑动";

    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"push"
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(pushAction)];
    [self.navigationItem setRightBarButtonItem:item];
    
}

- (void)pushAction {
    [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"BViewController"] animated:YES];
}


#pragma mark - TableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TestCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TestCell"];
    
    cell.leftUtilityButtons = [self leftButtons];
    cell.rightUtilityButtons = [self rightButtons];
    cell.delegate = self;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.;
}

- (NSArray *)rightButtons {
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:0.78f green:0.78f blue:0.8f alpha:1.0]
                                                title:@"More"];
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f]
                                                title:@"Delete"];
    
    return rightUtilityButtons;
}

- (NSArray *)leftButtons {
    NSMutableArray *leftUtilityButtons = [NSMutableArray new];
    [leftUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:0.78f green:0.78f blue:0.8f alpha:1.0]
                                                title:@"More"];
    [leftUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f]
                                                title:@"Delete"];
    [leftUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:0.78f green:0.78f blue:0.8f alpha:1.0]
                                               title:@"Show"];
    
    return leftUtilityButtons;
}


#pragma mark - SWTableViewCellDelegate

// 左侧点击
- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerLeftUtilityButtonWithIndex:(NSInteger)index {
    NSLog(@"l%zi",index);
}

// 右侧点击
- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    NSLog(@"r%zi",index);
}

// 滑动状态
- (void)swipeableTableViewCell:(SWTableViewCell *)cell scrollingToState:(SWCellState)state {
    NSLog(@"state - %zi",state);
}

// 是否禁止 多选侧滑
- (BOOL)swipeableTableViewCellShouldHideUtilityButtonsOnSwipe:(SWTableViewCell *)cell {
    return YES;
}

// 是否可以侧滑
- (BOOL)swipeableTableViewCell:(SWTableViewCell *)cell canSwipeToState:(SWCellState)state {
    return YES;
}







@end
