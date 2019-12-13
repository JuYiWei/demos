//
//  VideoVC.m
//  admob
//
//  Created by 居祎炜 on 2018/4/23.
//  Copyright © 2018年 居祎炜. All rights reserved.
//

#import "VideoVC.h"
#import <GoogleMobileAds/GoogleMobileAds.h>

@interface VideoVC ()<GADRewardBasedVideoAdDelegate>

@end

@implementation VideoVC

- (void)viewDidLoad {
    [super viewDidLoad];

    GADRequest *request = [GADRequest request];
    request.testDevices = @[ @"a79d242a754cdb888ea736f4020c2856" ];
    [[GADRewardBasedVideoAd sharedInstance] loadRequest:request withAdUnitID:@"ca-app-pub-3940256099942544/1712485313"];
    [GADRewardBasedVideoAd sharedInstance].delegate = self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self videoShow];
}

- (void)videoShow {
    if ([[GADRewardBasedVideoAd sharedInstance] isReady]) {
        [[GADRewardBasedVideoAd sharedInstance] presentFromRootViewController:self];
    }
}

- (void)rewardBasedVideoAd:(GADRewardBasedVideoAd *)rewardBasedVideoAd didRewardUserWithReward:(GADAdReward *)reward {
    NSString *rewardMessage = [NSString stringWithFormat:@"Reward received with currency %@ , amount %lf", reward.type,[reward.amount doubleValue]];
    NSLog(rewardMessage);
}

@end
