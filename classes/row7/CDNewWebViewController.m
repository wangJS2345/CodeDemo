//
//  CDNewWebViewController.m
//  CodeDemo
//
//  Created by apple on 2017/4/27.
//  Copyright © 2017年 LYP. All rights reserved.
//

#import "CDNewWebViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface CDNewWebViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *rootWebView;
@property (weak, nonatomic) IBOutlet UIView *footerView;
//刷新
- (IBAction)refreshClick:(UIButton *)sender;
//后退
- (IBAction)goBackClick:(UIButton *)sender;

//前进
- (IBAction)goForwordClick:(UIButton *)sender;


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
    
//    NSString *urlString = @"http://chongci.t600.com.cn/toLogin.jsp";
//    NSURL *url = [NSURL URLWithString:urlString];
//    //    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    //    [_webView loadRequest:request];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//    NSData *data = [[NSData alloc] initWithContentsOfURL:url];
//    [request setHTTPMethod:@"POST"];
//    [request setHTTPBody:data];
//    [_rootWebView loadData:data MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:url];
    
    
    NSString *urlString = [[NSBundle mainBundle] pathForResource:@"Title" ofType:@"html"];
    NSURL *url = [NSURL fileURLWithPath:urlString];
    //    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //    [_webView loadRequest:request];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//    NSData *data = [[NSData alloc] initWithContentsOfURL:url];
    NSData *data = [[NSData alloc] initWithContentsOfFile:urlString];
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
//    __block CDNewWebViewController* blockself = self;
    JSContext *jsContext = nil;
    if (!jsContext){
        jsContext = (JSContext *)[_rootWebView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    }
    jsContext[@"sendUrlLogin"] = ^(){
        //点击登录
        NSLog(@"sendUrlLogin");
        [JSContext currentContext];
    };
    jsContext[@"sendUrlnoLogin"] = ^(){
        //点击游客登录
        NSLog(@"sendUrlnoLogin");
        [JSContext currentContext];
    };
    jsContext[@"sendMessage1"] = ^(){
        //点击游客登录
        NSLog(@"sendMessage1");
        [JSContext currentContext];
    };
    jsContext[@"loginWithoutAccount"] = ^(){
        //点击游客登录
        NSLog(@"loginWithoutAccount");
        [JSContext currentContext];
    };
    
//    jsContext[@"sendMessage3"] = ^(){
//        //点击游客登录
//        NSLog(@"sendMessage3");
//        [JSContext currentContext];
//    };
    jsContext[@"sendMessage22"] = ^(){
        //点击游客登录
        NSLog(@"sendMessage22");
        [JSContext currentContext];
    };
//    jsContext[@"sendMessage22"] = ^(NSString *data){
//        //点击游客登录
//        NSLog(@"sendMessage22======%@",data);
//        [JSContext currentContext];
//    };
    jsContext[@"login"] = ^(){
        //点击游客登录
        NSLog(@"login 用户登录");
        [JSContext currentContext];
    };
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
}

- (IBAction)refreshClick:(UIButton *)sender {
    [_rootWebView reload];
}
- (IBAction)goBackClick:(UIButton *)sender {
    [_rootWebView goBack];
}
- (IBAction)goForwordClick:(UIButton *)sender {
    [_rootWebView goForward];
}
@end
