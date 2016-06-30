//
//  LeftSlideViewController.m
//  kugou
//
//  Created by MCL on 16/6/30.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "LeftSlideViewController.h"
#import "BaseNavigationController.h"

#define CenterPageDistance   60            //打开左侧窗时，中视图(右视图)露出的宽度
#define CenterPageScale   0.65               //打开左侧窗时，中视图(右视图）缩放比例
#define CenterPageCenter  CGPointMake(SCREEN_WIDTH + SCREEN_WIDTH * CenterPageScale / 2.0 - CenterPageDistance, SCREEN_HEIGHT / 2)  //打开左侧窗时，中视图中心点
#define LeftScale 0.7
#define LeftCenterX 30

@interface LeftSlideViewController ()

@property (nonatomic, strong) UIViewController *leftViewController;   //左侧窗控制器
@property (nonatomic, strong) UIViewController *centerViewController; //中间窗控制器
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIView *contentView;  //蒙版

@end

@implementation LeftSlideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addGestureRecognizer];
}

- (void)addGestureRecognizer{
    
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    [self.view addGestureRecognizer:swipeGesture];
    
    
}

-(instancetype)initWithCenterViewController:(UIViewController *)centerViewController leftDrawerViewController:(UIViewController *)leftDrawerViewController
{
    if (self = [super init]) {
        
        self.leftViewController = leftDrawerViewController;
        self.centerViewController = centerViewController;
        self.leftViewController.view.hidden = YES;
        [self.view addSubview:self.leftViewController.view];
        
        for (UIView *obj in self.leftViewController.view.subviews) {
            if ([obj isKindOfClass:[UITableView class]]) {
                self.tableView = (UITableView *)obj;
            }
            _tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH - CenterPageDistance, SCREEN_HEIGHT);
            _tableView.backgroundColor = CLEARCOLOR;
            _tableView.transform = CGAffineTransformMakeScale(LeftScale, LeftScale);
            _tableView.center = CGPointMake(LeftCenterX, SCREEN_HEIGHT * 0.5);
        }
        self.isClose = YES;
        [self.view addSubview:self.centerViewController.view];
    }
    
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.leftViewController.view.hidden = NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)openLeftViewController{
    
    [UIView beginAnimations:nil context:nil];
    self.centerViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, CenterPageScale, CenterPageScale);
    self.centerViewController.view.center = CenterPageCenter;

    self.tableView.center = CGPointMake((SCREEN_WIDTH - CenterPageDistance)/2, SCREEN_HEIGHT * 0.5);
    self.tableView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
    [UIView commitAnimations];
    self.isClose = NO;
}

- (void)closeLeftViewController{
    
    [UIView beginAnimations:nil context:nil];
    self.centerViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
    self.centerViewController.view.center = self.view.center;
    self.tableView.center = CGPointMake(LeftCenterX, SCREEN_HEIGHT * 0.5);
    self.tableView.transform = CGAffineTransformScale(CGAffineTransformIdentity, LeftScale, LeftScale);
    [UIView commitAnimations];
    self.isClose = YES;
}

/**
 *  左轻扫|右轻扫
 */
- (void)handleSwipeFrom:(UISwipeGestureRecognizer *)sender
{
    NSLog(@"Swipe received.");
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        
        NSLog(@"swipe left");
        
    }else if (sender.direction == UISwipeGestureRecognizerDirectionRight){
        
        NSLog(@"swipe right");
        [self closeLeftViewController];
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
