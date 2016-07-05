//
//  LogInViewController.m
//  kugou
//
//  Created by MCL on 16/7/2.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "LogInViewController.h"
#import "LogInAndRegisterView.h"
#import "WeChatLogInHelper.h"

@interface LogInViewController ()<WeChatLogInHelperDelegate>

@end

@implementation LogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupLoginView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupLoginView{
    
    LogInAndRegisterView *loginView = [[LogInAndRegisterView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    loginView.closevcblock = ^{
        [self.view removeFromSuperview];
        //[[AppDelegate appDelegate].drawer.view willRemoveSubview:self.view];//效果同上
        //[self dismissViewControllerAnimated:YES completion:nil];//效果同上
    };
    
    loginView.wechatblock = ^{
        
        [WeChatLogInHelper sharedManager].delegate = self;
        SendAuthReq *req = [[SendAuthReq alloc] init];
        req.scope = @"snsapi_userinfo";
        req.state = @"foscam";
        req.openID = WEIXIN_APPID;
        [WXApi sendAuthReq:req viewController:self delegate:nil];
    };
    
    [self.view addSubview:loginView];
}

- (void)managerDidRecvAuthResponse:(SendAuthResp *)response{
    
    NSString *strMsg = [NSString stringWithFormat:@"code:%@,state:%@,errcode:%d", response.code, response.state, response.errCode];
    NSLog(@"wx_response =%@",strMsg);
    if (response.errCode !=0) {
        return;
    }
    //  code 换取access_token openid
    //  https://api.weixin.qq.com/sns/oauth2/access_token?appid=APPID&secret=SECRET&code=CODE&grant_type=authorization_code
    NSString *thisUrl =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",WEIXIN_APPID,WEIXIN_APPSECRET,response.code];
    NSLog(@"____wxthisUrl= %@", thisUrl);
    [[NetworkHelper sharedManager] getWithURL:thisUrl WithParmeters:nil compeletionWithBlock:^(id obj)
     {
         NSDictionary *dic = (NSDictionary *)obj;
         NSLog(@"____wx dic %@",dic);
     
        /*
         Printing description of obj:
         {
         "access_token" = "hNwJ3iqRqaksk7Z4tcX6XRNJyjaMUfEZ-qb2M_55CqUz_-N2mP3YJJta5BKh_lLBO7f_EsoiNRtjdpJdI9f6G2wUt81NpME725irdQTLyN0";
         "expires_in" = 7200;
         openid = oXq6kwFlWtdryBlf1vJHkfWcxFvE;
         "refresh_token" = "y-tOwfUTX8qbKDdnGl-wdKKsgTjvijxNTSxQRdkeM6krLiyWXn1CffGWlHDDyFSvyrF9_HSjhODYAjPdqst9Y0MwwZIkjsySt6Y2krcF-_4";
         scope = "snsapi_userinfo";
         unionid = "ob-GmuIHuf7_64bL3H_mwq-ZErAg";
         }
         */
        NSString *openid =[dic objectForKey:@"openid"];
        if (openid ==nil) {
            return ;
        }
        //用户access_token openid 换取用户信息
        NSString *access_token =[dic objectForKey:@"access_token"];
        [self getUserInfo:access_token andOpenid:openid];
    }];
    
}

-(void)getUserInfo:(NSString *)access_token andOpenid:(NSString *)openid{
    //    wx
    NSString *thisUrl =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",access_token,openid];
    //    weibo
    //NSString *thisUrl =[NSString stringWithFormat:@"https://api.weibo.com/2/users/show.json?access_token=%@&uid=%@",access_token,openid];
    
    [[NetworkHelper sharedManager] getWithURL:thisUrl WithParmeters:nil compeletionWithBlock:^(id obj) {
        NSDictionary *infoDic = (NSDictionary *)obj;
        NSLog(@"____wx infoDic %@", infoDic);
        /*
         ____wx infoDic {
         city = Shenzhen;
         country = CN;
         headimgurl = "http://wx.qlogo.cn/mmopen/Rx0CXKNtibrAAN1dnaahc80b6Orib3ECL0BIzaaia1au6dLZrqmnibQuTXLov6XmGukM26C6VWyAdoib0BU0Yw79wKT98aY36pEpic/0";
         language = "zh_CN";
         nickname = "\U4ee5\U94ed\U4ea6\U5fc3";
         openid = oXq6kwFlWtdryBlf1vJHkfWcxFvE;
         privilege =     (
         );
         province = Guangdong;
         sex = 2;
         unionid = "ob-GmuIHuf7_64bL3H_mwq-ZErAg";
         }
         */
        NSString *personImgUrl = infoDic[@"headimgurl"];
        
        if (personImgUrl) {
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:personImgUrl]];
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:imageData forKey:@"personImg"];
            [defaults synchronize];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"getPersonImgMsg" object:nil userInfo:@{@"personImg":imageData}];
        }
        [self.view removeFromSuperview];
    }];
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
