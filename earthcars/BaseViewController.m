//
//  BaseViewController.m
//  earthcars
//
//  Created by qianfeng on 15/7/3.
//  Copyright (c) 2015年 韩世民. All rights reserved.
//

#import "BaseViewController.h"
#import "FirstCell.h"
#import "myModel.h"
#import "mysqlite.h"
#import "DetailViewController.h"
@interface BaseViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArr = [[NSMutableArray alloc] init];
    _PicArr = [[NSMutableArray alloc] init];
    self.isRefresh = NO;
    self.isLoadMore = NO;
    self.currentPage = 1;
    
    [self down];
  [self creatView];
    [self creatRefresh];
}
-(void)down{
    _manager = [[AFHTTPRequestOperationManager alloc] init];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [self addTaskUrl:[NSString stringWithFormat:firstPage,self.currentPage ]];
}
-(void)addTaskUrl:(NSString *)url{
    __weak typeof(self) mySelf = self;
    [_manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"下载成功");
        if (responseObject) {
            if (mySelf.currentPage == 1) {
                [mySelf.dataArr removeAllObjects];
                [mySelf.PicArr removeAllObjects];
            }
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            //cell内容
            NSArray *arr = dict[@"articleList"];
            for (NSDictionary *dict1 in arr) {
                myModel  *model = [[myModel alloc] init];
                [model setValuesForKeysWithDictionary:dict1];
                [mySelf.dataArr addObject:model];
            }
            //滚动视图填充
            NSArray *arr1 = dict[@"focus"];
            for (NSDictionary *dict2 in arr1) {
                myModel *model = [[myModel alloc] init];
                [model setValuesForKeysWithDictionary:dict2];
                [mySelf.PicArr addObject:model.image];
            }
            
              [mySelf.mytableView reloadData];
        }
    
        [ self endRefresh];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //NSLog(@"下载失败");
         [ self endRefresh];
    }];
}
-(void)creatView{
    _mytableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,kScreenSize.width, kScreenSize.height-64-49-29) style:UITableViewStylePlain];
    _mytableView.delegate = self;
    _mytableView.dataSource = self;
    _mytableView.rowHeight = 80;
    [_mytableView registerClass:[FirstCell class] forCellReuseIdentifier:@"FirstCell"];

    [self.view addSubview:_mytableView];
}
-(void)tapClick{
    //NSLog(@"被点了");
}
-(void)creatRefresh{
    __weak typeof(self) weakSelf = self;
    [_mytableView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        if (weakSelf.isRefresh) {
            return ;
        }
        weakSelf.isRefresh = YES;
        weakSelf.currentPage =1;
        [weakSelf addTaskUrl:[NSString stringWithFormat:firstPage,weakSelf.currentPage]];
        //NSLog(@"已刷新");
    }];
    
    [_mytableView addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        if (weakSelf.isLoadMore) {
            return ;
        }
        weakSelf.isLoadMore = YES;
        weakSelf.currentPage+=1;
        [weakSelf addTaskUrl:[NSString stringWithFormat:firstPage,weakSelf.currentPage]];
        //NSLog(@"已加载");
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
     static NSString *cellld = @"FirstCell";
    FirstCell *cell = [tableView dequeueReusableCellWithIdentifier:cellld forIndexPath:indexPath];
    myModel *model = _dataArr[indexPath.row];
    [cell showDataWithModel:model];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    myModel *model = self.dataArr[indexPath.row];
//    BOOL isref = YES;
//    NSArray *arr = [[mysqlite sharedManager] findModel];
//    
//    if (arr == nil) {
//        [[mysqlite sharedManager] insertModel:model];
//   
//    }else{
//        for (myModel *model1 in arr) {
//            if ([model1.title isEqualToString :model.title]) {
//                isref = NO;
//            }else{
//                isref = YES;
//                break;
//            }
//        }
//        if (isref == YES) {
//            [[mysqlite sharedManager] insertModel:model];
//
//        }else{
//        }
//    }
//    
    
    DetailViewController *detail = [[DetailViewController alloc] init];
    detail.contentUrl = model.url;
    detail.model = model;
    [[[[UIApplication sharedApplication] keyWindow]rootViewController] presentViewController:detail animated:YES completion:nil];
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
