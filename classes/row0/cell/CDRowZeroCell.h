//
//  CDRowZeroCell.h
//  CodeDemo
//
//  Created by apple on 2017/3/3.
//  Copyright © 2017年 LYP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CDRowZeroCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelF;
@property (weak, nonatomic) IBOutlet UILabel *labelS;

- (void)setFirstcell:(NSString *)stringF Secondcell:(NSString *)stringS indexPath:(NSInteger)indexPath;
@end
