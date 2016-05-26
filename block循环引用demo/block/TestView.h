//
//  TestView.h
//  block
//
//  Created by 居祎炜 on 16/5/26.
//  Copyright © 2016年 居祎炜. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^staticBlock)();

@interface TestView : UIView

- (void)testStaticBlock:(staticBlock)block;


@property (nonatomic, copy) void(^testMallocBlock)();


- (void)testStackBlock:(void(^)(NSString *name))block;



@end
