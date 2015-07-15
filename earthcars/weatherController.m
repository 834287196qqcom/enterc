//
//  weatherController.m
//  earthcars
//
//  Created by qianfeng on 15/7/10.
//  Copyright (c) 2015年 韩世民. All rights reserved.
//

#import "weatherController.h"
#import "myModel.h"
#import "weatherCell.h"
#import "MyControl.h"
@interface weatherController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UITextFieldDelegate>
{
    UITextField *_picTextField;
    NSString *_str;
}
@property(nonatomic,strong)UITextField *picTextField;
@property(nonatomic,strong)NSString *str;
@end

@implementation weatherController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArr = [[NSMutableArray alloc] init];
    self.view.backgroundColor = [UIColor lightGrayColor];
    _str = @"郑州";
    [self creatUI];
    [self down];
    
}
-(void)down{
    _manager = [[AFHTTPRequestOperationManager alloc] init];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];


    [self addTaskUrl:[NSString stringWithFormat:myweather,_str]];
    
}
-(void)addTaskUrl:(NSString *)url{
    __weak typeof(self) mySelf = self;
    NSLog(@"%@",url);
    NSString*myurl =[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [_manager POST:myurl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"下载成功");
        if (responseObject) {
            if (mySelf.dataArr != nil) {
                [mySelf.dataArr removeAllObjects];
            }
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSDictionary *dict1 = dict[@"resultinfo"];
                myModel  *model = [[myModel alloc] init];
                [model setValuesForKeysWithDictionary:dict1];
                [mySelf.dataArr addObject:model];
            
            [mySelf.mytableView reloadData];
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"下载失败");
    }];
}

-(void)creatUI{
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 20, kScreenSize.width, 44)];
    view1.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"app_setting_feedback_bg"]];
    UIButton *backbutton = [MyControl creatButtonWithFrame:CGRectMake(10, 10, 30, 30) target:self sel:@selector(btnCick:) tag:101 image:@"app_full_screen_pre_no" title:nil];
    [view1 addSubview:backbutton];
    [self.view addSubview:view1];

    UILabel *label = [MyControl creatLabelWithFrame:CGRectMake(10, 70, 50, 20) text:@"请输入"];
    [self.view addSubview:label];
    
    _picTextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 64, kScreenSize.width/3, 36)];
    _picTextField.placeholder = @"郑州";
    _picTextField.delegate = self;
    [self.view addSubview:_picTextField];
    
    UILabel *label1 = [MyControl creatLabelWithFrame:CGRectMake(kScreenSize.width/2, 70, 50, 20) text:@"市"];
    [self.view addSubview:label1];
    
    UIButton *butt = [MyControl creatButtonWithFrame:CGRectMake(kScreenSize.width-kScreenSize.width/5,  62, 50,36) target:self sel:@selector(btnCick:) tag:102 image:nil title:@"搜索"];
    [butt setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:butt];
    
    _mytableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, kScreenSize.width, kScreenSize.height/3) style:UITableViewStylePlain];
    _mytableView.dataSource = self;
    _mytableView.delegate =self;
    _mytableView.rowHeight = kScreenSize.height/3;
    [_mytableView registerClass:[weatherCell class] forCellReuseIdentifier:@"weatherCell"];
    _mytableView.tableFooterView = [[UIView alloc] init];
    
    [self.view addSubview:_mytableView];
    
}
-(void)btnCick:(UIButton *)button{
    switch (button.tag) {
        case 101:
        {
        [self dismissViewControllerAnimated:YES completion:nil];
        }
            break;
        case 102:
        {
            if (self.picTextField.text != nil) {
                _str =  self.picTextField.text;
                [self.picTextField resignFirstResponder];
                [self down];
            }else{
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"输入不能空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
                [alertView show];
            }
            
        }
            break;
            
        default:
            break;
    }

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellld = @"weatherCell";
    weatherCell *cell = [tableView dequeueReusableCellWithIdentifier:cellld forIndexPath:indexPath];
    myModel *model = _dataArr[indexPath.row];
    [cell showDataWithModel:model];
    return cell;}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
