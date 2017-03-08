//
//  CheckButton.h
//  CodeDemo
//
//  Created by apple on 2017/3/6.
//  Copyright © 2017年 LYP. All rights reserved.
//

typedef enum {
    CheckButtonStyleDefault = 0 ,
    CheckButtonStyleBox = 1 ,
    CheckButtonStyleRadio = 2
} CheckButtonStyle;
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface CheckButton : UIControl
{
    //UIControl* control;
    UILabel * label ;
    UIImageView * icon ;
    BOOL checked ;
    id value , delegate ;
    CheckButtonStyle style ;
    NSString * checkname ,* uncheckname ; // 勾选／反选时的图片文件名
}
@property ( retain , nonatomic ) id value,delegate;
@property ( retain , nonatomic )UILabel* label;
@property ( retain , nonatomic )UIImageView* icon;
@property ( assign )CheckButtonStyle style;
-( CheckButtonStyle )style;
-( void )setStyle:( CheckButtonStyle )st;
-( BOOL )isChecked;
-( void )setChecked:( BOOL )b;

@end
