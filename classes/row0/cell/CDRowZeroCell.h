//
//  CDRowZeroCell.h
//  CodeDemo
//
//  Created by apple on 2017/3/9.
//  Copyright © 2017年 LYP. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PoemModel;

@interface CDRowZeroCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *poemerLabel;
@property (weak, nonatomic) IBOutlet UILabel *poemNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *poemContentLabel;

// 返回xib界面上写的重用cellIdentifier
+ (NSString *)cellIdentifier;

// 从xib中加载 实例化一个poemCell对象
+ (CDRowZeroCell *)poemCell;

// 参数是数据模型model对象,填充值到xib中各个控件 ,并返回封装好数据之后的,poemCell对象
- (CDRowZeroCell *)cellWithPoem:(PoemModel *)model;

@end
