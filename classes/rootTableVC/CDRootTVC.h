//
//  CDRootTVC.h
//  CodeDemo
//
//  Created by apple on 2017/3/3.
//  Copyright © 2017年 LYP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuickLook/QuickLook.h>

@interface CDRootTVC : UITableViewController<UIDocumentInteractionControllerDelegate>
@property(nonatomic,strong) UIDocumentInteractionController *documentController;

@end
