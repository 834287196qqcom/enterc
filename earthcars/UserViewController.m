//
//  UserViewController.m
//  earthcars
//
//  Created by qianfeng on 15/7/3.
//  Copyright (c) 2015年 韩世民. All rights reserved.
//

#import "UserViewController.h"
#import "seartypeCell.h"
#import "weatherController.h"
#import "myfavoriteController.h"
@interface UserViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    
}
-(void)down{
    NSLog(@"调用下载");
}
-(void)creatView{
    _myarr1 = @[@"爱车天气",@"清除缓存",@"我的收藏"];
    _myarr2 = @[@"关于我们"];
    _myarr3 = @[_myarr1,_myarr2];
    UIView *myview = [[UIView alloc] initWithFrame:CGRectMake(0, 20, kScreenSize.width,kScreenSize.height/3)];
    myview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"infor_center_head_bh.jpg"]];

    [self.view addSubview:myview];
    self.mytableView = [[UITableView alloc] initWithFrame:CGRectMake(0,kScreenSize.height/3+20, kScreenSize.width, kScreenSize.height-kScreenSize.height/3-20-49) style:UITableViewStylePlain];
    self.mytableView.dataSource = self;
    self.mytableView.delegate = self;

    [self.mytableView registerClass:[seartypeCell class] forCellReuseIdentifier:@"seartypeCell"];
    self.mytableView.tableFooterView = [[UIView alloc] init];
    
    [self.view addSubview:self.mytableView];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _myarr3.count;
}
-(void)creatRefresh{

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
 return 20;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_myarr3[section] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    seartypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"seartypeCell" forIndexPath:indexPath];
    cell.titleLabel.text = _myarr3[indexPath.section][indexPath.row];
    return cell;
    
}
-(CGFloat)getCanchSize{
    NSUInteger imageCacheSize = [[SDImageCache sharedImageCache] getSize];
    NSString  *myCachaePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/MyCaches"];
    NSDirectoryEnumerator *enumator = [[NSFileManager defaultManager] enumeratorAtPath:myCachaePath];
    __block NSUInteger count = 0 ;
    for (NSString *fileName in enumator) {
        NSString *path = [myCachaePath stringByAppendingPathComponent:fileName];
        NSDictionary *fileDict = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];
        count += fileDict.fileSize;
    }
    //得到字节，转化为M
    CGFloat  totalaSize = ((CGFloat)imageCacheSize + count)/1024/1024;
    
    return totalaSize;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case  0:
        {
            if (indexPath.row == 0) {
                weatherController *weaher = [[weatherController alloc] init];
                [self presentViewController:weaher animated:YES completion:nil];
                
            }else if(indexPath.row == 1){
                UIAlertController *sheet = [UIAlertController alertControllerWithTitle:@"清楚缓存" message:[NSString stringWithFormat:@"总共有%.2fM缓存",[self getCanchSize]] preferredStyle:UIAlertControllerStyleActionSheet];
                
                [sheet addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
                    NSLog(@"清理了");
                }]];
                [[SDImageCache sharedImageCache]clearDisk];
                [[SDImageCache sharedImageCache] clearMemory];
                
                NSString *myCachePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/MyCaches"];
                [[NSFileManager defaultManager] removeItemAtPath:myCachePath error:nil];
                [sheet addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                    
                }]];
                [self presentViewController:sheet animated:YES completion:nil];
            }else{
                myfavoriteController *fc = [[myfavoriteController alloc] init];
                
                UINavigationController * nav=[[UINavigationController alloc] initWithRootViewController:fc];
                [self presentViewController:nav animated:YES completion:nil];
            }
        }
            break;
        case  1:
        {
            if (indexPath.row == 0) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"关于" message:@"我们越努力，你们越方便" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alert show];
            }
        }
            break;
            
        default:
            break;
    }
   // NSLog(@"%ld,,,%ld",indexPath.section,indexPath.row);
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
