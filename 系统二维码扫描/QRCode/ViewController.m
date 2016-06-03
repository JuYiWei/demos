//
//  ViewController.m
//  QRCode

//
//  Created by 居祎炜 on 16/6/2.
//  Copyright © 2016年 居祎炜. All rights reserved.
//

#import "ViewController.h"
#import "QRViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *result;
@property (weak, nonatomic) IBOutlet UIImageView *qrImage;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.navigationController pushViewController:[QRViewController new] animated:YES];
    
}



- (IBAction)scanWithCamera:(id)sender {
    __weak typeof(self) weakSelf = self;
    QRViewController *qrViewController = [QRViewController new];
    [qrViewController setScanComplete:^(NSString *result) {
        weakSelf.result.text = result;
    }];
    [self.navigationController pushViewController:qrViewController animated:YES];

}

- (IBAction)scanWithImage:(id)sender {
    NSString *result = [self.qrImage.image scanQRCodeFromImage];
    self.result.text = result;
}


- (IBAction)createQRImage:(id)sender {
    
    self.qrImage.image = [UIImage createQRImageWithContent:@"瓦特" scale:5.];
}




@end
