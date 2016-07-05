//
//  WeiBoLogInHelper.m
//  kugou
//
//  Created by MCL on 16/7/5.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "WeiBoLogInHelper.h"

@implementation WeiBoLogInHelper

+ (instancetype)sharedManager{
    static WeiBoLogInHelper *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[WeiBoLogInHelper alloc] init];
    });
    return manager;
}

//- (instancetype)init{
//    
//    _request = [WBAuthorizeRequest request];
//    _request.redirectURI = WeiboRedirectURL;
//    _request.scope = @"all";
// 
//    return self;
//}

#pragma mark - WeiboSDKDelegate
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request{

}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response{
    if ([response isKindOfClass:WBAuthorizeResponse.class]) {
        NSString *message = [NSString stringWithFormat:@"%@: %d\nresponse.userId: %@\nresponse.accessToken: %@\n%@: %@\n%@: %@", NSLocalizedString(@"响应状态", nil), (int)response.statusCode,[(WBAuthorizeResponse *)response userID], [(WBAuthorizeResponse *)response accessToken],  NSLocalizedString(@"响应UserInfo数据", nil), response.userInfo, NSLocalizedString(@"原请求UserInfo数据", nil), response.requestUserInfo];
        NSLog(@"wb...%@",message);
        if (_delegate &&[_delegate respondsToSelector:@selector(weibomanagerDidRecvAuthResponse:)]) {
            [_delegate weibomanagerDidRecvAuthResponse:response];
        }
    }
    

}




@end
