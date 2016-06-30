//
//  LeftSlideViewController.h
//  kugou
//
//  Created by MCL on 16/6/30.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "BaseViewController.h"


@interface LeftSlideViewController : BaseViewController

//侧滑窗是否关闭(关闭时显示为主页)
@property (nonatomic, assign) BOOL isClose;

/**
 *  初始化侧滑控制器
 *
 *  @param centerViewController 中间视图控制器
 *  @param leftDrawerViewController 左视图控制器
 *
 *  @return nstancetype 初始化生成的对象
 */
-(instancetype)initWithCenterViewController:(UIViewController *)centerViewController leftDrawerViewController:(UIViewController *)leftDrawerViewController;

/**
 *  关闭左视图
 */
- (void)closeLeftViewController;

/**
 *  打开左视图
 */
- (void)openLeftViewController;

@end
