//
//  QQLogInHelper.h
//  kugou
//
//  Created by MCL on 16/7/2.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QQLogInHelper : NSObject

@property (nonatomic, strong) TencentOAuth *tencentOAuth;

+ (instancetype)sharedManager;

@end
