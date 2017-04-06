//
//  CDVLCPlayVC.h
//  GKtfp
//
//  Created by apple on 2017/3/31.
//  Copyright © 2017年 LYP. All rights reserved.
//

typedef NS_ENUM(NSUInteger, Direction) {
    DirectionLeftOrRight,
    DirectionUpOrDown,
    DirectionNone
};

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface CDVLCPlayVC : UIViewController
@property (nonatomic,copy)NSDictionary *dictionary;
/*
//声明一个表示方向的变量、一个记录用户触摸视频时的坐标变量、一个记录用户触摸视频时的亮度和音量大小的变量和一个记录用户触摸屏幕是视频进度的变量
@property (assign, nonatomic) Direction direction;
@property (assign, nonatomic) CGPoint startPoint;
@property (assign, nonatomic) CGFloat startVB;
@property (assign, nonatomic) CGFloat startVideoRate;

//当用户首次触摸视频时，记录首次触摸的坐标、当前音量或者亮度、当前视频的进度，为了获取当前音量要首先定义MPVolumeView、 UISlider

@property (strong, nonatomic) UISlider* volumeViewSlider;//控制音量
*/
@end
