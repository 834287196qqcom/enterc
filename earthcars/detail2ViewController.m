//
//  detail2ViewController.m
//  earthcars
//
//  Created by qianfeng on 15/7/9.
//  Copyright (c) 2015年 韩世民. All rights reserved.
//

#import "detail2ViewController.h"

@interface detail2ViewController ()

@end

@implementation detail2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatPlay];
}
-(void)creatPlay{
    
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-64)];
    NSURLRequest *url= [NSURLRequest requestWithURL:[NSURL URLWithString:self.contentUrl]];
    [webView loadRequest:url];
    [self.view addSubview:webView];
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 20, kScreenSize.width, 44)];
    view1.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"app_setting_feedback_bg"]];
    UIButton *backbutton = [MyControl creatButtonWithFrame:CGRectMake(10, 10, 30, 30) target:self sel:@selector(btnCick:) tag:101 image:@"app_full_screen_pre_no" title:nil];
    UIButton *button = [MyControl creatButtonWithFrame:CGRectMake(kScreenSize.width-kScreenSize.width/2, 5, 30, 30) target:self sel:@selector(btnCick:) tag:102 image:@"infor_center_mycomment" title:nil];
    [view1 addSubview:button];
    UIButton *button1 = [MyControl creatButtonWithFrame:CGRectMake(kScreenSize.width-kScreenSize.width/2+40, 5, 30, 30) target:self sel:@selector(btnCick:) tag:103 image:@"app_listitem_top_default" title:nil];
    [view1 addSubview:button1];
    UIButton *button2 = [MyControl creatButtonWithFrame:CGRectMake(kScreenSize.width-kScreenSize.width/4, 5, 30, 30) target:self sel:@selector(btnCick:) tag:104 image:@"infor_center_myfavorite" title:nil];
    [view1 addSubview:button2];
    UIButton *button3 = [MyControl creatButtonWithFrame:CGRectMake(kScreenSize.width-kScreenSize.width/8, 5, 30, 30) target:self sel:@selector(btnCick:) tag:105 image:@"app_share_press" title:nil];
    [view1 addSubview:button3];
    
    [view1 addSubview:backbutton];
    [self.view addSubview:view1];
    
    
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
            
        }
            break;
        case 103:
        {
            
        }
            break;
        case 104:
        {
            
        }
            break;
        case 105:
        {
            
        }
            break;
        default:
            break;
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
