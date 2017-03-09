//
//  CDRowZeroCell.m
//  CodeDemo
//
//  Created by apple on 2017/3/9.
//  Copyright © 2017年 LYP. All rights reserved.
//

#import "CDRowZeroCell.h"
#import "PoemModel.h"

@implementation CDRowZeroCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

// 返回xib界面上写的重用cellIdentifier
+ (NSString *)cellIdentifier {
    return @"CDRowZeroCell";
}

// 从xib中加载 实例化一个poemCell对象
+ (CDRowZeroCell *)poemCell {
    // mainBundel加载xib,扩展名不用写.xib
    NSArray *arrayXibObjects = [[NSBundle mainBundle] loadNibNamed:@"CDRowZeroCell" owner:nil options:nil];
    return arrayXibObjects[0];
}

// 参数是数据模型model对象,填充值到xib中各个控件 ,并返回封装好数据之后的,poemCell对象
- (CDRowZeroCell *)cellWithPoem:(PoemModel *)model {
    // 前面,通过连线,将xib中的各个控件,连接到GirlCell类,成为它的成员属性了,这样一来就不用通过tag取得xib中每一个控件了
    self.poemerLabel.text = model.poemer;
    self.poemNameLabel.text = model.poemName;
    self.poemContentLabel.text = model.poemContent;
    
    // 返回封装好数据之后的,girlCell对象
    return self;
}

@end
