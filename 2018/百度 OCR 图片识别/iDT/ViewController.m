//
//  ViewController.m
//  iDT
//
//  Created by 居祎炜 on 2018/1/11.
//  Copyright © 2018年 居祎炜. All rights reserved.
//

#import "ViewController.h"
#import <AipOcrSdk/AipOcrSdk.h>
#import "WebViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()
<AVCaptureMetadataOutputObjectsDelegate, AVCaptureVideoDataOutputSampleBufferDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic,strong) AVCaptureSession * captureSession;
@property (nonatomic,strong) AVCaptureDevice * captureDevice;
@property (nonatomic, strong) AVCaptureStillImageOutput *stillImageOutput;/**< 照片输出流 */
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (nonatomic, assign) CGRect photoRect;
@property (nonatomic, assign) CGRect photoRect2;
@property (weak, nonatomic) IBOutlet UIImageView *testImageView;

@end

@implementation ViewController

- (void)loadWebSearch:(NSString *)key {
    self.webView.hidden = NO;
    NSString *urlString = [NSString stringWithFormat:@"https://www.baidu.com/s?wd=%@", key];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

- (void)hideWeb {
    self.webView.hidden = YES;
    self.startButton.backgroundColor = [UIColor blueColor];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"再来一次" style:UIBarButtonItemStylePlain target:self action:@selector(hideWeb)];
    [self.navigationItem setRightBarButtonItem:item];
    
    self.webView.hidden = YES;
    
    self.photoRect = CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), 160);
    self.photoRect2 = self.view.bounds;
    [self.view bringSubviewToFront:self.testImageView];
    
    NSString *licenseFile = [[NSBundle mainBundle] pathForResource:@"aip" ofType:@"license"];
    NSData *licenseFileData = [NSData dataWithContentsOfFile:licenseFile];
    [[AipOcrService shardService] authWithLicenseFileData:licenseFileData];
    
    AVAuthorizationStatus authorizationStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    switch (authorizationStatus) {
        case AVAuthorizationStatusNotDetermined: {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler: ^(BOOL granted) {
                
                if (granted) {
                    [self startCapture];
                } else {
//                    [PTHUD showInfoWithStatus:@"需要开启相机功能权限，请在设置处修改"];
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
//            [PTHUD showInfoWithStatus:@"需要开启相机功能权限，请在设置处修改"];
            break;
        }
        default: {
            break;
        }
    }
}

- (IBAction)takePhoto:(id)sender {
    
    self.startButton.backgroundColor = [UIColor redColor];
    
    [self takeAPicture];
}

// 开启摄像头功能
- (void)startCapture {
    self.captureSession = [[AVCaptureSession alloc] init];
    self.captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error;
    AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:self.captureDevice error:&error];
    
    if (deviceInput && [self.captureSession canAddInput:deviceInput]) {
        [self.captureSession addInput:deviceInput];
        
        AVCaptureVideoDataOutput *output = [[AVCaptureVideoDataOutput alloc] init];
        [output setSampleBufferDelegate:self queue:dispatch_get_main_queue()];
        if (output && [self.captureSession canAddOutput:output]) {
            [self.captureSession addOutput:output];
        }
        
        // 照片输出流
        self.stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
        NSDictionary *outputSettings = @{AVVideoCodecKey : AVVideoCodecJPEG};
        [self.stillImageOutput setOutputSettings:outputSettings];
        
        if ([self.captureSession canAddOutput:self.stillImageOutput]) {
            [self.captureSession addOutput:self.stillImageOutput];
        }
        
//        AVCaptureMetadataOutput *metadataOutput = [[AVCaptureMetadataOutput alloc] init];
//        [metadataOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
//        [self.captureSession addOutput:metadataOutput];
//        metadataOutput.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
        
        // 扫码有效区域
        AVCaptureVideoPreviewLayer *previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.captureSession];
        previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        previewLayer.frame = self.photoRect2;
        [self.view.layer insertSublayer:previewLayer atIndex:0];
        
        [self.captureSession startRunning];
        
    } else {
//        [PTHUD showInfoWithStatus:@"相机功能异常"];
    }
}

- (void)takeAPicture {
    AVCaptureConnection *stillImageConnection = [self.stillImageOutput connectionWithMediaType:AVMediaTypeVideo];
    [self.stillImageOutput captureStillImageAsynchronouslyFromConnection:stillImageConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        NSData *jpegData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
        UIImage *image = [UIImage imageWithData:jpegData];
        image = [UIImage imageFromImage:image inRect:self.photoRect];
        NSData *da = UIImageJPEGRepresentation(image, 0.3);
        image = [UIImage imageWithData:da];
        
        NSLog(@"%@ k", @(da.length/8/1024));
        
        self.testImageView.image = image;
        [self ocrImage:image];
    }];
}

- (void)ocrImage:(UIImage *)image {
    NSDictionary *options = @{@"language_type": @"CHN_ENG", @"detect_direction": @"true"};
    [[AipOcrService shardService] detectTextBasicFromImage:image
                                               withOptions:options
                                            successHandler:^(id result) {
                                                
                                                NSArray *arr = result[@"words_result"];
                                                __block NSString *words = @"";
                                                [arr enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                                                    words = [NSString stringWithFormat:@"%@%@", words, obj[@"words"]];
                                                }];
                                                
                                                NSLog(@"%@", words);
                                                
                                                dispatch_sync(dispatch_get_main_queue(), ^{
                                                    [self loadWebSearch:words];
                                                
//                                                    WebViewController *webVC = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([WebViewController class])];
//                                                    webVC.keyword = words;
//                                                    [self.navigationController pushViewController:webVC animated:YES];
                                                });
                                                
                                            } failHandler:^(NSError *err) {
                                                NSLog(@"%@", err);
                                            }];
}

@end


@implementation UIImage (info)

+(UIImage*)image:(UIImage *)image scaleToSize:(CGSize)size{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

+(UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect {
    
//    CGFloat scale = [UIScreen mainScreen].scale;
    CGFloat scale = 3;
    CGFloat x= rect.origin.y*scale,y=rect.origin.x*scale,w=rect.size.height*scale,h=rect.size.width*scale;
    CGRect dianRect = CGRectMake(x, y, w, h);
    
    CGImageRef sourceImageRef = [image CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, dianRect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef scale:[UIScreen mainScreen].scale orientation:UIImageOrientationRight];
    return newImage;
}

@end

