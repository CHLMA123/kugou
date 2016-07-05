//
//  LogInAndRegisterView.h
//  kugou
//
//  Created by MCL on 16/7/1.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^closeVCBlock)(void);
typedef void(^wechatloginBlock)(void);

@interface LogInAndRegisterView : UIView

@property(nonatomic, strong)closeVCBlock closevcblock;
@property(nonatomic, strong)wechatloginBlock wechatblock;
@end
