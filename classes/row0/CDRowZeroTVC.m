//
//  CDRowZeroTVC.m
//  CodeDemo
//
//  Created by apple on 2017/3/3.
//  Copyright © 2017年 LYP. All rights reserved.
//

#import "CDRowZeroTVC.h"
#import "CDRowZeroCell.h"

@interface CDRowZeroTVC ()

@property (nonatomic ,retain)NSArray * cellsArray;
@property (nonatomic ,retain)NSArray * dataArray;

@property (nonatomic ,retain) UITableViewCell * tableViewCell;

@end

@implementation CDRowZeroTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self setDataOfVC];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.cellsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    /**/
    CDRowZeroCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CDRowZeroCell" forIndexPath:indexPath];
    
    NSString * stringF = [self.cellsArray objectAtIndex:indexPath.row];
    NSString * stringS = [self.dataArray objectAtIndex:indexPath.row];
    [cell setFirstcell:stringF Secondcell:stringS indexPath:indexPath.row];
//    [cell setCellViews:string indexPath:indexPath.row];
    [cell.labelF sizeToFit];
    [cell.labelS sizeToFit];
    // Configure the cell...
    
    return cell;
    //*/
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
    self.cellsArray = @[@"Our Time",@"FU",@"No One",@"Vicious",@"Happy"];
    self.dataArray = @[@"human",@"Slave To Love",@"Who's That Girl?",@"They're Not Waving",@"AQUARIUS"];
    
    CDRowZeroCell * cell = (CDRowZeroCell *)self.tableViewCell;
    
}
@end
