//
//  HomeViewController.m
//  kugou
//
//  Created by MCL on 16/6/30.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "HomePageViewController.h"

@interface HomePageViewController ()

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Home";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupNavView];
    [self addGestureRecognizer];
    
}

- (void)setupNavView{
    
    UIButton *imageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    imageBtn.frame = CGRectMake(0, 0, 44, 44);
    imageBtn.layer.cornerRadius = 22;
    imageBtn.clipsToBounds = YES;
    [imageBtn addTarget:self action:@selector(openLeftViewController) forControlEvents:UIControlEventTouchUpInside];
    [imageBtn setImage:[UIImage imageNamed:@"tabbar_contactsHL"] forState:UIControlStateNormal];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:imageBtn];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
}

- (void)addGestureRecognizer{
    
    UISwipeGestureRecognizer *leftSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    [leftSwipeGesture setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:leftSwipeGesture];
    
    UISwipeGestureRecognizer *rightSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    [rightSwipeGesture setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:rightSwipeGesture];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapFrom:)];
    [self.view addGestureRecognizer:tapGesture];
}

- (void)openLeftViewController{
    LOG_METHOD;
    [[AppDelegate appDelegate].drawer openLeftViewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  左轻扫|右轻扫
 */
- (void)handleSwipeFrom:(UISwipeGestureRecognizer *)sender
{
    NSLog(@"Swipe received.");
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        
        NSLog(@"swipe left");
        
//        [[AppDelegate appDelegate].drawer closeLeftViewController];
        
    }else if (sender.direction == UISwipeGestureRecognizerDirectionRight){
        
        NSLog(@"swipe right");
        if ([AppDelegate appDelegate].drawer.isClose) {
            
            [[AppDelegate appDelegate].drawer openLeftViewController];
        }
    }
}

- (void)handleTapFrom:(UITapGestureRecognizer *)sender{
    NSLog(@"Tap received.");
    if (![AppDelegate appDelegate].drawer.isClose && sender.state == UIGestureRecognizerStateEnded) {
        [[AppDelegate appDelegate].drawer closeLeftViewController];
    }
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
