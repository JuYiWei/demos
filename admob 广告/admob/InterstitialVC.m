//
//  InterstitialVC.m
//  admob
//
//  Created by 居祎炜 on 2018/4/23.
//  Copyright © 2018年 居祎炜. All rights reserved.
//

#import "InterstitialVC.h"
#import <GoogleMobileAds/GoogleMobileAds.h>

@interface InterstitialVC ()
@property(nonatomic, strong) GADInterstitial *interstitial;
@end

@implementation InterstitialVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.interstitial = [[GADInterstitial alloc] initWithAdUnitID:@"ca-app-pub-3940256099942544/4411468910"];
    GADRequest *request = [GADRequest request];
    request.testDevices = @[@"a79d242a754cdb888ea736f4020c2856"];
    [self.interstitial loadRequest:request];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self showI];
}

- (void)showI {
    if (self.interstitial.isReady) {
        [self.interstitial presentFromRootViewController:self];
    } else {
        NSLog(@"Ad wasn't ready");
    }
}


@end
