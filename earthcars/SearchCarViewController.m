//
//  SearchCarViewController.m
//  earthcars
//
//  Created by qianfeng on 15/7/3.
//  Copyright (c) 2015年 韩世民. All rights reserved.
//

#import "SearchCarViewController.h"
#import "searchViewController.h"
#import "seartypeCell.h"
#import "myModel.h"
#import "conditionController.h"
#import "searchPaiZiViewController.h"
@interface SearchCarViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *_type;
    NSArray *_idArr;
    NSArray *_A;
    NSArray *_B;
    NSArray *_C;
    NSArray *_D;
    NSArray *_F;
    NSArray *_G;
    NSArray *_H;
    NSArray *_J;
    NSArray *_K;
    NSArray *_L;
    NSArray *_M;
    NSArray *_N;
    NSArray *_O;
    NSArray *_P;
    NSArray *_Q;
    NSArray *_R;
    NSArray *_S;
    NSArray *_T;
    NSArray *_W;
    NSArray *_X;
    NSArray *_Y;
    NSArray *_Z;
    NSArray *_AA;
    NSArray *_BB;
    NSArray *_CC;
    NSArray *_DD;
    NSArray *_FF;
    NSArray *_GG;
    NSArray *_HH;
    NSArray *_JJ;
    NSArray *_KK;
    NSArray *_LL;
    NSArray *_MM;
    NSArray *_NN;
    NSArray *_OO;
    NSArray *_PP;
    NSArray *_QQ;
    NSArray *_RR;
    NSArray *_SS;
    NSArray *_TT;
    NSArray *_WW;
    NSArray *_XX;
    NSArray *_YY;
    NSArray *_ZZ;
    BOOL isLeft;
    BOOL isRight;
    UIView *allView;
}
@property (nonatomic,strong)NSArray *type;

@end

