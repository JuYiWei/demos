//
//  QRViewController.m
//  QRCode
//
//  Created by 居祎炜 on 16/6/2.
//  Copyright © 2016年 居祎炜. All rights reserved.
//

#import "QRViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "QRScanView.h"

#define CZScanLeftAndRightPadding 30
#define CZScanTopPadding 100

@interface QRViewController ()<AVCaptureMetadataOutputObjectsDelegate>
@property (nonatomic, strong) UILabel *messageLabel;

@end

@implementation QRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"扫描二维码";
    self.view.backgroundColor = [UIColor blackColor];
    
    self.messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    self.messageLabel.center = self.view.center;
    self.messageLabel.text = @"正在加载中";
    self.messageLabel.textColor = [UIColor whiteColor];
    self.messageLabel.font = [UIFont systemFontOfSize:20];
    self.messageLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.messageLabel];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    AVAuthorizationStatus authorizationStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    switch (authorizationStatus) {
        case AVAuthorizationStatusNotDetermined: {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler: ^(BOOL granted) {
                if (granted) {
                    [self startCapture];
                } else {
                    NSLog(@"%@", @"访问受限");
                }
            }];
            break;
        }
        case AVAuthorizationStatusAuthorized: {
            [self startCapture];
            break;
        }
        case AVAuthorizationStatusRestricted:
        case AVAuthorizationStatusDenied: {
            NSLog(@"%@", @"访问受限");
            break;
        }
        default: {
            break;
        }
    }
    
}


#pragma mark - Methods

- (void)startCapture {
    dispatch_async(dispatch_get_main_queue(), ^{
        AVCaptureSession *session = [[AVCaptureSession alloc] init];
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        NSError *error;
        AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
        if (deviceInput) {
            [session addInput:deviceInput];
            
            AVCaptureMetadataOutput *metadataOutput = [[AVCaptureMetadataOutput alloc] init];
            [metadataOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
            [session addOutput:metadataOutput]; // 这行代码要在设置 metadataObjectTypes 前
            metadataOutput.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
            
            AVCaptureVideoPreviewLayer *previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
            previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
            previewLayer.frame = self.view.frame;
            [self.view.layer insertSublayer:previewLayer atIndex:0];
            
            
            CGRect rect = CGRectMake(CZScanLeftAndRightPadding, CZScanTopPadding, CGRectGetWidth([UIScreen mainScreen].bounds) - 2 * CZScanLeftAndRightPadding, CGRectGetWidth([UIScreen mainScreen].bounds) - 2 * CZScanLeftAndRightPadding);
            
            [[NSNotificationCenter defaultCenter] addObserverForName:AVCaptureInputPortFormatDescriptionDidChangeNotification
                                                              object:nil
                                                               queue:[NSOperationQueue currentQueue]
                                                          usingBlock: ^(NSNotification *_Nonnull note) {
                                                              
                                                              metadataOutput.rectOfInterest = [previewLayer metadataOutputRectOfInterestForRect:rect]; // 如果不设置，整个屏幕都可以扫
                                                          }];
            
            QRScanView *scanView = [[QRScanView alloc] initWithScanRect:rect];
            [self.view addSubview:scanView];
            
            [session startRunning];
            self.messageLabel.hidden = YES;
        } else {
            NSLog(@"%@", error);
        }
    });
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    AVMetadataMachineReadableCodeObject *metadataObject = metadataObjects.firstObject;
    if ([metadataObject.type isEqualToString:AVMetadataObjectTypeQRCode]) { // 成功后系统不会停止扫描，可以用一个变量来控制。
        if (self.scanComplete) {
            self.scanComplete(metadataObject.stringValue);
        }
        
        NSLog(@"提示扫描成功没，1秒后返回，不然刷就回去了");
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    }
}


@end





@implementation UIImage (QRScan)

- (NSString *)scanQRCodeFromImage {
    
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{ CIDetectorAccuracy:CIDetectorAccuracyHigh }];
    CIImage *image = [[CIImage alloc] initWithImage:self];
    NSArray *features = [detector featuresInImage:image];
    CIQRCodeFeature *feature = [features firstObject];
    
    if (feature) {
        return feature.messageString;
    } else {
        return @"没有二维码";
    }
}

@end


