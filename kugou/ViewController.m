//
//  ViewController.m
//  kugou
//
//  Created by MCL on 16/6/25.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "ViewController.h"
#import "MNetworkHelper.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    MNetworkHelper *helper = [[MNetworkHelper shareInstance] init];
    [helper GET:@"https://www.baidu.com" Parameters:nil Success:^(id responseObject) {
        
        NSLog(@"Success");
    } Failure:^(NSError *error) {
        
        NSLog(@"Failure");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
