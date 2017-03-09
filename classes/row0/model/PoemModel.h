//
//  PoemModel.h
//  CodeDemo
//
//  Created by apple on 2017/3/9.
//  Copyright © 2017年 LYP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PoemModel : NSObject

// UI控件用weak,字符串用copy,其他对象用strong
// 诗人姓名
@property(nonatomic,copy)NSString *poemer;
// 诗名
@property(nonatomic,copy)NSString *poemName;
// 诗的内容
@property(nonatomic,copy)NSString *poemContent;
// 提供一个类方法,即构造函数,返回封装好数据的对象(返回id亦可)
+ (PoemModel *)poemer:(NSString *)poemer withName:(NSString*)name withContent:(NSString *)content;

// 类方法,字典 转 对象 类似javaBean一次性填充
+ (PoemModel *)poemWithDict:(NSDictionary *)dict;

// 对象方法,设置对象的属性后,返回对象
- (PoemModel *)initWithDict:(NSDictionary *)dict;

@end
