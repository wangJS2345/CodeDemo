//
//  ClickBoxViewController.m
//  CodeDemo
//
//  Created by apple on 2017/3/6.
//  Copyright © 2017年 LYP. All rights reserved.
//

#import "ClickBoxViewController.h"
#import "CheckButton.h"
#import "CTCheckbox.h"
#import "AKCheckBox.h"
@interface ClickBoxViewController ()
@property (weak, nonatomic) IBOutlet UIButton *chooseBtn;
- (IBAction)chooseClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
//@property (weak, nonatomic) IBOutlet CheckButton *checkBtn;
@property (weak, nonatomic) IBOutlet CTCheckbox *checkBtn;
- (IBAction)checkBtnChange:(CTCheckbox *)sender;

@property (weak, nonatomic) IBOutlet AKCheckBox *buttonA;
- (IBAction)buttonAClick:(AKCheckBox *)sender;


@end

@implementation ClickBoxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
//    [self.buttonA setColor:[UIColor blackColor] forControlState:UIControlStateNormal];
//    [self.buttonA setColor:[UIColor grayColor] forControlState:UIControlStateDisabled];
//    [self checkboxDidChange:self.buttonA];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)chooseClick:(UIButton *)sender {
}
- (IBAction)checkBtnChange:(CTCheckbox *)sender {
    
//    textLabel
//    self.textLabel.text = []
    NSLog(@"checkBtn:%d", self.checkBtn.checked);
    if (!self.checkBtn.checked) {
        self.textLabel.text = @"未选中";
    }else {
        self.textLabel.text = @"已选中";
    }
}
- (IBAction)buttonAClick:(AKCheckBox *)sender {
}
@end