@implementation SearchCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *heiheiView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, 20)];
    heiheiView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:heiheiView];
    //self.automaticallyAdjustsScrollViewInsets = NO;
   // self.view.backgroundColor = [UIColor lightGrayColor];
    self.navigationController.navigationBarHidden  =YES;
    //[self creatView];
    UIView *myview = [[UIView alloc] initWithFrame:CGRectMake(0, 20, kScreenSize.width, 44)];
    myview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"app_setting_feedback_bg"]];
    //myview.backgroundColor = [UIColor blueColor];
    UIButton *button = [MyControl creatButtonWithFrame:CGRectMake(10, 10, 30, 30) target:self sel:@selector(btnclick:) tag:101 image:@"infor_center_front_search_night" title:nil];
    UILabel *label = [MyControl creatLabelWithFrame:CGRectMake(kScreenSize.width/3+40, 0, kScreenSize.width/2, 44) text:@"地球汽车站"];
    label.font = [UIFont systemFontOfSize:18];
    label.textColor =[UIColor whiteColor];
    [myview addSubview:label];
    [myview addSubview:button];
    [self.view addSubview:myview];
    
    UIButton *button1= [MyControl creatButtonWithFrame:CGRectMake(0, 64, kScreenSize.width/2, 30) target:self sel:@selector(btnclick:) tag:102 image:nil title:@"按品牌"];
    button1.backgroundColor = [UIColor lightGrayColor];
    
    UIButton *button2 = [MyControl creatButtonWithFrame:CGRectMake(kScreenSize.width/2, 64, kScreenSize.width/2, 30) target:self sel:@selector(btnclick:) tag:103 image:nil title:@"按条件"];
    button2.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:button1];
    [self.view addSubview:button2];
    isLeft = NO;
    isRight = YES;
}
-(void)creatRefresh{
    NSLog(@"不刷新");
}
-(void)down{
    NSLog(@"调用下载了");
}
-(void)creatView{
    
    _A = @[@"奥迪",@"AC宝马",@"阿斯顿马丁",@"AMG",@"阿尔法罗密欧"];
    _B = @[@"宝马",@"奔驰",@"本田",@"别克",@"保时捷",@"比亚迪",@"宾利",@"标志",@"宝俊",@"奔腾",@"北京",@"布加迪",@"北汽绅宝",@"北汽制造",@"巴博斯",@"北汽威旺",@"北汽新能源"];
    _C = @[@"长安",@"长城",@"长安商用",@"昌河",@"成功"];
    _D = @[@"大众",@"东风",@"东风风神",@"DS",@"东风风行",@"道奇",@"东南",@"东风风度",@"东风小康",@"大迪"];
    _F = @[@"丰田",@"福特",@"法拉利",@"菲亚特",@"福田",@"福迪",@"福汽启腾",@"Fisker",@"FM Auto"];
    _G =@[@"广汽传祺",@"观致",@"GMC",@"广汽吉奥",@"光冈"];
    _H = @[@"哈佛",@"海马",@"红旗",@"悍马",@"华泰",@"哈飞",@"海马郑州",@"黄海",@"海格",@"华普",@"恒天",@"花颂"];
    _J =@[@"Jeep",@"吉利汽车",@"捷豹",@"江淮",@"江铃",@"金杯",@"金龙汽车",@"九龙",@"金旅"];
    _K = @[@"凯迪拉克",@"克莱斯勒",@"科尼赛克",@"开瑞",@"KTM",@"凯马",@"凯翼",@"卡尔森",@"克瑞斯的",@"卡威汽车",@"康迪"];
    _L = @[@"路虎",@"兰博基尼",@"雷克萨斯",@"猎豹汽车",@"劳斯莱斯",@"林肯",@"铃木",@"陆风",@"雷诺",@"莲花",@"力帆",@"劳伦士",@"LOCAL MOTORS",@"路特斯",@"陆地方舟",@"雷丁",@"理念",@"朗世",@"领志"];
    _M = @[@"马自达",@"玛莎拉蒂",@"MINI",@"MG名爵",@"迈巴赫",@"迈凯伦",@"摩根"];
    _N = @[@"纳睿智",@"南京金龙",@"Noble",@"nanoFLOWCELL"];
    _O = @[@"讴歌",@"欧宝",@"欧朗"];
    _P = @[@"帕加尼"];
    _Q = @[@"起亚",@"奇瑞",@"启辰",@"前途"];
    _R = @[@" 日产",@"荣威",@"瑞麟",@"Rossion"];
    _S = @[@"斯柯达",@"三菱",@"斯巴鲁",@"Smart",@"双龙",@"上汽大通MAXUS",@"萨博",@"世爵",@"思铭",@"双环",@"赛麟"];
    _T = @[@"特拉斯",@"泰卡特",@"腾势"];
    _W = @[@"沃尔沃",@"五菱",@"五十铃",@"威兹曼",@"威麟",@"沃克斯豪尔",@"W Motors"];
    _X = @[@"现代",@"雪佛兰",@"雪铁龙",@"西雅特"];
    _Y = @[@"英菲尼迪",@"一汽",@"野马汽车",@"依维柯",@"英制",@"御捷",@"永源"];
    _Z = @[@"众泰",@"中华",@"中兴",@"知豆",@"中欧",@"中顺",@"Zenvo",@"之诺"];
    _type = @[_A,_B,_C,_D,_F,_G,_H,_J,_K,_L,_M,_N,_O,_P,_Q,_R,_S,_T,_W,_X,_Y,_Z];
    
    _AA = @[@"1",@"693",@"62",@"959",@"60"];
    _BB = @[@"20",@"4",@"3",@"7",@"44",@"107",@"45",@"41",@"582",@"306",@"593",@"63",@"814",@"122",@"723",@"643",@"950"];
    _CC = @[@"124",@"110",@"613",@"75",@"990"];
    _DD = @[@"2",@"111",@"581",@"754",@"949",@"72",@"16",@"877",@"856",@"235"];
    _FF = @[@"10",@"21",@"61",@"18",@"103",@"116",@"878",@"794",@"834"];
    _GG =@[@"571",@"824",@"265",@"195",@"567"];
    _HH = @[@"845",@"8",@"396",@"59",@"115",@"82",@"583",@"133",@"876",@"81",@"855",@"1001"];
    _JJ =@[@"3",@"13",@"26",@"78",@"101",@"83",@"355",@"568",@"114"];
    _KK = @[@"70",@"39",@"570",@"578",@"888",@"1075",@"970",@"704",@"991",@"1012"];
    _LL = @[@"29",@"64",@"30",@"58",@"47",@"66",@"73",@"569",@"40",@"46",@"305",@"663",@"1085",@"653",@"939",@"1022",@"604",@"844",@"1011"];
    _MM = @[@"17",@"316",@"205",@"345",@"387",@"715",@"908"];
    _NN = @[@"623",@"1053",@"1032",@"1033"];
    _OO = @[@"140",@"22",@"703"];
    _PP = @[@"573"];
    _QQ = @[@"12",@"57",@"633",@"1074"];
    _RR = @[@"15",@"365",@"580",@"574"];
    _SS = @[@"69",@"32",@"49",@"603",@"53",@"673",@"23",@"546",@"733",@"119",@"980"];
    _TT = @[@"774",@"969",@"743"];
    _WW = @[@"24",@"118",@"918",@"753",@"579",@"764",@"1064"];
    _XX = @[@"34",@"225",@"6",@"154"];
    _YY = @[@"28",@"9",@"516",@"132",@"919",@"1063",@"275"];
    _ZZ = @[@"307",@"104",@"125",@"929",@"506",@"325",@"1043",@"866 "];
    _idArr = @[_AA,_BB,_CC,_DD,_FF,_GG,_HH,_JJ,_KK,_LL,_MM,_NN,_OO,_PP,_QQ,_RR,_SS,_TT,_WW,_XX,_YY,_ZZ];
    
    allView =[[UIView alloc] initWithFrame:CGRectMake(0, 35, kScreenSize.width*2, kScreenSize.height-94)];
    
    self.mytableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 35
, kScreenSize.width, kScreenSize.height-94) style:UITableViewStylePlain];
    self.mytableView.dataSource = self;
    self.mytableView.delegate = self;
    
    [self.mytableView registerClass:[seartypeCell class] forCellReuseIdentifier:@"seartypeCell"];
    
    [allView addSubview:self.mytableView];

    UILabel *label5 = [MyControl creatLabelWithFrame:CGRectMake(kScreenSize.width + kScreenSize.width/3+20, kScreenSize.height/6, 100, 50) text:@"价格区间(/w)"];
    label5.textColor = [UIColor blueColor];
    label5.font = [UIFont systemFontOfSize:15];
    
    //label5.textColor = [UIColor whiteColor];
    [allView addSubview:label5];
    
    textf = [[UITextField alloc] initWithFrame:CGRectMake(kScreenSize.width + kScreenSize.width/3+20, kScreenSize.height/4, 50, 50)];
    textf.placeholder = @"0";
     [allView addSubview:textf];
    //textf.textColor = [UIColor whiteColor];
    UILabel *dao = [MyControl creatLabelWithFrame:CGRectMake(kScreenSize.width+kScreenSize.width/3+20, kScreenSize.width/2+25, 50, 30) text:@"到"];
    dao.textColor = [UIColor blueColor];
    dao.font = [UIFont systemFontOfSize:15];
    [allView addSubview:dao];
   
    textf1 = [[UITextField alloc] initWithFrame:CGRectMake(kScreenSize.width +kScreenSize.width/3+20, kScreenSize.width/2+50, 50, 50)];
    textf1.placeholder = @"100+";
    //textf1.textColor = [UIColor whiteColor];
    [allView addSubview:textf1];
    
    UIButton *searbut = [MyControl creatButtonWithFrame:CGRectMake(kScreenSize.width+kScreenSize.width/2+100, kScreenSize.width/2+50, 50, 50) target:self sel:@selector(btnclick:) tag:104 image:nil title:@"搜索"];
    [allView addSubview:searbut];
    
    [self.view addSubview:allView];
    
    lowView = [[UIView alloc] initWithFrame:CGRectMake(kScreenSize.width/4, 64+40, kScreenSize.width-kScreenSize.width/4, kScreenSize.height-104-70)];
   // lowView.userInteractionEnabled = YES;
    lowView.backgroundColor = [UIColor yellowColor];
    lowView.alpha = 0;
    
    [self.view addSubview:lowView];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _type.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_type[section] count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    seartypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"seartypeCell" forIndexPath:indexPath];
    cell.titleLabel.text = self.type[indexPath.section][indexPath.row];
    return cell;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [NSString stringWithFormat:@"%C",(unichar)('A'+section)];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    searchPaiZiViewController *searPaiZi = [[searchPaiZiViewController alloc] init];
    searPaiZi.abc = _idArr[indexPath.section][indexPath.row];
    NSLog(@"%@",_idArr[indexPath.section][indexPath.row]);
    [self presentViewController:searPaiZi animated:YES completion:nil];
    
