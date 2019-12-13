//
//  BViewController.m
//  ImagepdfDemo
//
//  Created by juyiwei on 2018/8/14.
//  Copyright © 2018年 居祎炜. All rights reserved.
//

#import "BViewController.h"
#import "BCell.h"

@interface BViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, assign) NSTimeInterval t;

@end

@implementation BViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.t = [[NSDate date] timeIntervalSince1970];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSTimeInterval t2 = [[NSDate date] timeIntervalSince1970];
    NSLog(@"%.3f", t2 - self.t);
}

#pragma mark - Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3000;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([BCell class]) forIndexPath:indexPath];
    cell.img.image = [UIImage imageNamed:@"test"];
    
    return cell;
}



@end
