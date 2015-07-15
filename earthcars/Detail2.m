//
//  Detail2.m
//  earthcars
//
//  Created by qianfeng on 15/7/10.
//  Copyright (c) 2015年 韩世民. All rights reserved.
//

#import "Detail2.h"
#import "ViewController.h"
@interface Detail2 ()

@end

@implementation Detail2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatPlay];
}
-(void)creatPlay{
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-64)];
    NSURLRequest *url= [NSURLRequest requestWithURL:[NSURL URLWithString:self.myurl]];
 
    
    [webView loadRequest:url];

    UIView *tarview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, 20)];
    tarview.backgroundColor = [UIColor whiteColor];
    
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 20, kScreenSize.width, 44)];
    view1.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"app_setting_feedback_bg"]];
    
    UIButton *backbutton = [MyControl creatButtonWithFrame:CGRectMake(10, 10, 30, 30) target:self sel:@selector(btnCick:) tag:101 image:@"app_full_screen_pre_no" title:nil];
    
    [view1 addSubview:backbutton];
    
    [self.view addSubview:webView];
    [self.view addSubview:tarview];
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
