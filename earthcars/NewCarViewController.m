//
//  NewCarViewController.m
//  earthcars
//
//  Created by qianfeng on 15/7/3.
//  Copyright (c) 2015年 韩世民. All rights reserved.
//

#import "NewCarViewController.h"
#import "FirstCell.h"
@interface NewCarViewController ()<ViewWillShow,UITableViewDataSource,UITableViewDelegate>

@end

@implementation NewCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}
-(void)down{
    _manager = [[AFHTTPRequestOperationManager alloc] init];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [self addTaskUrl:[NSString stringWithFormat:newCar,self.currentPage ]];
}
-(void)creatRefresh{
    __weak typeof(self) weakSelf = self;
    [_mytableView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        if (weakSelf.isRefresh) {
            return ;
        }
        weakSelf.isRefresh = YES;
        weakSelf.currentPage =1;
        [weakSelf addTaskUrl:[NSString stringWithFormat:newCar,weakSelf.currentPage]];
        NSLog(@"已刷新");
    }];
    
    [_mytableView addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        if (weakSelf.isLoadMore) {
            return ;
        }
        weakSelf.isLoadMore = YES;
        weakSelf.currentPage+=1;
        [weakSelf addTaskUrl:[NSString stringWithFormat:newCar,weakSelf.currentPage]];
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
    [_mytableView registerClass:[FirstCell class] forCellReuseIdentifier:@"FirstCell"];
    [self.view addSubview:_mytableView];
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
