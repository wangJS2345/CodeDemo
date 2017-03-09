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

//@property (nonatomic ,retain)NSArray * cellsArray;
//@property (nonatomic ,retain)NSArray * dataArray;
//
//@property (nonatomic ,retain) UITableViewCell * tableViewCell;
//@property (nonatomic ,retain) CDRowZeroCell * rowCell;

// 从plist文件中加载的所有poem,返回所有的对象组成的数组
@property (nonatomic, retain) NSArray *poem;

@end

@implementation CDRowZeroTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
//    [self setDataOfVC];

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
- (void)setDataOfVC {
    /*
    self.cellsArray = @[@"Our Time",@"FU",@"No One",@"Vicious",@"Happy"];
    self.dataArray = @[@"human",@"Slave To Love",@"Who's That Girl?",@"They're Not Waving",@"AQUARIUS"];
    
    CDRowZeroCell * cell = (CDRowZeroCell *)self.tableViewCell;
//    self.rowCell = [CDRowZeroCell ];
    */
    
    // 以下三步为OC标准代码,因为OC中不允许直接修该对象中结构体属性的成员的值,要通过中间的临时结构体变量
//    CGRect frame = self.tableView.frame;
//    frame.origin.y = 20;
//    self.tableView.frame=frame;
    
    _poem = [NSMutableArray array];
    // plist转成对象数组
    [self plistToObjects];
    
}
// plist转成对象数组
- (void)plistToObjects
{
    
    //从文件中读取plist文件的路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"files" ofType:@"plist"];
    
     //初始化数据数组
    NSArray *arrayWithDict  = [NSArray arrayWithContentsOfFile:path];

    
    NSLog(@"arrayWithDict----%@",arrayWithDict);
    // 字典数组 _arrayWithDict
    
    // 方式2:类方法返回对象,参数只要一个字典数组即可
    for (NSDictionary *dict in arrayWithDict) {
        // 参数只要字典,这样一来,控制器就不用知道太多东西了
        // Girl *girl = [[Girl alloc]initWithDict:dict];
        PoemModel *model = [PoemModel poemWithDict:dict];
//        [self.poem addObject:model];
        NSLog(@"self.poem.-----%@",self.poem);

    }
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.poem.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    PoemCell *cell = (PoemCell *)[tableView dequeueReusableCellWithIdentifier:@"PoemCell"];
    PoemModel *model = (self.poem)[indexPath.row];
    cell.poemerLabel.text = model.poemer;
    cell.poemNameLabel.text = model.poemName;
    cell.poemContentLabel.text = model.poemContent;
    
    return cell;
    */
    /*
    static NSString *CellTableIdentifer = @"PoemCell";
    //tableView注册nib文件
    static BOOL nibsRegistered = NO;
    if(!nibsRegistered)
    {
        UINib *nib = [UINib nibWithNibName:@"PoemCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CellTableIdentifer];
        nibsRegistered = YES;
    }
    
    PoemCell * cell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifer];
//    cell.textLabel.text = @"xxxxx";
    PoemModel *model = (self.poem)[indexPath.row];
    cell.poemerLabel.text = model.poemer;
    cell.poemNameLabel.text = model.poemName;
    cell.poemContentLabel.text = model.poemContent;
    return cell;
    */
    
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
