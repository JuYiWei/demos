//
//  NativeCell.m
//  admob
//
//  Created by 居祎炜 on 2018/4/23.
//  Copyright © 2018年 居祎炜. All rights reserved.
//

#import "NativeCell.h"
#import <GoogleMobileAds/GoogleMobileAds.h>

@interface NativeCell ()<GADVideoControllerDelegate, GADUnifiedNativeAdDelegate>

@end
@implementation NativeCell

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)bindUnifiedNativeAd:(GADUnifiedNativeAd *)nativeAd {
    NSLog(@"%@", @{@"headline": nativeAd.headline,
                   @"body": nativeAd.body,
                   @"callToAction": nativeAd.callToAction});
    
    nativeAd.delegate = self;
    
    // Populate the native ad view with the native ad assets.
    // Some assets are guaranteed to be present in every native ad.
    ((UILabel *)self.nativeAdView.headlineView).text = nativeAd.headline;
    ((UILabel *)self.nativeAdView.bodyView).text = [nativeAd.body  stringByAppendingString:@"--假装很长假装很长假装很长假装很长假装很长假装很长假装很长假装很长假装很长"];
    [((UIButton *)self.nativeAdView.callToActionView)setTitle:nativeAd.callToAction
                                                forState:UIControlStateNormal];
    
    // Some native ads include a video asset, while others do not. Apps can
    // use the GADVideoController's hasVideoContent property to determine if one
    // is present, and adjust their UI accordingly.
    
    // The UI for this controller constrains the image view's height to match the
    // media view's height, so by changing the one here, the height of both views
    // are being adjusted.
    if (nativeAd.videoController.hasVideoContent) {
        NSLog(@"hasVideoContent %@", @(nativeAd.videoController.hasVideoContent));
        self.nativeAdView.mediaView.hidden = NO;
        self.nativeAdView.imageView.hidden = YES;
        
        // This app uses a fixed width for the GADMediaView and changes its height
        // to match the aspect ratio of the video it displays.
        NSLayoutConstraint *heightConstraint =
        [NSLayoutConstraint constraintWithItem:self.nativeAdView.mediaView
                                     attribute:NSLayoutAttributeHeight
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.nativeAdView.mediaView
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
        self.nativeAdView.mediaView.hidden = YES;
        self.nativeAdView.imageView.hidden = NO;
        GADNativeAdImage *firstImage = nativeAd.images.firstObject;
        ((UIImageView *)self.nativeAdView.imageView).image = firstImage.image;
    }
    
    // These assets are not guaranteed to be present. Check that they are before
    // showing or hiding them.
    ((UIImageView *)self.nativeAdView.iconView).image = nativeAd.icon.image;
    if (nativeAd.icon != nil) {
        NSLog(@"icon %@", nativeAd.icon);
        self.nativeAdView.iconView.hidden = NO;
    } else {
        NSLog(@"no icon");
        self.nativeAdView.iconView.hidden = YES;
    }
    
    ((UIImageView *)self.nativeAdView.starRatingView).image = [UIImage imageNamed:@""];
    
    if (nativeAd.starRating) {
        NSLog(@"starRating %@", nativeAd.starRating);
        self.nativeAdView.starRatingView.hidden = NO;
    } else {
        NSLog(@"no starRating");
        self.nativeAdView.starRatingView.hidden = YES;
    }
    
    ((UILabel *)self.nativeAdView.storeView).text = nativeAd.store;
    if (nativeAd.store) {
        NSLog(@"store %@", nativeAd.store);
        self.nativeAdView.storeView.hidden = NO;
    } else {
        NSLog(@"no store");
        self.nativeAdView.storeView.hidden = YES;
    }
    
    ((UILabel *)self.nativeAdView.priceView).text = nativeAd.price;
    if (nativeAd.price) {
        NSLog(@"price %@", nativeAd.price);
        self.nativeAdView.priceView.hidden = NO;
    } else {
        NSLog(@"no price");
        self.nativeAdView.priceView.hidden = YES;
    }
    
    ((UILabel *)self.nativeAdView.advertiserView).text = nativeAd.advertiser;
    if (nativeAd.advertiser) {
        NSLog(@"advertiser %@", nativeAd.advertiser);
        self.nativeAdView.advertiserView.hidden = NO;
    } else {
        NSLog(@"no advertiser");
        self.nativeAdView.advertiserView.hidden = YES;
    }
    
    // In order for the SDK to process touch events properly, user interaction
    // should be disabled.
    self.nativeAdView.callToActionView.userInteractionEnabled = NO;
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
