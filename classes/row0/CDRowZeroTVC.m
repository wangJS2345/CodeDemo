//
//  CDRowZeroTVC.m
//  CodeDemo
//
//  Created by apple on 2017/3/3.
//  Copyright © 2017年 LYP. All rights reserved.
//

#import "CDRowZeroTVC.h"
#import "CDRowZeroCell.h"
#import "PoemModel.h"

@interface CDRowZeroTVC ()


// 从plist文件中加载的所有poem,返回所有的对象组成的数组
@property (nonatomic, retain) NSArray *poem;

@end

@implementation CDRowZeroTVC

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    

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

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.poem.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellTableIdentifer = @"CDRowZeroCell";
    //tableView注册nib文件
    static BOOL nibsRegistered = NO;
    if(!nibsRegistered)
    {
        UINib *nib = [UINib nibWithNibName:@"CDRowZeroCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CellTableIdentifer];
        nibsRegistered = YES;
    }
    
    CDRowZeroCell * cell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifer];
    //    cell.textLabel.text = @"xxxxx";
    PoemModel *model = (self.poem)[indexPath.row];
    cell.poemerLabel.text = model.poemer;
    cell.poemNameLabel.text = model.poemName;
    cell.poemContentLabel.text = model.poemContent;
    return cell;
}
#pragma mark - 代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}
//把数据导入到模型中,然后导入到定得数组中 懒加载
- (NSArray *)poem {
    //这个是实现数句的加载,第一次调用这个方法的时候加载全部数据
    //当第二次调用这个方法时不用加载
    //使用懒加载
    if(_poem == nil)
    {
        
        //1.读取heros.plist文件的全路径
        NSString *path = [[NSBundle mainBundle] pathForResource:@"files" ofType:@"plist"];
        //2.加载数组,读出plist中的数据
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:path];
        
        //3.将dicArray 中的字典转成模型对象,放到新的数组中
        //遍历dictArray数组
        //4.创建一个可变数组,把模型存到可变数组中
        NSMutableArray *dicArray = [NSMutableArray array];
        for (NSDictionary *dic in dictArray) {
            //初始化模型对象
            PoemModel *model = [PoemModel poemWithDict:dic];
            [dicArray addObject:model];
        }
        //5.赋值
        _poem = dicArray;
    }
    return _poem;
}

@end
