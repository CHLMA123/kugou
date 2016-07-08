//
//  ViewController.m
//  kugou
//
//  Created by MCL on 16/6/25.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "ViewController.h"
#import "NetworkManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NetworkManager *helper = [[NetworkManager shareInstance] init];
    [helper GET:@"https://www.baidu.com" Parameters:nil Success:^(id responseObject) {
        
        NSLog(@" 网络请求成功");
        {
            //在这里做判断
            if (1) {
                //1 业务请求成功
            } else {
                //0 业务请求失败
            }
            
        }
        
    } Failure:^(NSError *error) {
        
        NSDictionary *dic = (NSDictionary *)error.userInfo;
        NSLog(@"%@", dic[@"NSLocalizedDescription"]);
        [MBProgressHUD showError:[NSString stringWithFormat:@"%@", dic[@"NSLocalizedDescription"]] ToView:self.view];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
