//
//  LogInViewController.m
//  kugou
//
//  Created by MCL on 16/7/2.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "LogInViewController.h"
#import "LogInAndRegisterView.h"
#import "QQLogInHelper.h"

@interface LogInViewController ()

@end

@implementation LogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupLoginView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupLoginView{
    
    LogInAndRegisterView *loginView = [[LogInAndRegisterView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    loginView.closevcblcok = ^{
        [self.view removeFromSuperview];
        //[[AppDelegate appDelegate].drawer.view willRemoveSubview:self.view];//效果同上
        //[self dismissViewControllerAnimated:YES completion:nil];//效果同上
    };
    [self.view addSubview:loginView];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
