//
//  PoemModel.m
//  CodeDemo
//
//  Created by apple on 2017/3/9.
//  Copyright © 2017年 LYP. All rights reserved.
//

#import "PoemModel.h"

@implementation PoemModel

// 提供一个类方法,即构造函数,返回封装好数据的对象(返回id亦可)
+ (PoemModel *)poemer:(NSString *)poemer withName:(NSString*)name withContent:(NSString *)content {
    PoemModel *model = [[PoemModel alloc]init];
    model.poemer = poemer;
    model.poemName = name;
    model.poemContent = content;
    return model;
}

// 类方法,字典 转 对象 类似javaBean一次性填充
+ (PoemModel *)poemWithDict:(NSDictionary *)dict {
    // 只是调用对象的initWithDict方法,之所以用self是为了对子类进行兼容
    return [[self alloc]initWithDict:dict];
}

// 对象方法,设置对象的属性后,返回对象
- (PoemModel *)initWithDict:(NSDictionary *)dict {
    // 先调用父类NSObject的init方法
    if (self = [super init]) {
        // 设置对象自己的属性
        self.poemer = dict[@"name"]   ;
        self.poemName = dict[@"poemName"] ;
        self.poemContent = dict[@"poem"];
    }
    // 返回填充好的对象
    return self;
}

@end
