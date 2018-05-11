
//
//  ExtendDelegate.m
//  CodeDemo
//
//  Created by apple on 2018/5/11.
//  Copyright © 2018年 LYP. All rights reserved.
//

#import "ExtendDelegate.h"

@implementation ExtendDelegate

#pragma mark - 获取当前时间

//获取当前时间戳，不区分时区
+ (NSString*)getCurrentTimes{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    //现在时间,你可以输出来看下是什么格式
    NSDate *datenow = [NSDate date];
    //----------将nsdate按formatter格式转成nsstring
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    return currentTimeString;
}
//获取当前时间戳有两种方法(以秒为单位)，区分时区
+ (NSString *)getNowTimeTimestamp{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    //设置时区,这个对于时间的处理有时很重要
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    //现在时间,你可以输出来看下是什么格式
    NSDate *datenow = [NSDate date];
    //----------将nsdate按formatter格式转成nsstring
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    
    return timeSp;
    
}
//根据文件名和一级目录名查找文件路径 创建文件
+(NSString *)getFilePathWithName:(NSString *)fileName withFinder:(NSString *)finder{
    //    NSString *filePath;
    /*
     NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
     NSString *documentsDirectory = [paths objectAtIndex:0];
     NSString *finderName = [NSString stringWithString:finder];
     NSFileManager *fileManager = [NSFileManager defaultManager];
     NSString *path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",finderName,fileName]];
     [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
     */
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *finderName = [NSString stringWithString:finder];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *pathStr = @"";
    if ([fileName hasPrefix:finder]) {
        pathStr = fileName;
    }else {
        pathStr = [NSString stringWithFormat:@"%@/%@",finderName,fileName];
    }
    
    NSString *path = [documentsDirectory stringByAppendingPathComponent:pathStr];
    [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    //处理中文
    //    filePath = [NSString stringWithFormat:@"%@/%@/%@",string,finder,fileName];
    return path;
}
//查找下载文件总目录
+ (NSString *)getDownloadFilePathWithFinder:(NSString *)finder {
    NSString *finderName = [NSString stringWithString:finder];
    NSString *string = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *path = [string stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",finderName]];
    [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    
    //处理中文
    //    filePath = [NSString stringWithFormat:@"%@/%@/%@",string,finder,fileName];
    return path;
}
//新建目录
+(NSString *)createAnswerPathWithName:(NSString *)fileName withFinder:(NSString *)finder {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *finderName = [NSString stringWithString:finder];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@/答题",finderName,fileName]];
    [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    return path;
}
//判断字符串为空
+ (BOOL)isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([string isEqual:[NSNull null]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        return YES;
    }
    if ([string isEqualToString:@"(null)"]) {
        return YES;
    }
    return NO;
}
#pragma mark -
/*
 //图文混排
 + (NSMutableAttributedString *)coreTextWith:(NSString *)string   withFinder:(NSString *)finder  withUUID:(NSString *)uuid{
 NSString *uuidString = [NSString stringWithString:uuid];
 NSString *texString = [NSString stringWithString:string];
 NSString *finderString = [NSString stringWithString:finder];
 
 //图片目录
 NSString *finderPath = [TQJExtendDelegate getFilePathWithName: uuidString withFinder:finderString];
 NSString *filePath = [finderPath stringByAppendingPathComponent:uuidString];
 
 NSMutableArray *imageArray = [NSMutableArray arrayWithCapacity:0];
 
 NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:texString];
 
 NSError *error = nil;
 NSRegularExpression *regularExp = [[NSRegularExpression alloc] initWithPattern:img_az options:NSRegularExpressionCaseInsensitive error:&error];
 if (error) {
 return attributeString;
 }else {
 NSArray *resultArray = [regularExp matchesInString:texString options:0 range:NSMakeRange(0, texString.length)];
 if (resultArray.count > 0) {
 for (NSInteger i = 0; i  < [resultArray count]; ++i) {
 NSTextCheckingResult *result = resultArray[i];
 NSRange range =  [result range];
 NSString *subStr = [texString substringWithRange:range];
 
 NSArray *array = [subStr componentsSeparatedByString:@"|"];
 KaochaImageModel *imagemodel = [KaochaImageModel modelWithArray:array withRange:range withImageStr:subStr];
 [imageArray addObject:imagemodel];
 }
 }else {
 return attributeString;
 }
 }
 
 for (NSInteger i = [imageArray count]-1; i>=0; i--) {
 KaochaImageModel *model = imageArray[i];
 NSRange range = model.range;
 
 NSTextAttachment *attch = [[NSTextAttachment alloc] init];
 //加载图片
 NSString *imgPath = [filePath stringByAppendingPathComponent:model.src];
 //设置目标图片
 attch.image = [[UIImage alloc] initWithContentsOfFile:imgPath];
 //设置目标图片大小
 attch.bounds = CGRectMake(0, 0, model.width, model.height);
 
 // 创建带有图片的富文本
 NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
 
 [attributeString replaceCharactersInRange:range withAttributedString:string];
 }
 
 return attributeString;
 }
 
 */
+ (NSString *)ret32bitString {
    char data[32];
    for (int x=0;x<32;data[x++] = (char)('A' + (arc4random_uniform(26))));
    return [[NSString alloc] initWithBytes:data length:32 encoding:NSUTF8StringEncoding];
}

+ (BOOL)isMainQueue {
    static const void* mainQueueKey = @"mainQueue";
    static void* mainQueueContext = @"mainQueue";
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dispatch_queue_set_specific(dispatch_get_main_queue(), mainQueueKey, mainQueueContext, nil);
    });
    return dispatch_get_specific(mainQueueKey) == mainQueueContext;
}
#pragma mark - 时间处理
//时间字符串转时间戳
+ (NSTimeInterval)timeValueWith:(NSString *)timeString {
    NSString *timeStr = [NSString stringWithString:timeString];
    float second = 0;
    
    NSArray *array1 = [timeStr componentsSeparatedByString:@":"];
    
    if (array1.count == 2) {
        //分
        NSString *string1 = [array1 objectAtIndex:0];
        NSString *string2 = [array1 objectAtIndex:1];
        second = second + [string1 floatValue]*60+[string2 floatValue];
        //                second = second + [string1 doubleValue]*60+[string2 doubleValue];
    }else if (array1.count == 3){
        //时
        NSString *string1 = [array1 objectAtIndex:0];
        NSString *string2 = [array1 objectAtIndex:1];
        NSString *string3 = [array1 objectAtIndex:2];
        second = second + [string1 floatValue]*60*60+[string2 floatValue]*60+[string3 floatValue];
        //                second = second + [string1 doubleValue]*60*60+[string2 doubleValue]*60+[string3 doubleValue];
    }else {
        
    }
    
    float fValue =round(second*100)/100;
    NSTimeInterval time = (NSTimeInterval)fValue;
    if (time != 0) {
        time = time - 1;
    }
    return time;
}
+ (void)loadBorderWithView:(UIView *)view top:(BOOL)top left:(BOOL)left bottom:(BOOL)bottom right:(BOOL)right borderColor:(UIColor *)color borderWidth:(CGFloat)width
{
    if (top) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, view.frame.size.width, width);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
    if (left) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, width, view.frame.size.height);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
    if (bottom) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, view.frame.size.height - width, view.frame.size.width, width);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
    if (right) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(view.frame.size.width - width, 0, width, view.frame.size.height);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
}
//plist文件
+ (NSString *)getPlistFilePath {
    NSString *string = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *plistPath = [string stringByAppendingPathComponent:@"moduleUnits.plist"];
    
    /*
     if ([fileManager fileExistsAtPath:plistPath] == NO) {
     NSLog(@"不存在");
     [fileManager createDirectoryAtPath:plistPath withIntermediateDirectories:YES attributes:nil error:nil];
     } else {
     NSLog(@"存在");
     }
     */
    return plistPath;
}
@end
