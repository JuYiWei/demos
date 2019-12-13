//
//  NSData+jyw_CRC.h
//  ZALockSDK_Dev
//
//  Created by 居祎炜 on 16/8/18.
//  Copyright © 2016年 居祎炜. All rights reserved.
//

#import <Foundation/Foundation.h>

// crc 校验
//https://www.lammertbies.nl/comm/info/crc-calculation.html

@interface NSData (jyw_CRC)

- (NSInteger)jyw_crc16;

- (NSInteger)jyw_crc32;



@end
