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

- (instancetype)init{
 
    _wbAuthorizeRequest = [WBAuthorizeRequest request];
    _wbAuthorizeRequest.redirectURI = WeiboRedirectURL;
    _wbAuthorizeRequest.scope = @"all";
//    _wbAuthorizeRequest.userInfo = @{@"SSO_From": @"SendMessageToWeiboViewController",
//                                     @"Other_Info_1": [NSNumber numberWithInt:123],
//                                     @"Other_Info_2": @[@"obj1", @"obj2"],
//                                     @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
//    
    return self;
}

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
