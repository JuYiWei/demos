//
//  WebViewController.m
//  iDT
//
//  Created by 居祎炜 on 2018/1/11.
//  Copyright © 2018年 居祎炜. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSString *urlString = [NSString stringWithFormat:@"https://www.baidu.com/s?wd=%@",self.keyword];
        urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [NSURL URLWithString:urlString];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:request];
    });
}


@end
