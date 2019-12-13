//
//  NativeCellVC.m
//  admob
//
//  Created by 居祎炜 on 2018/4/23.
//  Copyright © 2018年 居祎炜. All rights reserved.
//

#import "NativeCellVC.h"
#import <GoogleMobileAds/GoogleMobileAds.h>
#import "NativeCell.h"

@interface NativeCellVC ()<GADAdLoaderDelegate, GADUnifiedNativeAdLoaderDelegate, UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) GADAdLoader *adLoader;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation NativeCellVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = [NSMutableArray array];
//    [self.tableView registerClass:[NativeCell class] forCellReuseIdentifier:NSStringFromClass([NativeCell class])];

    
    GADMultipleAdsAdLoaderOptions *multipleAdsOptions =
    [[GADMultipleAdsAdLoaderOptions alloc] init];
    //    multipleAdsOptions.numberOfAds = 5;
    
    self.adLoader = [[GADAdLoader alloc]
                     initWithAdUnitID:@"ca-app-pub-3940256099942544/3986624511"
                     rootViewController:self
                     adTypes:@[kGADAdLoaderAdTypeUnifiedNative]
                     options:@[multipleAdsOptions]];
    self.adLoader.delegate = self;
    
    GADRequest *request = [GADRequest request];
    request.testDevices = @[ @"a79d242a754cdb888ea736f4020c2856" ];
    [self.adLoader loadRequest:request];
}

- (void)adLoader:(GADAdLoader *)adLoader didFailToReceiveAdWithError:(GADRequestError *)error {
    
}

- (void)adLoader:(GADAdLoader *)adLoader didReceiveUnifiedNativeAd:(GADUnifiedNativeAd *)nativeAd {
//    nativeAd.delegate = self;
    [self.dataSource addObject:nativeAd];
    [self.tableView reloadData];
}

- (void)adLoaderDidFinishLoading:(GADAdLoader *) adLoader {
    
}


#pragma mark - something

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NativeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NativeCell class])];
    
    [cell bindUnifiedNativeAd:self.dataSource[indexPath.row]];
    
    return cell;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return UITableViewAutomaticDimension;
//}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}




@end
