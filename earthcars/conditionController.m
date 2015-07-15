//
//  conditionController.m
//  earthcars
//
//  Created by qianfeng on 15/7/8.
//  Copyright (c) 2015年 韩世民. All rights reserved.
//

#import "conditionController.h"
#import "myModel.h"
#import "conditionViewCell.h"
@interface conditionController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation conditionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 20, kScreenSize.width, 44)];
    view1.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"app_setting_feedback_bg"]];
    UIButton *backbutton = [MyControl creatButtonWithFrame:CGRectMake(10, 10, 20, 30) target:self sel:@selector(btnCick) tag:101 image:@"infor_center_back_btn_night" title:nil];
    
    [view1 addSubview:backbutton];
    [self.view addSubview:view1];
    
    _dataArr = [[NSMutableArray alloc] init];
    self.isRefresh = NO;
    self.isLoadMore = NO;
    self.currentPage = 1;
    [self down];
    [self creatView];
    [self creatRefresh];
    
}
-(void)btnCick{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)down{
    _manager = [[AFHTTPRequestOperationManager alloc] init];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [self addTaskUrl:[NSString stringWithFormat:tiaojianjieguo,self.from,self.to,self.currentPage]];
}
-(void)addTaskUrl:(NSString *)url{
    __weak typeof(self) mySelf = self;
    [_manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"下载成功");
        if (responseObject) {
            if (mySelf.dataArr!=nil) {
                [mySelf.dataArr removeAllObjects];
            }
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSArray *arr = dict[@"data"];
            NSDictionary *dict1 = arr[0];
            NSArray *arr1 = dict1[@"items"];
            for (NSDictionary *dict2 in arr1) {
                myModel  *model = [[myModel alloc] init];
                [model setValuesForKeysWithDictionary:dict2];
                [mySelf.dataArr addObject:model];
            }
            
            if (mySelf.dataArr.count == 0) {
                mySelf.dataArr = nil;
                [mySelf creatView];
                UIAlertView *alertView  = [[UIAlertView alloc] initWithTitle:@"没有相关信息" message:@"请返回重新输入" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alertView show];
                
            }
            
            [mySelf.mytableView reloadData];
        }
        
        [ self endRefresh];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"下载失败");
        [ self endRefresh];
    }];
}
-(void)creatView{
    _mytableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64,kScreenSize.width, kScreenSize.height-44) style:UITableViewStylePlain];
    _mytableView.delegate = self;
    _mytableView.dataSource = self;
    _mytableView.rowHeight = 80;
    [_mytableView registerClass:[conditionViewCell class] forCellReuseIdentifier:@"conditionViewCell"];
    [self.view addSubview:_mytableView];
}
-(void)creatRefresh{
    __weak typeof(self) weakSelf = self;
    [_mytableView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        if (weakSelf.isRefresh) {
            return ;
        }
        weakSelf.isRefresh = YES;
        weakSelf.currentPage =1;
        [weakSelf addTaskUrl:[NSString stringWithFormat:tiaojianjieguo,weakSelf.from,weakSelf.to,weakSelf.currentPage]];
        NSLog(@"已刷新");
    }];
    
    [_mytableView addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        if (weakSelf.isLoadMore) {
            return ;
        }
        weakSelf.isLoadMore = YES;
        weakSelf.currentPage+=1;
        [weakSelf addTaskUrl:[NSString stringWithFormat:tiaojianjieguo,weakSelf.from,weakSelf.to,weakSelf.currentPage]];
        NSLog(@"已加载");
    }];
}
-(void)endRefresh{
    if (self.isRefresh) {
        self.isRefresh = NO;
        [self.mytableView headerEndRefreshingWithResult:JHRefreshResultSuccess];
    }
    if (self.isLoadMore) {
        self.isLoadMore = NO;
        [self.mytableView footerEndRefreshing];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellld = @"conditionViewCell";
    conditionViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellld forIndexPath:indexPath];
    myModel *model = _dataArr[indexPath.row];
    [cell showDataWithModel:model];
    return cell;
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
