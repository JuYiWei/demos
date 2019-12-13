//
//  NativeVC.m
//  admob
//
//  Created by 居祎炜 on 2018/4/23.
//  Copyright © 2018年 居祎炜. All rights reserved.
//

#import "NativeVC.h"
#import <GoogleMobileAds/GoogleMobileAds.h>

@interface NativeVC ()<GADAdLoaderDelegate, GADUnifiedNativeAdLoaderDelegate, GADUnifiedNativeAdDelegate, GADVideoControllerDelegate>
@property (nonatomic, strong) GADAdLoader *adLoader;
@end

@implementation NativeVC

- (void)viewDidLoad {
    [super viewDidLoad];

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
    nativeAd.delegate = self;
    NSLog(@"%@", @{@"headline": nativeAd.headline,
                   @"body": nativeAd.body,
                   @"callToAction": nativeAd.callToAction});
    
    
    // Create and place ad in view hierarchy.
    GADUnifiedNativeAdView *nativeAdView =
    [[NSBundle mainBundle] loadNibNamed:@"UnifiedNativeAdView" owner:nil options:nil].firstObject;
    
    nativeAdView.frame = CGRectMake(0, 0, 300, 400);
    nativeAdView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:nativeAdView];
    
    // Populate the native ad view with the native ad assets.
    // Some assets are guaranteed to be present in every native ad.
    ((UILabel *)nativeAdView.headlineView).text = nativeAd.headline;
    ((UILabel *)nativeAdView.bodyView).text = nativeAd.body;
    [((UIButton *)nativeAdView.callToActionView)setTitle:nativeAd.callToAction
                                                forState:UIControlStateNormal];
    
    // Some native ads include a video asset, while others do not. Apps can
    // use the GADVideoController's hasVideoContent property to determine if one
    // is present, and adjust their UI accordingly.
    
    // The UI for this controller constrains the image view's height to match the
    // media view's height, so by changing the one here, the height of both views
    // are being adjusted.
    if (nativeAd.videoController.hasVideoContent) {
        NSLog(@"hasVideoContent %@", @(nativeAd.videoController.hasVideoContent));
        nativeAdView.mediaView.hidden = NO;
        nativeAdView.imageView.hidden = YES;
        
        // This app uses a fixed width for the GADMediaView and changes its height
        // to match the aspect ratio of the video it displays.
        NSLayoutConstraint *heightConstraint =
        [NSLayoutConstraint constraintWithItem:nativeAdView.mediaView
                                     attribute:NSLayoutAttributeHeight
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:nativeAdView.mediaView
                                     attribute:NSLayoutAttributeWidth
                                    multiplier:(1 / nativeAd.videoController.aspectRatio)
                                      constant:0];
        heightConstraint.active = YES;
        
        // By acting as the delegate to the GADVideoController, this ViewController
        // receives messages about events in the video lifecycle.
        nativeAd.videoController.delegate = self;
        
        
    } else {
        NSLog(@"images %@", nativeAd.images);
        // If the ad doesn't contain a video asset, the first image asset is shown
        // in the image view. The existing lower priority height constraint is used.
        nativeAdView.mediaView.hidden = YES;
        nativeAdView.imageView.hidden = NO;
        GADNativeAdImage *firstImage = nativeAd.images.firstObject;
        ((UIImageView *)nativeAdView.imageView).image = firstImage.image;
    }
    
    // These assets are not guaranteed to be present. Check that they are before
    // showing or hiding them.
    ((UIImageView *)nativeAdView.iconView).image = nativeAd.icon.image;
    if (nativeAd.icon != nil) {
        NSLog(@"icon %@", nativeAd.icon);
        nativeAdView.iconView.hidden = NO;
    } else {
        NSLog(@"no icon");
        nativeAdView.iconView.hidden = YES;
    }
    
    ((UIImageView *)nativeAdView.starRatingView).image = [UIImage imageNamed:@""];
    
    if (nativeAd.starRating) {
        NSLog(@"starRating %@", nativeAd.starRating);
        nativeAdView.starRatingView.hidden = NO;
    } else {
        NSLog(@"no starRating");
        nativeAdView.starRatingView.hidden = YES;
    }
    
    ((UILabel *)nativeAdView.storeView).text = nativeAd.store;
    if (nativeAd.store) {
        NSLog(@"store %@", nativeAd.store);
        nativeAdView.storeView.hidden = NO;
    } else {
        NSLog(@"no store");
        nativeAdView.storeView.hidden = YES;
    }
    
    ((UILabel *)nativeAdView.priceView).text = nativeAd.price;
    if (nativeAd.price) {
        NSLog(@"price %@", nativeAd.price);
        nativeAdView.priceView.hidden = NO;
    } else {
        NSLog(@"no price");
        nativeAdView.priceView.hidden = YES;
    }
    
    ((UILabel *)nativeAdView.advertiserView).text = nativeAd.advertiser;
    if (nativeAd.advertiser) {
        NSLog(@"advertiser %@", nativeAd.advertiser);
        nativeAdView.advertiserView.hidden = NO;
    } else {
        NSLog(@"no advertiser");
        nativeAdView.advertiserView.hidden = YES;
    }
    
    // In order for the SDK to process touch events properly, user interaction
    // should be disabled.
    nativeAdView.callToActionView.userInteractionEnabled = NO;
}

- (void)adLoaderDidFinishLoading:(GADAdLoader *) adLoader {
    
}


- (void)nativeAdDidRecordImpression:(GADUnifiedNativeAd *)nativeAd {
    // The native ad was shown.
}

- (void)nativeAdDidRecordClick:(GADUnifiedNativeAd *)nativeAd {
    // The native ad was clicked on.
}

- (void)nativeAdWillPresentScreen:(GADUnifiedNativeAd *)nativeAd {
    // The native ad will present a full screen view.
}

- (void)nativeAdWillDismissScreen:(GADUnifiedNativeAd *)nativeAd {
    // The native ad will dismiss a full screen view.
}

- (void)nativeAdDidDismissScreen:(GADUnifiedNativeAd *)nativeAd {
    // The native ad did dismiss a full screen view.
}

- (void)nativeAdWillLeaveApplication:(GADUnifiedNativeAd *)nativeAd {
    // The native ad will cause the application to become inactive and
    // open a new application.
}

@end
