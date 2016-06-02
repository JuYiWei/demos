//
//  QRViewController.h
//  QRCode
//
//  Created by 居祎炜 on 16/6/2.
//  Copyright © 2016年 居祎炜. All rights reserved.
//

#import <UIKit/UIKit.h>


/*!
 *  相机 扫描二维码
 */
@interface QRViewController : UIViewController

@property (nonatomic, copy) void(^scanComplete)(NSString *result);

// 扫描完成
- (void)setScanComplete:(void (^)(NSString *result))scanComplete;

@end




/*!
 *  拓展类，扫描图中二维码；注：iOS8以上能用
 */
@interface UIImage (QRScan)

/*! 扫描图中二维码 */
- (NSString *)scanQRCodeFromImage;

@end

