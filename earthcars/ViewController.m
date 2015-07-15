//
//  ViewController.m
//  earthcars
//
//  Created by qianfeng on 15/7/11.
//  Copyright (c) 2015年 韩世民. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _manager = [[AFHTTPRequestOperationManager alloc] init];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
}
-(void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    [alertView show];
    
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

- (IBAction)cancelBtn:(UIButton *)sender {
    self.textView.text = @"";
    [self.textView resignFirstResponder];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)certainBtn:(UIButton *)sender {
    [self.textView resignFirstResponder];
    if (self.textView.text.length < 3) {
        [self showAlertViewWithTitle:@"警告" message:@"评论内容不能少于三个字"];
        return;
    }
    
    NSDictionary *dict = @{
                           @"username":@"匿名网友",
                           @"content":self.textView.text,
                           @"url":self.str,
                           @"client":@"2",
                           @"id":@"13289550",
                           @"title":self.titleStr
                           };
    [_manager POST:mycomment parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"成功");
        NSDictionary *dict1 = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        //NSLog(@"dict1:%@",dict1);
            NSString *sstr =dict1[@"resultMsg"];
            [self showAlertViewWithTitle:@"警告" message:sstr];
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"失败");
        
        
    }];
}
@end
