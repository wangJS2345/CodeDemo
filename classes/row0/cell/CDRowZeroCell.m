//
//  CDRowZeroCell.m
//  CodeDemo
//
//  Created by apple on 2017/3/3.
//  Copyright © 2017年 LYP. All rights reserved.
//

#import "CDRowZeroCell.h"

@implementation CDRowZeroCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setFirstcell:(NSString *)stringF Secondcell:(NSString *)stringS indexPath:(NSInteger)indexPath {
    NSString * str1 = [NSString stringWithString:stringF];
    NSString * str2 = [NSString stringWithString:stringS];
    self.labelF.text = str1;
    self.labelS.text = str2;

}
@end
