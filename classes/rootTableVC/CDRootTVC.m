//
//  CDRootTVC.m
//  CodeDemo
//
//  Created by apple on 2017/3/3.
//  Copyright © 2017年 LYP. All rights reserved.
//

//获取屏幕 宽度、高度
#define Screen_Width ([UIScreen mainScreen].bounds.size.width)
#define Screen_Height ([UIScreen mainScreen].bounds.size.height)

#define WPS_Office @"KingsoftOfficeApp://"

#import "CDRootTVC.h"
#import "CDVLCPlayVC.h"

@interface CDRootTVC ()

@end

@implementation CDRootTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    return 10;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 4) {
        NSLog(@"444444444");
        NSString *fileName = [[NSBundle mainBundle] pathForResource:@"测试文档" ofType:@".doc"];
//        NSString *filePath = [fileName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *filePath = fileName;
        NSURL *url=[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@",filePath]];//filePath 这个是你下载完文件的沙盒路径
        
        UIPasteboard *pastBoard = [UIPasteboard generalPasteboard];
        [pastBoard setURL:url];
        
        NSLog(@"pastBoard.items:%@", pastBoard.items);
        NSLog(@"pastBoard.string:%@", pastBoard.string);
        NSLog(@" pastBoard.URL:%@", pastBoard.URL);
        
        /*
        // filePath 你想要用其他应用打开的文件路径
        _documentController = [UIDocumentInteractionController interactionControllerWithURL:pastBoard.URL];
        _documentController.delegate = self;
        // .UTI 表示所能支持的第三方文件打开的类型
        _documentController.UTI = @"public.data";
        // 弹出的视图的样式儿 //这里的坐标在iPhone上不起作用，只在iPad上起作用
//        [_documentController presentOpenInMenuFromRect:CGRectMake(Screen_Width/2, Screen_Height-300, 300, 200) inView:self.tableView.superview animated:YES];
        [_documentController presentOptionsMenuFromRect:CGRectMake(Screen_Width/2, Screen_Height-300, 300, 200) inView:self.tableView.superview animated:YES];
*/
        [self shareFile:fileName];
        
    }
    
    if (indexPath.row == 6) {
        UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"video" bundle:nil];
        CDVLCPlayVC * controller = [storyboard instantiateViewControllerWithIdentifier:@"CDVLCPlayVC"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"loadVideoVC"];
        [self.navigationController pushViewController:controller animated:NO];
    }
    if (indexPath.row == 7) {
        UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        CDNewWebViewController * controller = [storyboard instantiateViewControllerWithIdentifier:@"CDNewWebViewController"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"loadVideoVC"];
        [self.navigationController pushViewController:controller animated:YES];
    }
}
- (void)shareFile:(NSString *)string {
    NSString *filePath = string;
    //创建实例
    _documentController = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:filePath]];
    
    //设置代理
    _documentController.delegate = self;
    BOOL canOpen = [_documentController presentOptionsMenuFromRect:CGRectMake(Screen_Width/2, Screen_Height-300, 300, 200) inView:self.tableView.superview animated:YES];
;
    if (!canOpen) {
        NSLog(@"沒有程序可以打開要分享的文件");
    }else {
        NSLog(@"222222");
    }
}


@end
