//
//  searchViewController.m
//  earthcars
//
//  Created by qianfeng on 15/7/4.
//  Copyright (c) 2015年 韩世民. All rights reserved.
//

#import "searchViewController.h"
#import "MyControl.h"
#import "myModel.h"
#import "searchBarCell.h"
#define kScreenSize [UIScreen mainScreen].bounds.size
@interface searchViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

{
    NSString *_str;

    UISearchBar *_search;
}
@property (nonatomic,copy)NSString *str;

@end

@implementation searchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor];
    _dataArr = [[NSMutableArray alloc] init];
    
    UIView *myView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, kScreenSize.width, 64)];
    myView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"app_setting_feedback_bg"]];
    _search = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 10, kScreenSize.width- kScreenSize.width/5, 44)];
    _search.delegate = self;
    _search.placeholder = @"请输入关键字";
    UIButton *button = [MyControl creatButtonWithFrame:CGRectMake(kScreenSize.width- kScreenSize.width/5+10, 20, 60, 30) target:self sel:@selector(btnClick2) tag:101 image:nil title:@"取消"];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:17];
    [myView addSubview:button];
    [myView addSubview:_search];
    [self.view addSubview:myView];
    
    
    [self creatUI];
}
-(void)creatUI{
    
    
    _mytableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 84 , kScreenSize.width, kScreenSize.height-84) style:UITableViewStylePlain];
    _mytableView.dataSource = self;
    _mytableView.delegate = self;
    _mytableView.rowHeight = 80;
    [_mytableView registerClass:[searchBarCell class] forCellReuseIdentifier:@"searchBarCell"];
    _mytableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_mytableView];

    
}
-(void)btnClick2{
    _search.text = @"";
    [_search resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    _str = searchText;
    [self down];
}
-(void)down{
    _manager = [AFHTTPRequestOperationManager manager];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [self addTaskUrl:[NSString stringWithFormat:searchCar,self.str]];
}
-(void)addTaskUrl:(NSString *)url{
    __weak typeof(self) mySelf = self;
    NSString* string = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [_manager GET:string parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"下载成功");
        if (responseObject) {
            
            if (mySelf.dataArr != nil) {
                [mySelf.dataArr removeAllObjects];
            }
            if (mySelf.str!=nil) {
                mySelf.str = nil;
            }
            
            NSArray *arr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
    
            for (NSDictionary *dict1 in arr) {
                myModel *model = [[myModel alloc] init];
                [model setValuesForKeysWithDictionary:dict1];
                [mySelf.dataArr addObject:model];

            }
            [mySelf.mytableView reloadData];
        }
        [_search resignFirstResponder];
        [self creatUI];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"下载失败");
    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellld = @"searchBarCell";
    searchBarCell *cell = [tableView dequeueReusableCellWithIdentifier:cellld forIndexPath:indexPath];
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
