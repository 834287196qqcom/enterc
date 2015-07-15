//
//  myfavoriteController.m
//  earthcars
//
//  Created by qianfeng on 15/7/10.
//  Copyright (c) 2015年 韩世民. All rights reserved.
//

#import "myfavoriteController.h"
#import "myModel.h"
#import "mysqlite.h"
#import "favoriteCell.h"
#import "MyControl.h"
#import "DetailViewController.h"
@interface myfavoriteController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_favoriteArr;
    UITableView *_mytableView;
    UIButton *_button;
}
@property (nonatomic,strong)UITableView *mytableView;
@end

@implementation myfavoriteController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showTV];
}
-(void)showTV{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed: @"tarbackground_bg"] forBarMetrics:UIBarMetricsDefault];
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(butClick)];
    
    
    self.navigationItem.leftBarButtonItem = button;
    NSArray *arr = [[mysqlite sharedManager] findModel];
    NSLog(@"----------%@",arr);
    _favoriteArr = [[NSMutableArray alloc] init];
    for (myModel *model in arr) {
        [_favoriteArr addObject:model];
    }
    
    self.mytableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-64)style:UITableViewStylePlain];
    
    _mytableView.delegate = self;
    _mytableView.dataSource = self;
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [_mytableView registerClass:[favoriteCell class] forCellReuseIdentifier:@"favoriteCell"];
    _mytableView.tableFooterView=[[UIView alloc] init];
    [self.view addSubview:_mytableView];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _favoriteArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    favoriteCell *myCell = [tableView dequeueReusableCellWithIdentifier:@"favoriteCell" forIndexPath:indexPath];
    myModel *model = _favoriteArr[indexPath.row];
    [myCell showDataWithModel:model];
    return myCell;
    
}
-(void)butClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    myModel *model = _favoriteArr[indexPath.row];
    
    DetailViewController *Detail = [[DetailViewController alloc] init];
    Detail.contentUrl = model.url;
    Detail.model=model;
    
    [self presentViewController:Detail animated:YES completion:nil];
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
//编辑
-(void)setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
    [self.mytableView setEditing:!self.mytableView.editing animated:YES];
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    myModel *model = _favoriteArr[indexPath.row];
    NSLog(@"%@",model.title);
    [[mysqlite sharedManager] deleteModelForAppld:model.title];
    
    [_favoriteArr removeObjectAtIndex:indexPath.row];
    [self.mytableView reloadData];
    
}
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"Delete";
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

@end