//    if (lowView.alpha == 0) {
//        lowView.alpha = 1;
//    }else{
//    lowView.alpha = 0;
//    }
    


}
-(void)btnclick:(UIButton *)button{
    switch (button.tag) {
        case 101:
        {
            searchViewController *sea = [[searchViewController alloc] init];
            [self.navigationController pushViewController:sea animated:YES];
        }
            break;
        case 102:
        {
           
            if (isLeft == YES) {
                CGPoint r =  allView.center;
                r.x +=kScreenSize.width;
                [UIView beginAnimations:nil context:NULL];
                [UIView setAnimationDuration:0.5];
                allView.center = r;
                [UIView commitAnimations];
                isRight = YES;
                isLeft = NO;

            }
            }
            break;
        case 103:
        {
            if (isRight == YES) {
                CGPoint r =  allView.center;
                r.x -=kScreenSize.width;
                [UIView beginAnimations:nil context:NULL];
                [UIView setAnimationDuration:0.5];
                allView.center = r;
                [UIView commitAnimations];
                isLeft = YES;
                isRight = NO;
            }
            
        }
            break;
        case 104:
        {
        //NSLog(@"%@,,,,%@",textf.text,textf1.text);
//           NSString *regex = @"^[0~9]{0~5}$";
//            NSPredicate *passregex = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
//            BOOL B = [passregex evaluateWithObject:textf.text];
//            BOOL C = [passregex evaluateWithObject:textf1.text];
//            if (!B&&!C) {
//            UIAlertView *alertView  = [[UIAlertView alloc] initWithTitle:@"没有相关信息" message:@"请重新输入" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//                    [alertView show];
//                
//            }else{
                conditionController *condition = [[conditionController alloc] init];
                condition.from = textf.text.intValue;
                condition.to = textf1.text.intValue;
                
                [self presentViewController:condition animated:YES completion:nil];
            //}
            
            
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
