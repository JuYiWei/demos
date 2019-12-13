//
//  NativeCell.h
//  admob
//
//  Created by 居祎炜 on 2018/4/23.
//  Copyright © 2018年 居祎炜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMobileAds/GoogleMobileAds.h>

@interface NativeCell : UITableViewCell
//@property (nonatomic, strong) GADUnifiedNativeAdView *nativeAdView;
@property (weak, nonatomic) IBOutlet GADUnifiedNativeAdView *nativeAdView;

- (void)bindUnifiedNativeAd:(GADUnifiedNativeAd *)nativeAd;

@end
