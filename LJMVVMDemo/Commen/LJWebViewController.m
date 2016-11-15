//
//  LJWebViewController.m
//  LJMVVMDemo
//
//  Created by Caolongjian on 16/8/12.
//  Copyright © 2016年 Caolongjian. All rights reserved.
//

#import "LJWebViewController.h"

@interface LJWebViewController () <UIWebViewDelegate>

@property(nonatomic, strong) UIWebView *webView;

@end

@implementation LJWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"新闻详情";
    //WKWebView *webView = [[WKWebView alloc] init];
//    NSArray *arr = @[@"",@""];
//    NSString *str = arr[3];
}

- (void)setUrlString:(NSString *)urlString{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [self.webView loadRequest:request];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:YES];
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{

}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:NO];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:NO];
}

- (UIWebView *)webView{
    if (_webView == nil) {
        UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        webView.delegate = self;
        [self.view addSubview:webView];
        _webView = webView;
    }
    return _webView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
