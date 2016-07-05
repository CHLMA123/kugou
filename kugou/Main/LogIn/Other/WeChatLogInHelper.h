//
//  WeChatLogInHelper.h
//  kugou
//
//  Created by MCL on 16/7/5.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"

@protocol WeChatLogInHelperDelegate <NSObject>

- (void)managerDidRecvAuthResponse:(SendAuthResp *)response;

@end

@interface WeChatLogInHelper : NSObject<WXApiDelegate>

@property (nonatomic, assign) id<WeChatLogInHelperDelegate> delegate;

+ (instancetype)sharedManager;

@end
