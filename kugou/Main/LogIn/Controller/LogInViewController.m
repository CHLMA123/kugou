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
#import "WeiBoLogInHelper.h"
#import "WeiboSDK.h"


@interface LogInViewController ()<WeChatLogInHelperDelegate, WeiBoLogInHelperDelegate>

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
    };
    
    loginView.wechatblock = ^{
        
        [WeChatLogInHelper sharedManager].delegate = self;
        [WXApi sendAuthReq:[WeChatLogInHelper sharedManager].sendAuthReq viewController:self delegate:nil];
    };
    
    loginView.weiboblock = ^{
        
        [WeiBoLogInHelper sharedManager].delegate = self;
        [WeiboSDK sendRequest:[WeiBoLogInHelper sharedManager].wbAuthorizeRequest];
    };
    
    [self.view addSubview:loginView];
}

#pragma mark - WeChatLogInHelperDelegate
- (void)managerDidRecvAuthResponse:(SendAuthResp *)resp{
    
    SendAuthResp *response = resp;
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
        NSString *openid =[dic objectForKey:@"openid"];
        if (openid ==nil) {
            return ;
        }
        //用户access_token openid 换取用户信息
        NSString *access_token =[dic objectForKey:@"access_token"];
        [self getUserWXInfo:access_token andOpenid:openid];
    }];
    
}

-(void)getUserWXInfo:(NSString *)access_token andOpenid:(NSString *)openid{
    [self.view removeFromSuperview];
    NSString *thisUrl =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",access_token,openid];
    [[NetworkHelper sharedManager] getWithURL:thisUrl WithParmeters:nil compeletionWithBlock:^(id obj)
     {
         NSDictionary *infoDic = (NSDictionary *)obj;
         NSLog(@"____wx infoDic %@", infoDic);
         NSString *personImgUrl = infoDic[@"headimgurl"];
         
         if (personImgUrl) {
             NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:personImgUrl]];
             NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
             [defaults setObject:imageData forKey:@"personImg"];
             [defaults synchronize];
             
             [[NSNotificationCenter defaultCenter] postNotificationName:@"getPersonImgMsg" object:nil userInfo:@{@"personImg":imageData}];
         }
         
     }];
}

#pragma mark - WeiBoLogInHelperDelegate
- (void)weibomanagerDidRecvAuthResponse:(WBBaseResponse *)resp{
    [self.view removeFromSuperview];
    WBBaseResponse *response = resp;
    
    if ([(WBAuthorizeResponse *)response userID] == nil) {
        return;
    }
    NSLog(@"wb id =%@",[(WBAuthorizeResponse *)response userID]);
    //   access_token uid 换成用户信息
    [self getUserweiboInfo:[(WBAuthorizeResponse *)response accessToken] andOpenid:[(WBAuthorizeResponse *)response userID]];
    
}

-(void)getUserweiboInfo:(NSString *)access_token andOpenid:(NSString *)openid{
    
    [self.view removeFromSuperview];
    //    weibo
    NSString *thisUrl =[NSString stringWithFormat:@"https://api.weibo.com/2/users/show.json?access_token=%@&uid=%@",access_token,openid];
    
//    NSString *thisUrl = @"https://api.weibo.com/2/users/show.json?";
//    NSDictionary *dic = @{@"access_token":access_token,@"uid":openid};
//    NSLog(@"%@", thisUrl);
    [[NetworkHelper sharedManager] getWithURL:thisUrl WithParmeters:nil compeletionWithBlock:^(id obj)
     {
         
         NSDictionary *infoDic = (NSDictionary *)obj;
         NSLog(@"____wb infoDic %@", infoDic);
         NSString *personImgUrl = infoDic[@"avatar_hd"];
         
         if (personImgUrl) {
             NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:personImgUrl]];
             NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
             [defaults setObject:imageData forKey:@"personImg"];
             [defaults synchronize];
             
             [[NSNotificationCenter defaultCenter] postNotificationName:@"getPersonImgMsg" object:nil userInfo:@{@"personImg":imageData}];
         }
         
     }];
}

