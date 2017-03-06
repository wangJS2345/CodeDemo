//
//  CheckButton.h
//  CodeDemo
//
//  Created by apple on 2017/3/6.
//  Copyright © 2017年 LYP. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "com"

@interface CheckButton : UIControl

{
    
    　　UILabel *label;
    
    　　UIImageView *icon;
    
    　　BOOL checked;
    
    　　id delegate;
    
    　　}

　　@property (retain, nonatomic) id delegate;

　　@property (retain, nonatomic) UILabel *label;

　　@property (retain, nonatomic) UIImageView *icon;

　　-(BOOL)isChecked;

　　-(void)setChecked: (BOOL)flag;

@end
