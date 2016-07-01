//
//  LogInAndRegisterView.h
//  kugou
//
//  Created by MCL on 16/7/1.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^pushBlock)(NSString *imgURL);
@interface LogInAndRegisterView : UIView

@property(nonatomic, strong)pushBlock pushblcok;

@end
