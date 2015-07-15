//
//  searchPaiZiViewController.m
//  earthcars
//
//  Created by qianfeng on 15/7/9.
//  Copyright (c) 2015年 韩世民. All rights reserved.
//

#import "searchPaiZiViewController.h"


@interface searchPaiZiViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation searchPaiZiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 20, kScreenSize.width, 44)];
    view1.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"app_setting_feedback_bg"]];
    UIButton *backbutton = [MyControl creatButtonWithFrame:CGRectMake(10, 10, 30, 30) target:self sel:@selector(btnCick) tag:101 image:@"app_full_screen_pre_no" title:nil];
    [view1 addSubview:backbutton];
    [self.view addSubview:view1];
    _dataArr = [[NSMutableArray alloc] init];

    
    [self down];
    [self creatUI];
    
}
-(void)down{
    _manager = [[AFHTTPRequestOperationManager alloc] init];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [self addTaskUrl:[NSString stringWithFormat:pinpai,self.abc]];
}
-(void)addTaskUrl:(NSString *)url{
    __weak typeof(self) mySelf = self;
    [_manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"下载成功");
        if (responseObject) {
            if (mySelf.dataArr != nil) {
                [mySelf.dataArr removeAllObjects];
            }
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            //cell内容
            NSArray *arr = dict[@"manufacturers"];
            for (NSDictionary *di in arr) {
               NSArray *arr1 = di[@"serials"];
                for (NSDictionary *dict3 in arr1) {
                    myModel  *model = [[myModel alloc] init];
                    [model setValuesForKeysWithDictionary:dict3];
                  //  NSLog(@"==%@",model.brandIntroduction);
                    if (![mySelf isRange:model.photo]) {
                         [mySelf.dataArr addObject:model];
                    }
                   
                }
            }
            
            [mySelf.mytableView reloadData];
        }
        

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"下载失败");

    }];
}
-(BOOL)isRange:(NSString *)str{
    NSRange range1 = [str rangeOfString:@"http://www1.pcauto.com.cn/2010/price/img/slt/180x135.jpg"];
    if (range1.location!= NSNotFound) {
        return YES;
    }
    return NO;
}
-(void)btnCick{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)creatUI{
        _mytableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64,kScreenSize.width, kScreenSize.height-64) style:UITableViewStylePlain];
        _mytableView.delegate = self;
        _mytableView.dataSource = self;
        _mytableView.rowHeight = 80;
        [_mytableView registerClass:[paiziCell class] forCellReuseIdentifier:@"paiziCell"];
        _mytableView.tableFooterView = [[UIView alloc] init];
        [self.view addSubview:_mytableView];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellld = @"paiziCell";
    paiziCell *cell = [tableView dequeueReusableCellWithIdentifier:cellld forIndexPath:indexPath];
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
