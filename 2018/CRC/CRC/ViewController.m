//
//  ViewController.m
//  CRC
//
//  Created by 居祎炜 on 16/8/22.
//  Copyright © 2016年 居祎炜. All rights reserved.
//

#import "ViewController.h"
#import "NSData+jyw_CRC.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    


    uint8_t bytes[4] = {0x01,0x02,0x03,0x04};
    NSData *data = [NSData dataWithBytes:bytes length:4];

    NSInteger crc16 = data.jyw_crc16;
    NSInteger crc32 = data.jyw_crc32;

    
    
    





}




@end
