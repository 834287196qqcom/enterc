//
//  VideoViewController.m
//  earthcars
//
//  Created by qianfeng on 15/7/3.
//  Copyright (c) 2015年 韩世民. All rights reserved.
//

#import "VideoViewController.h"
#import "VideoCell.h"
#import "DetailViewController.h"
#import "videoDetailController.h"
@interface VideoViewController ()<ViewWillShow,UITableViewDataSource,UITableViewDelegate>

@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.currentPage = 0;
}
-(void)down{
    _manager = [[AFHTTPRequestOperationManager alloc] init];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [self addTaskUrl:[NSString stringWithFormat:Video,self.currentPage ]];
}
-(void)addTaskUrl:(NSString *)url{
    __weak typeof(self) mySelf = self;
    [_manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"下载成功");
        if (responseObject) {
            if (mySelf.currentPage == 0) {
                [mySelf.dataArr removeAllObjects];
            }
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            //cell内容
            NSDictionary *dict1 = dict[@"result"];
            NSArray *arr = dict1[@"list"];
            for (NSDictionary *dict2 in arr) {
                myModel  *model = [[myModel alloc] init];
                [model setValuesForKeysWithDictionary:dict2];
                [mySelf.dataArr addObject:model];
            }
            [mySelf.mytableView reloadData];
        }
        [self creatView];
        [self creatRefresh];
        [ self endRefresh];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"下载失败");
        [ self endRefresh];
    }];
}
-(void)creatRefresh{
    __weak typeof(self) weakSelf = self;
    [_mytableView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        if (weakSelf.isRefresh) {
            return ;
        }
        weakSelf.isRefresh = YES;
        weakSelf.currentPage =0;
        [weakSelf addTaskUrl:[NSString stringWithFormat:Video,weakSelf.currentPage]];
        NSLog(@"已刷新");
    }];
    
    [_mytableView addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        if (weakSelf.isLoadMore) {
            return ;
        }
        weakSelf.isLoadMore = YES;
        weakSelf.currentPage+=1;
        [weakSelf addTaskUrl:[NSString stringWithFormat:Video,weakSelf.currentPage]];
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

-(void)creatView{
    _mytableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,kScreenSize.width, kScreenSize.height-64-49-29) style:UITableViewStylePlain];
    _mytableView.delegate = self;
    _mytableView.dataSource = self;
    _mytableView.rowHeight = 80;
    [_mytableView registerClass:[VideoCell class] forCellReuseIdentifier:@"VideoCell"];
    [self.view addSubview:_mytableView];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VideoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VideoCell" forIndexPath:indexPath];
    myModel *model = _dataArr[indexPath.row];
    [cell showDataWithModel:model];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     DetailViewController *Detail = [[DetailViewController alloc] init];
    myModel*model = _dataArr[indexPath.row];
    Detail.contentUrl =model.shareaddress;
    [self presentViewController:Detail animated:YES completion:nil];
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
