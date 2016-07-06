//
//  WeiBoLogInHelper.h
//  kugou
//
//  Created by MCL on 16/7/5.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeiboSDK.h"

@protocol WeiBoLogInHelperDelegate <NSObject>

- (void)weibomanagerDidRecvAuthResponse:(WBBaseResponse *)resp;

@end
@interface WeiBoLogInHelper : NSObject<WeiboSDKDelegate>

@property (nonatomic, strong) WBAuthorizeRequest *wbAuthorizeRequest;

@property (nonatomic, assign) id<WeiBoLogInHelperDelegate> delegate;

+ (instancetype)sharedManager;

@end
