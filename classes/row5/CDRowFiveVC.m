//
//  CDRowFiveVC.m
//  CodeDemo
//
//  Created by apple on 2017/3/17.
//  Copyright © 2017年 LYP. All rights reserved.
//

#import "CDRowFiveVC.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface CDRowFiveVC () <UIWebViewDelegate>
{
    // 下载句柄
    NSURLSessionDownloadTask *_downloadTask;
}
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic ,retain)JSContext *jsContext ;

@end

@implementation CDRowFiveVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *string = @"https://www.baidu.com";
    

    NSURL *url = [NSURL URLWithString:string];
//    [[UIApplication sharedApplication] openURL:url];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
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

#pragma mark UIWebViewDelegate
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSString *urlString = webView.request.URL.relativeString;
    NSLog(@"urlString----%@",urlString);
    _jsContext = [_webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    [self jsLoadOC];
    
    
    //    [self iosLoadJS];
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    return YES;
}
#pragma mark js调iOS
- (void)jsLoadOC {
    __block CDRowFiveVC* blockself = self;
    
    
    //查看资源 下载
    _jsContext[@"downAndOpenFile"] = ^(NSString *url,NSString *pathUrl){
        [JSContext currentContext];
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString * string = [NSString stringWithString:url];
            NSLog(@"downAndOpenFile---------%@",string);
            NSString *str = [blockself getFilePathWithName:@"3.mp3" withFinder:@"Voice"];
            NSLog(@"strstrstr------%@",str);
        });
    };
    }

//根据文件名和一级目录名查找文件路径
-(NSString *)getFilePathWithName:(NSString *)fileName withFinder:(NSString *)finder{
    NSString *filePath;
    //处理中文
    filePath = [NSString stringWithFormat:@"%@/Documents/%@/%@",NSHomeDirectory(),finder,[fileName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    return filePath;
}
@end
