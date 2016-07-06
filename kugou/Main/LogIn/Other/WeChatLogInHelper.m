//
//  WeChatLogInHelper.m
//  kugou
//
//  Created by MCL on 16/7/5.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "WeChatLogInHelper.h"

@implementation WeChatLogInHelper

+ (instancetype)sharedManager{
    
    static WeChatLogInHelper *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[WeChatLogInHelper alloc] init];
    });
    return manager;
}

- (instancetype)init
{
    _sendAuthReq = [[SendAuthReq alloc] init];
    _sendAuthReq.scope = @"snsapi_userinfo";
    _sendAuthReq.state = @"foscam";
    _sendAuthReq.openID = WEIXIN_APPID;
    
    return self;
}

#pragma mark - WXApiDelegate
//如果第三方程序向微信发送了sendReq的请求，那么onResp会被回调。sendReq请求调用后，会切到微信终端程序界面。
- (void)onResp:(BaseResp *)resp{
    
    if ([resp isKindOfClass:[SendAuthResp class]]){
        
        if (_delegate
            && [_delegate respondsToSelector:@selector(managerDidRecvAuthResponse:)]) {
            SendAuthResp *authResp = (SendAuthResp *)resp;
            [_delegate managerDidRecvAuthResponse:authResp];
        }

//        SendAuthResp *response =(SendAuthResp *)resp;
//        NSDictionary *dict =[NSDictionary dictionaryWithObjectsAndKeys:response,@"response", nil];
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"wxResp" object:nil userInfo:dict];
    }
    
}

@end
