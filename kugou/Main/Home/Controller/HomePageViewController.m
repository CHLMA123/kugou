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
    
    _imageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _imageBtn.frame = CGRectMake(0, 0, 44, 44);
    _imageBtn.layer.cornerRadius = 22;
    _imageBtn.clipsToBounds = YES;
    [_imageBtn addTarget:self action:@selector(didOpenLeftViewController) forControlEvents:UIControlEventTouchUpInside];
    [_imageBtn setImage:[UIImage imageNamed:@"kugou"] forState:UIControlStateNormal];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_imageBtn];
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

- (void)didOpenLeftViewController{
    LOG_METHOD;
    if ([AppDelegate appDelegate].drawer.isClose) {
        
        [[AppDelegate appDelegate].drawer openLeftViewController];
    }else{
    
        [[AppDelegate appDelegate].drawer closeLeftViewController];
    }
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
