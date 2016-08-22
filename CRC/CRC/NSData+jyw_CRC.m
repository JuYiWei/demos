
//
//  NSData+jyw_CRC.m
//  ZALockSDK_Dev
//
//  Created by 居祎炜 on 16/8/18.
//  Copyright © 2016年 居祎炜. All rights reserved.
//

#import "NSData+jyw_CRC.h"

@implementation NSData (jyw_CRC)


#pragma mark - crc16

- (NSInteger)jyw_crc16 {
    const uint8_t *bytes = (const uint8_t *)[self bytes];
    uint16_t length = (uint16_t)[self length];
    return (NSInteger)gen_crc16(bytes, length);
}

#define CRC16 0x8005

// stackoverflow
uint16_t gen_crc16(const uint8_t *data, uint16_t size) {
    uint16_t out = 0;
    int bits_read = 0, bit_flag;
    
    if(data == NULL)
        return 0;
    
    while(size > 0){
        bit_flag = out >> 15;
        out <<= 1;
        out |= (*data >> bits_read) & 1;
        bits_read++;
        if(bits_read > 7){
            bits_read = 0;
            data++;
            size--;
        }
        if(bit_flag)
            out ^= CRC16;
    }
    
    int i;
    for (i = 0; i < 16; ++i) {
        bit_flag = out >> 15;
        out <<= 1;
        if(bit_flag)
            out ^= CRC16;
    }
    
    uint16_t crc = 0;
    i = 0x8000;
    int j = 0x0001;
    for (; i != 0; i >>=1, j <<= 1) {
        if (i & out) crc |= j;
    }
    
    return crc;
}


#pragma mark - crc32

- (NSInteger)jyw_crc32 {
    uint8_t *bytes = (uint8_t *)[self bytes];
    uint16_t length = (uint16_t)[self length];
    return (NSInteger)crc32(bytes, length);
}

static uint   CRC32[256];
static char   init = 0;
//crc32实现函数
uint crc32(uint8_t *buf, int len) {
    uint ret = 0xFFFFFFFF;
    int   i;
    if( !init ) {
        int   i,j;
        uint   crc;
        for(i = 0;i < 256;i++) {
            crc = i;
            for(j = 0;j < 8;j++) {
                if(crc & 1) {
                    crc = (crc >> 1) ^ 0xEDB88320;
                } else {
                    crc = crc >> 1;
                }
            }
            CRC32[i] = crc;
        }
        init = 1;
    }
    
    for(i = 0; i < len;i++) {
        ret = CRC32[((ret & 0xFF) ^ buf[i])] ^ (ret >> 8);
    }
    ret = ~ret;
    return ret;
}







@end
