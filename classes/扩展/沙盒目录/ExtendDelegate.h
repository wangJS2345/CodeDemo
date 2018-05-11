//
//  ExtendDelegate.h
//  CodeDemo
//
//  Created by apple on 2018/5/11.
//  Copyright © 2018年 LYP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExtendDelegate : NSObject
//获取当前时间戳，不区分时区
+(NSString*)getCurrentTimes;
//获取当前时间戳有两种方法(以秒为单位)，区分时区
+(NSString *)getNowTimeTimestamp;

//目录获取
+(NSString *)getFilePathWithName:(NSString *)fileName withFinder:(NSString *)finder;
//新建目录
+(NSString *)createAnswerPathWithName:(NSString *)fileName withFinder:(NSString *)finder;

//查找下载文件总目录
+ (NSString *)getDownloadFilePathWithFinder:(NSString *)finder;
//获得设备型号
+ (NSString *)getCurrentDeviceModel;

//判断字符串为空
+ (BOOL)isBlankString:(NSString *)string;

//生成32位ID
+ (NSString *)ret32bitString ;

//判断主线程
+ (BOOL)isMainQueue ;
#pragma mark - 时间处理
//时间字符串转时间戳
+ (NSTimeInterval)timeValueWith:(NSString *)timeString ;
//设置view边框
- (void)setBorderWithView:(UIView *)view top:(BOOL)top left:(BOOL)left bottom:(BOOL)bottom right:(BOOL)right borderColor:(UIColor *)color borderWidth:(CGFloat)width ;
+ (void)loadBorderWithView:(UIView *)view top:(BOOL)top left:(BOOL)left bottom:(BOOL)bottom right:(BOOL)right borderColor:(UIColor *)color borderWidth:(CGFloat)width ;
//plist文件，保存选择的module、units数据
+ (NSString *)getPlistFilePath ;

@end
