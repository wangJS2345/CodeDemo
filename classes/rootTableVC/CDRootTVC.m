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
    return 5;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 4) {
        NSLog(@"444444444");
        NSString *fileName = [[NSBundle mainBundle] pathForResource:@"测试文档" ofType:@".doc"];
        NSString *filePath = [fileName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url=[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@",filePath]];//filePath 这个是你下载完文件的沙盒路径
        
        
        UIDocumentInteractionController *documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:url];
        self.documentCtl = documentInteractionController;
        [documentInteractionController setDelegate:self];
        
        [documentInteractionController presentOpenInMenuFromRect:CGRectMake(Screen_Width/2, Screen_Height-300, 300, 200)  inView:self.tableView.superview animated:YES];//这里的坐标在iPhone上不起作用，只在iPad上起作用
        /*
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", @"KingsoftOfficeApp://", filePath]];
        
        //创建实例
        UIDocumentInteractionController *documentController = [UIDocumentInteractionController interactionControllerWithURL:url];
        
        //设置代理
        documentController.delegate = self;
        
        [documentController presentPreviewAnimated:YES];
        */
    }
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)documentInteractionController:(UIDocumentInteractionController *)controller willBeginSendingToApplication:(NSString *)application {
    NSString *fileName = [[NSBundle mainBundle] pathForResource:@"测试文档" ofType:@".doc"];
    NSString *filePath = [fileName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url=[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@",filePath]];
    //将要发送的应用
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL  URLWithString:@"KingsoftOfficeApp://"]]){
        NSLog(@"install--");
//        [[UIApplication sharedApplication] openURL:[NSURL  URLWithString:@"KingsoftOfficeApp://"]];
//        [[UIApplication sharedApplication] openURL:[NSURL  URLWithString:@"KingsoftOfficeApp://"] options:<#(nonnull NSDictionary<NSString *,id> *)#> completionHandler:<#^(BOOL success)completion#>];
    }else{
        NSLog(@"no---");
    }
}

//下面是他的代理方法
-(void)documentInteractionController:(UIDocumentInteractionController *)controller didEndSendingToApplication:(NSString *)application {
    //已经发送的应用
}

-(void)documentInteractionControllerDidDismissOpenInMenu: (UIDocumentInteractionController *)controller {
    
}
@end
