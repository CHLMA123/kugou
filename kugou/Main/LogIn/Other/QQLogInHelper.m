//
//  QQLogInHelper.m
//  kugou
//
//  Created by MCL on 16/7/2.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "QQLogInHelper.h"
#import <TencentOpenAPI/TencentApiInterface.h>

@interface QQLogInHelper ()<TencentSessionDelegate>

@end

@implementation QQLogInHelper

+ (instancetype)sharedManager{

    static QQLogInHelper *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[QQLogInHelper alloc] init];
    });
    return manager;
}

- (id)init{
    
    _tencentOAuth = [[TencentOAuth alloc] initWithAppId:TENCENTQQ_APPID andDelegate:self];
    return self;
}

#pragma mark -- TencentSessionDelegate
/**
 * 登录成功后的回调
 */
- (void)tencentDidLogin{

    if (_tencentOAuth.accessToken && _tencentOAuth.accessToken.length != 0) {
        NSLog(@"登录成功, _tencentOAuth.accessToken = %@", _tencentOAuth.accessToken);
        [_tencentOAuth getUserInfo];
        [[NSNotificationCenter defaultCenter] postNotificationName:qqLoginSuccessed object:self];
    }else{
        NSLog(@"登录失败");
        
    }
}

/**
 * 登录失败后的回调
 * \param cancelled 代表用户是否主动退出登录
 */
- (void)tencentDidNotLogin:(BOOL)cancelled
{
    NSLog(@"用户取消登录 Or 登录失败");
    [[NSNotificationCenter defaultCenter] postNotificationName:qqLoginCancelled object:self];
}

/**
 * 登录时网络有问题的回调
 */
- (void)tencentDidNotNetWork
{
    NSLog(@"无网络连接，请设置网络");
    [[NSNotificationCenter defaultCenter] postNotificationName:qqLoginFailed object:self];
}

/**
 * 登录时权限信息的获得
 */
//- (NSArray *)getAuthorizedPermissions:(NSArray *)permissions withExtraParams:(NSDictionary *)extraParams{
//
//}

- (void)getUserInfoResponse:(APIResponse *)response
{
    NSLog(@"response = %@",response.jsonResponse);
    NSDictionary *dic = response.jsonResponse;
    NSString *personImgUrl = dic[@"figureurl_qq_2"];
    
    if (personImgUrl) {
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:personImgUrl]];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:imageData forKey:@"personImg"];
        [defaults synchronize];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"getPersonImgMsg" object:nil userInfo:@{@"personImg":imageData}];
    }
    
}


@end
