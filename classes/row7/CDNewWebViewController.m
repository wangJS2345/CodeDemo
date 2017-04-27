//
//  CDNewWebViewController.m
//  CodeDemo
//
//  Created by apple on 2017/4/27.
//  Copyright © 2017年 LYP. All rights reserved.
//

#import "CDNewWebViewController.h"

@interface CDNewWebViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *rootWebView;

@end

@implementation CDNewWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] > 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
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
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSString *urlString = @"https://baidu.com.cn"; 
    NSURL *url = [NSURL URLWithString:urlString];
    //    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //    [_webView loadRequest:request];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSData *data = [[NSData alloc] initWithContentsOfURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:data];
    [_rootWebView loadData:data MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:url];
    
}
#pragma mark - UIWebViewDelegate 
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
      NSLog(@"ViewController:shouldStartLoadWithRequest-----%@",[NSString stringWithFormat:@"%@",request.URL.absoluteString]);
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
}

@end
