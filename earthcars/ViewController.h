//
//  ViewController.h
//  earthcars
//
//  Created by qianfeng on 15/7/11.
//  Copyright (c) 2015年 韩世民. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
@interface ViewController : UIViewController
{
    AFHTTPRequestOperationManager *_manager;
    NSString *_str;
    NSString *_titleStr;
 
}
@property(nonatomic,copy)NSString *str;;
   @property (nonatomic,copy)NSString *titleStr;
@property (weak, nonatomic) IBOutlet UITextView *textView;
- (IBAction)cancelBtn:(UIButton *)sender;
- (IBAction)certainBtn:(UIButton *)sender;

@end
