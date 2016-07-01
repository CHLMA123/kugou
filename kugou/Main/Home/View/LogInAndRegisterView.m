//
//  LogInAndRegisterView.m
//  kugou
//
//  Created by MCL on 16/7/1.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "LogInAndRegisterView.h"

@implementation LogInAndRegisterView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self commitInitView];
        
    }
    return self;
}

- (void)commitInitView{

    self.backgroundColor = [UIColor whiteColor];
    
    UIImageView *bgImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    bgImageV.image = [UIImage imageNamed:@"newUserLoginBg.jpg"];
    [self addSubview:bgImageV];
    
    UIImageView *closeImageV = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 50, 50)];
    closeImageV.image = [UIImage imageNamed:@"01dog"];
    [bgImageV addSubview:closeImageV];
    
    CGFloat otherOrignalx = 30;
    
    UIView *logoV = [[UIView alloc] initWithFrame:CGRectMake(otherOrignalx, self.center.y - 150, SCREEN_WIDTH - 2*otherOrignalx, 90)];
    UIImageView *logoImageV = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 90, 90)];
    logoImageV.image = [UIImage imageNamed:@"kugou"];
    [logoV addSubview:logoImageV];
    
    UILabel *logoLbl1 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(logoImageV.frame) + 10, 5, logoV.width - logoImageV.width - 15, 50)];
    logoLbl1.text = @"酷狗音乐";
    logoLbl1.font = [UIFont systemFontOfSize:32];
    logoLbl1.textColor = [UIColor whiteColor];
    logoLbl1.textAlignment = NSTextAlignmentCenter;
    [logoV addSubview:logoLbl1];
    UILabel *logoLbl2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(logoImageV.frame) + 10, 55, logoV.width - logoImageV.width - 15, 40)];
    logoLbl2.text = @"不 变 的 只 有 音 乐";
    logoLbl2.font = [UIFont systemFontOfSize:15];
    logoLbl2.textColor = [UIColor whiteColor];
    logoLbl2.textAlignment = NSTextAlignmentCenter;
    [logoV addSubview:logoLbl2];
    [bgImageV addSubview:logoV];
    
    UIButton *logInBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    logInBtn.frame = CGRectMake(otherOrignalx, self.center.y + 30, SCREEN_WIDTH - otherOrignalx*2, 44);
    [logInBtn setTitle:@"LogIn" forState:UIControlStateNormal];
    [logInBtn setBackgroundColor:[[UIColor blueColor] colorWithAlphaComponent:0.65]];
    [logInBtn addTarget:self action:@selector(logInAction) forControlEvents:UIControlEventTouchUpInside];
    CGRect rect = CGRectMake(0, 0, logInBtn.width, logInBtn.height);
    CGSize size = CGSizeMake(3, 3);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:size];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.path = path.CGPath;
    maskLayer.frame = logInBtn.bounds;
    logInBtn.layer.mask = maskLayer;
    
    [bgImageV addSubview:logInBtn];
    
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registerBtn.frame = CGRectMake(otherOrignalx, CGRectGetMaxY(logInBtn.frame) + 10, SCREEN_WIDTH - otherOrignalx*2, 44);
    [registerBtn setTitle:@"Register" forState:UIControlStateNormal];
    [registerBtn setBackgroundColor:[[UIColor greenColor] colorWithAlphaComponent:0.65]];
    [registerBtn addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    CGRect rect1 = CGRectMake(0, 0, registerBtn.width, registerBtn.height);
    CGSize size1 = CGSizeMake(3, 3);
    UIBezierPath *path1 = [UIBezierPath bezierPathWithRoundedRect:rect1 byRoundingCorners:UIRectCornerAllCorners cornerRadii:size1];
    CAShapeLayer *maskLayer1 = [[CAShapeLayer alloc] init];
    maskLayer1.path = path1.CGPath;
    maskLayer1.frame = registerBtn.bounds;
    registerBtn.layer.mask = maskLayer1;
    
    [bgImageV addSubview:registerBtn];
    
    UILabel *otherLbl = [[UILabel alloc] init];
    otherLbl.frame = CGRectMake(otherOrignalx, CGRectGetMaxY(registerBtn.frame) + 50, SCREEN_WIDTH - 2 *otherOrignalx, 20);
    otherLbl.text = @"----------其它登录方式----------";
    otherLbl.textAlignment = NSTextAlignmentCenter;
    otherLbl.textColor = [UIColor whiteColor];
    [bgImageV addSubview:otherLbl];
    
    CGFloat otherBtnY = CGRectGetMaxY(otherLbl.frame) + (SCREEN_HEIGHT - CGRectGetMaxY(otherLbl.frame)- 50)*0.5;
    CGFloat otherBtnWMargin = (SCREEN_WIDTH - otherOrignalx*2 - 150)/4;
    
    UIButton *weiboBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    weiboBtn.frame = CGRectMake(otherOrignalx + otherBtnWMargin, otherBtnY, 50, 50);
//    weiboBtn.layer.borderColor = [UIColor whiteColor].CGColor;
//    weiboBtn.layer.borderWidth = 1;
    [weiboBtn setImage:[UIImage imageNamed:@"login-weibo"] forState:UIControlStateNormal];
    [weiboBtn addTarget:self action:@selector(weibologinAction) forControlEvents:UIControlEventTouchUpInside];
    [bgImageV addSubview:weiboBtn];
    
    UIButton *qqBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    qqBtn.frame = CGRectMake(CGRectGetMaxX(weiboBtn.frame) + otherBtnWMargin, otherBtnY, 50, 50);
//    qqBtn.layer.borderColor = [UIColor whiteColor].CGColor;
//    qqBtn.layer.borderWidth = 1;
    [qqBtn setImage:[UIImage imageNamed:@"login-qq"] forState:UIControlStateNormal];
    [qqBtn addTarget:self action:@selector(qqloginAction) forControlEvents:UIControlEventTouchUpInside];
    [bgImageV addSubview:qqBtn];
    
    UIButton *wechatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    wechatBtn.frame = CGRectMake(CGRectGetMaxX(qqBtn.frame) + otherBtnWMargin, otherBtnY, 50, 50);
//    wechatBtn.layer.borderColor = [UIColor whiteColor].CGColor;
//    wechatBtn.layer.borderWidth = 1;
    [wechatBtn setImage:[UIImage imageNamed:@"login-wexin"] forState:UIControlStateNormal];
    [wechatBtn addTarget:self action:@selector(wechatBtnloginAction) forControlEvents:UIControlEventTouchUpInside];
    [bgImageV addSubview:wechatBtn];
    
}


- (void)logInAction{
    LOG_METHOD;
}

- (void)registerAction{
    LOG_METHOD;
}

- (void)weibologinAction{
    LOG_METHOD;
}

- (void)qqloginAction{
    LOG_METHOD;
}

- (void)wechatBtnloginAction{
    LOG_METHOD;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