#pragma mark - common
/*
 ____wb infoDic {
 "allow_all_act_msg" = 0;
 "allow_all_comment" = 1;
 "avatar_hd" = "http://tva2.sinaimg.cn/crop.0.38.539.539.1024/817ec04fjw8exwzyxgmqtj20fo0hsjsk.jpg";
 "avatar_large" = "http://tva2.sinaimg.cn/crop.0.38.539.539.180/817ec04fjw8exwzyxgmqtj20fo0hsjsk.jpg";
 "bi_followers_count" = 0;
 "block_app" = 0;
 "block_word" = 0;
 city = 1;
 class = 1;
 "cover_image_phone" = "http://ww1.sinaimg.cn/crop.0.0.640.640.640/549d0121tw1egm1kjly3jj20hs0hsq4f.jpg";
 "created_at" = "Sat Jun 11 11:02:50 +0800 2011";
 "credit_score" = 80;
 description = "";
 domain = "";
 "favourites_count" = 0;
 "follow_me" = 0;
 "followers_count" = 7;
 following = 0;
 "friends_count" = 19;
 gender = f;
 "geo_enabled" = 1;
 id = 2172567631;
 idstr = 2172567631;
 lang = "zh-cn";
 location = "\U6e56\U5317 \U6b66\U6c49";
 mbrank = 0;
 mbtype = 0;
 name = "\U4ee5\U94ed\U4ea6\U5fc3";
 "online_status" = 0;
 "pagefriends_count" = 2;
 "profile_image_url" = "http://tva2.sinaimg.cn/crop.0.38.539.539.50/817ec04fjw8exwzyxgmqtj20fo0hsjsk.jpg";
 "profile_url" = "u/2172567631";
 province = 42;
 ptype = 0;
 remark = "";
 "screen_name" = "\U4ee5\U94ed\U4ea6\U5fc3";
 star = 0;
 status =     {
 "attitudes_count" = 0;
 "biz_feature" = 0;
 "comments_count" = 0;
 "created_at" = "Sun Jan 03 22:12:28 +0800 2016";
 "darwin_tags" =         (
 );
 favorited = 0;
 geo = "<null>";
 "hot_weibo_tags" =         (
 );
 id = 3927323487388411;
 idstr = 3927323487388411;
 "in_reply_to_screen_name" = "";
 "in_reply_to_status_id" = "";
 "in_reply_to_user_id" = "";
 isLongText = 0;
 mid = 3927323487388411;
 mlevel = 0;
 "pic_urls" =         (
 );
 "positive_recom_flag" = 0;
 "reposts_count" = 0;
 source = "<a href=\"http://weibo.com/\" rel=\"nofollow\">\U5fae\U535a weibo.com</a>";
 "source_allowclick" = 0;
 "source_type" = 1;
 text = "\U6211\U4e0d\U6015\U4e00\U4e2a\U4eba\Uff0c\U5c31\U6015\U4e60\U60ef\U4e86\U4e00\U4e2a\U4eba\U7684\U751f\U6d3b\U7a81\U7136\U6709\U4eba\U6765\U6253\U6270\U6211\U7684\U4e00\U5207\U3002";
 textLength = 60;
 "text_tag_tips" =         (
 );
 truncated = 0;
 userType = 0;
 visible =         {
 "list_id" = 0;
 type = 0;
 };
 };
 "statuses_count" = 4;
 urank = 9;
 url = "";
 "user_ability" = 0;
 verified = 0;
 "verified_reason" = "";
 "verified_reason_url" = "";
 "verified_source" = "";
 "verified_source_url" = "";
 "verified_trade" = "";
 "verified_type" = "-1";
 weihao = "";
 }
 */

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
