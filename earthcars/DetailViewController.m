//
//  DetailViewController.m
//  earthcars
//
//  Created by qianfeng on 15/7/9.
//  Copyright (c) 2015年 韩世民. All rights reserved.
//

#import "DetailViewController.h"
#import "UMSocial.h"
#import "mysqlite.h"
#import "Detail2.h"
#import "ViewController.h"
@interface DetailViewController ()<UMSocialUIDelegate,UIWebViewDelegate,UIScrollViewDelegate>

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArr = [[NSMutableArray alloc] init];
    // Do any additional setup after loading the view.
    [self creatPlay];
}
-(void)creatPlay{
    
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, -40, self.view.bounds.size.width, self.view.bounds.size.height)];
    NSURLRequest *url= [NSURLRequest requestWithURL:[NSURL URLWithString:self.contentUrl]];
    NSLog(@"%@",self.contentUrl);
    
    webView.tag=1001;
    webView.scrollView.delegate=self;
    webView.delegate=self;
    [webView loadRequest:url];
    //webView.scrollView.contentOffset=CGPointMake(0, 40);
    UIView *tarview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, 20)];
    tarview.backgroundColor = [UIColor whiteColor];
    
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 20, kScreenSize.width, 44)];
    view1.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"app_setting_feedback_bg"]];
    
    UIButton *backbutton = [MyControl creatButtonWithFrame:CGRectMake(10, 10, 30, 30) target:self sel:@selector(btnCick:) tag:101 image:@"app_full_screen_pre_no" title:nil];
    UIButton *button = [MyControl creatButtonWithFrame:CGRectMake(kScreenSize.width-kScreenSize.width/2+40, 10, 30, 30) target:self sel:@selector(btnCick:) tag:102 image:@"infor_center_mycomment" title:nil];
    [view1 addSubview:button];
//    UIButton *button1 = [MyControl creatButtonWithFrame:CGRectMake(kScreenSize.width-kScreenSize.width/2+40, 10, 30, 30) target:self sel:@selector(btnCick:) tag:103 image:@"app_listitem_top_default" title:nil];
//    [view1 addSubview:button1];
    UIButton *button2 = [MyControl creatButtonWithFrame:CGRectMake(kScreenSize.width-kScreenSize.width/4,10, 30, 30) target:self sel:@selector(btnCick:) tag:104 image:@"infor_center_myfavorite" title:nil];
    [view1 addSubview:button2];
    UIButton *button3 = [MyControl creatButtonWithFrame:CGRectMake(kScreenSize.width-kScreenSize.width/8, 10, 30, 30) target:self sel:@selector(btnCick:) tag:105 image:@"app_share_press" title:nil];
    
    [view1 addSubview:button3];
    [view1 addSubview:backbutton];
    
    [self.view addSubview:webView];
    [self.view addSubview:tarview];
     [self.view addSubview:view1];
//    UIView *whiteview = [[UIView alloc] initWithFrame:CGRectMake(0, -77, kScreenSize.width, 97)];
//    whiteview.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:whiteview];
    
    UIButton *comBtn = [MyControl creatButtonWithFrame:CGRectMake(0, kScreenSize.height-30, kScreenSize.width, 30) target:self sel:@selector(commentbtnCick) tag:103 image:nil title:@"点此评论"];
    
    [self.view addSubview:comBtn];
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat cury=scrollView.contentOffset.y;
    if (cury<=0) {
        CGPoint point=CGPointMake(0, 0);
        scrollView.contentOffset=point;
    }
    if (cury>=(scrollView.contentSize.height-(kScreenSize.height)-350)) {
        CGPoint point=CGPointMake(0, (scrollView.contentSize.height-(kScreenSize.height))-350);
        scrollView.contentOffset=point;
    }
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
            [self down];
        }
            break;
 
        
        case 104:
        {
            BOOL isref = YES;
            NSArray *arr = [[mysqlite sharedManager] findModel];
            
            if (arr == nil) {
                [[mysqlite sharedManager] insertModel:self.model];
                button.enabled = NO;
            }else{
                for (myModel *model1 in arr) {
                    if ([model1.title isEqualToString :self.model.title]) {
                        isref = NO;
                    }else{
                        isref = YES;
                        break;
                    }
                }
                if (isref == YES) {
                    [[mysqlite sharedManager] insertModel:self.model];
                    button.enabled = NO;
                }else{
                }
            }

        }
            break;
        case 105:
        {
            [self share];
        }
            break;
        default:
            break;
    }
    
}
-(void)commentbtnCick{
    ViewController *vc = [[ViewController alloc] init];
    vc.titleStr = self.model.title;
    NSLog(@"%@",vc.titleStr);
    vc.str = self.contentUrl;
    NSLog(@"%@",vc.str);
    [self presentViewController:vc animated:YES completion:nil];
}
-(void)down{
    _manager = [[AFHTTPRequestOperationManager alloc] init];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [self addTaskUrl:[NSString stringWithFormat:pinglun,self.contentUrl]];
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
                myModel  *model = [[myModel alloc] init];
                [model setValuesForKeysWithDictionary:dict];
                NSLog(@"%@",model.url43g);
                Detail2 *det = [[Detail2 alloc] init];
                det.myurl = model.url43g;
            [self presentViewController:det animated:YES completion:nil];
                [mySelf.dataArr addObject:model];
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"下载失败");
    }];
}
-(void)share{
    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"507fcab25270157b37000010" shareText:self.contentUrl shareImage:[UIImage imageNamed: @"dd_recommend_qrcode"] shareToSnsNames:@[UMShareToSina,UMShareToEmail,UMShareToSms,UMShareToWechatTimeline,UMShareToDouban,UMShareToLWTimeline] delegate:self];
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
