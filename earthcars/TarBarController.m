//
//  TarBarController.m
//  earthcars
//
//  Created by qianfeng on 15/7/3.
//  Copyright (c) 2015年 韩世民. All rights reserved.
//

#import "TarBarController.h"

#import "ContainerViewController.h"


#import "FirstViewController.h"
#import "ForumViewController.h"
#import "SearchCarViewController.h"
#import "UserViewController.h"

#import "firstController.h"
#import "NewCarViewController.h"
#import "commentViewController.h"
#import "MarketViewController.h"
#import "NowViewController.h"
#import "BuyViewController.h"
#import "VideoViewController.h"
#import "VisitViewController.h"
#import "ContestViewController.h"

#import "BridgeViewController.h"
#import "secOutViewController.h"
#import "heightViewController.h"
NSInteger cur;
@interface TarBarController ()

@end

@implementation TarBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
}
-(void)creatUI{
    self.navigationController.navigationBarHidden  =NO;
    //self.automaticallyAdjustsScrollViewInsets = YES;
    NSMutableArray *vcArr = [[NSMutableArray alloc] initWithCapacity:0];
    NSArray *netArr = @[@"ContainerViewController",@"ContainerViewController",@"SearchCarViewController",@"UserViewController"];
    NSArray *picArr = @[@"app_information_tab_default.9",@"app_bbs_tab_default.9",@"app_car_tab_default_night.9",@"app_tab_infocenter_default.9"];
    //NSArray *titletarArr = @[@"首页",@"论坛",@"找车",@"优惠",@"我的"];
    
    for (NSInteger i = 0; i < netArr.count; i++) {
        Class cls = NSClassFromString(netArr[i]);
        UIViewController *app = [[cls alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:app];
        //nav.title = titletarArr[i];
        if (i == 0) {
            firstController *first = [[firstController alloc] init];
            first.title = @"首页";
            NewCarViewController *second = [[NewCarViewController alloc] init];
            second.title = @"新车";
            commentViewController *third = [[commentViewController alloc] init];
            third.title = @"评测";
            MarketViewController *four = [[MarketViewController alloc] init];
            four.title = @"行情";
            NowViewController *five = [[NowViewController alloc] init];
            five.title = @"直播";
            ContestViewController *eight = [[ContestViewController alloc] init];
            eight.title = @"赛事";
            BuyViewController *buy = [[BuyViewController alloc] init];
            buy.title = @"导购";
//            VideoViewController *six = [[VideoViewController alloc] init];
//            six.title = @"视频";
            VisitViewController *seven = [[VisitViewController alloc] init];
            seven.title = @"游记";
            ContainerViewController *container = (ContainerViewController *)app;
            container.viewControllers = @[first,second,third,four,five,eight,buy,seven];
        
        }else if(i == 1){
            BridgeViewController *first = [[BridgeViewController alloc] init];
            first.title =@"车有话说";
            secOutViewController *second = [[secOutViewController alloc] init];
            second.title = @"进口汽车";
            heightViewController *third = [[heightViewController alloc] init];
            third.title =@"高端汽车";
            ContainerViewController *container = (ContainerViewController *)app;
            container.viewControllers = @[first,second,third];
        }
        nav.tabBarItem.image = [UIImage imageNamed: picArr[i]];
        [vcArr addObject:nav];
    }
      cur=self.selectedIndex;
    self.viewControllers =  vcArr;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    cur=self.selectedIndex;
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
