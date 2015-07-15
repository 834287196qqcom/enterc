//
//  MarketViewController.m
//  earthcars
//
//  Created by qianfeng on 15/7/3.
//  Copyright (c) 2015年 韩世民. All rights reserved.
//

#import "MarketViewController.h"
#import "FirstCell.h"

@interface MarketViewController ()<ViewWillShow,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UITextFieldDelegate>
{
    UITextField *_picTextField1;
    UITextField *_picTextField;
}
@property(nonatomic,strong)UITextField *picTextField1;
@property(nonatomic,strong)UITextField *picTextField;

@end

@implementation MarketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
}
-(void)down{
    _manager = [[AFHTTPRequestOperationManager alloc] init];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *str1 = @"河南";
    NSString *str2 = @"郑州";
    [self addTaskUrl:[NSString stringWithFormat:Market,self.currentPage,str1,str2]];
}
-(void)creatView{
    UIView *seaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, 50)];
    seaView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"app_setting_feedback_bg"]];
    UILabel *picLabel =[MyControl creatLabelWithFrame:CGRectMake(10, 0, 50, 50) text:@"请输入"];
    [seaView addSubview:picLabel];
    _picTextField = [[UITextField alloc] initWithFrame:CGRectMake(kScreenSize.width/5, 0, 50, 50)];
    _picTextField.placeholder = @"河南";
    _picTextField.delegate = self;
    UILabel *picLabel1 = [MyControl creatLabelWithFrame:CGRectMake(kScreenSize.width/3+20, 0, 50, 50) text:@"省"];
    [seaView addSubview:picLabel1];
    [seaView addSubview:_picTextField];
    
    
    _picTextField1 = [[UITextField alloc] initWithFrame:CGRectMake(kScreenSize.width/3+50, 0, 50, 50)];
    _picTextField1.placeholder = @"郑州";
     _picTextField1.delegate = self;
    UILabel *picLabel2 = [MyControl creatLabelWithFrame:CGRectMake(kScreenSize.width/2+50, 0, 50, 50) text:@"市"];
     [seaView addSubview:_picTextField1];
     [seaView addSubview:picLabel2];
    
    UIButton *butt = [MyControl creatButtonWithFrame:CGRectMake(kScreenSize.width-kScreenSize.width/5,  0, 50, 50) target:self sel:@selector(btnClick) tag:101 image:nil title:@"搜索"];
    [butt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [seaView addSubview:butt];
    [self.view addSubview:seaView];
    _mytableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50,kScreenSize.width, kScreenSize.height-64-49-64) style:UITableViewStylePlain];
    _mytableView.delegate = self;
    _mytableView.dataSource = self;
    _mytableView.rowHeight = 80;
    [_mytableView registerClass:[FirstCell class] forCellReuseIdentifier:@"FirstCell"];
    [self.view addSubview:_mytableView];
}

-(void)btnClick{
    NSLog(@"搜索");
    _picTextField.placeholder = _picTextField.text;
    _picTextField1.placeholder = _picTextField1.text;
    
    NSString *pic  =_picTextField.text;
    NSString *pic2 = _picTextField1.text;
    [self.dataArr removeAllObjects];
     [_picTextField resignFirstResponder];
    [_picTextField1 resignFirstResponder];
    [self creatView];
    [self addTaskUrl:[NSString stringWithFormat:Market,self.currentPage,pic,pic2]];
   
}

-(void)addTaskUrl:(NSString *)url{
    __weak typeof(self) mySelf = self;
    NSLog(@"%@",url);
    NSString*myurl =[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [_manager GET:myurl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"下载成功");
        if (responseObject) {
            if (mySelf.currentPage == 1) {
                [mySelf.dataArr removeAllObjects];
            }
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            //cell内容
            NSArray *arr = dict[@"articleList"];
            for (NSDictionary *dict1 in arr) {
                myModel  *model = [[myModel alloc] init];
                [model setValuesForKeysWithDictionary:dict1];
                [mySelf.dataArr addObject:model];
            }
            
            if (mySelf.dataArr.count == 0) {
                mySelf.dataArr = nil;
                [mySelf creatView];
                UIAlertView *alertView  = [[UIAlertView alloc] initWithTitle:@"没有相关信息" message:@"请重新输入" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alertView show];
                
            }
            
            [mySelf.mytableView reloadData];
            
        }
        if (mySelf.dataArr.count == 0) {
            
        }else{
        [mySelf creatRefresh];
        }
        [mySelf endRefresh];
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
        weakSelf.currentPage =1;
        [weakSelf addTaskUrl:[NSString stringWithFormat:Market,weakSelf.currentPage,weakSelf.picTextField.text,weakSelf.picTextField1.text]];
        NSLog(@"已刷新");
    }];
    
    [_mytableView addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        if (weakSelf.isLoadMore) {
            return ;
        }
        weakSelf.isLoadMore = YES;
        weakSelf.currentPage+=1;
        [weakSelf addTaskUrl:[NSString stringWithFormat:Market,weakSelf.currentPage,weakSelf.picTextField.text,weakSelf.picTextField1.text]];
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
