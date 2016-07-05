//
//  HomeViewController.m
//  kugou
//
//  Created by MCL on 16/6/30.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "HomePageViewController.h"
#import "listenViewController.h"
#import "lookViewController.h"
#import "singViewController.h"

typedef NS_ENUM(NSInteger, MNavBtnIndex) {
    
    MListenNavBtnIndex,
    MLookNavBtnIndex,
    MSingNavBtnIndex
};

@interface HomePageViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIButton *leftImageBtn;
@property (nonatomic, strong) UIButton *rightImageBtn;
@property (nonatomic, strong) UIButton *listenBtn;
@property (nonatomic, strong) UIButton *lookBtn;
@property (nonatomic, strong) UIButton *singBtn;
@property (nonatomic, strong) UIView *lineV;
@property (nonatomic, strong) UIScrollView *scrollV;
@property (nonatomic, strong) UIView *listenContentV;
@property (nonatomic, strong) UIView *lookContentV;
@property (nonatomic, strong) UIView *singContentV;

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Home";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupNavView];
    [self addGestureRecognizer];
    [self setupView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshPersonImageBtn:) name:@"getPersonImgMsg" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushPersonnalInfoVC:) name:@"pushPersonnalInfoVCMsg" object:nil];
}

- (void)setupView{
    
    _scrollV = [[UIScrollView alloc] init];
    _scrollV.frame = CGRectMake(0, 0, self.view.width, self.view.height);
    _scrollV.contentSize = CGSizeMake(self.view.width * 3, self.view.height);
    _scrollV.scrollEnabled = NO;// 以后处理 改变红色LINEvIEW
    _scrollV.delegate = self;
    
    listenViewController *listenVC = [[listenViewController alloc] init];
    _listenContentV = listenVC.view;
    _listenContentV.frame = CGRectMake(0, 0, self.view.width, self.view.height);
    
    lookViewController *lookVC = [[lookViewController alloc] init];
    _lookContentV = lookVC.view;
    _lookContentV.frame = CGRectMake(self.view.width * 1, 0, self.view.width, self.view.height);
    
    singViewController *singVC = [[singViewController alloc] init];
    _singContentV = singVC.view;
    _singContentV.frame = CGRectMake(self.view.width * 2, 0, self.view.width, self.view.height);

    [_scrollV addSubview:_listenContentV];
    [_scrollV addSubview:_lookContentV];
    [_scrollV addSubview:_singContentV];
    [self.view addSubview:_scrollV];
}

- (void)setupNavView{
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"box_special_user_bg"] forBarMetrics:UIBarMetricsDefault];
    
    CGFloat BtnWidth = 50;
    CGFloat BtnHight = 36;
    CGFloat MarginX = 15;
    
    //1 leftBarButtonItem
    _leftImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _leftImageBtn.layer.cornerRadius = 18;
    _leftImageBtn.clipsToBounds = YES;
    [_leftImageBtn addTarget:self action:@selector(didOpenLeftViewController) forControlEvents:UIControlEventTouchUpInside];
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSData *data = [defaults objectForKey:@"personImg"];
//    UIImage *image = [UIImage imageWithData:data];
//    if (!image) {
//        image = [UIImage imageNamed:@"kugou"];
//    }
    [_leftImageBtn setImage:[UIImage imageNamed:@"kugou"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_leftImageBtn];
    
    //2 rightBarButtonItem
    _rightImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightImageBtn.layer.cornerRadius = 18;
    _rightImageBtn.clipsToBounds = YES;
    [_rightImageBtn addTarget:self action:@selector(didOpenLeftViewController) forControlEvents:UIControlEventTouchUpInside];
    [_rightImageBtn setImage:[UIImage imageNamed:@"colorring_search@2x"] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_rightImageBtn];
    
    _rightImageBtn.frame = CGRectMake(0, 4, BtnHight, BtnHight);
    _leftImageBtn.frame  = CGRectMake(0, 4, BtnHight, BtnHight);
    
    //3 titleView
    UIView *titleV = [[UIView alloc] init];
    titleV.frame = CGRectMake(0, 0, 210, 44);
    
    _lookBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _lookBtn.tag = MLookNavBtnIndex;
    [_lookBtn setTitle:@"look" forState:UIControlStateNormal];
    [_lookBtn addTarget:self action:@selector(pageChangedAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _listenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _listenBtn.tag = MListenNavBtnIndex;
    [_listenBtn setTitle:@"listen" forState:UIControlStateNormal];
    [_listenBtn addTarget:self action:@selector(pageChangedAction:) forControlEvents:UIControlEventTouchUpInside];
    _singBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _singBtn.tag = MSingNavBtnIndex;
    [_singBtn setTitle:@"sing" forState:UIControlStateNormal];
    [_singBtn addTarget:self action:@selector(pageChangedAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _lookBtn.frame = CGRectMake(0, 4, BtnWidth, BtnHight);
    _lookBtn.center = titleV.center;
    _listenBtn.frame = CGRectMake(CGRectGetMinX(_lookBtn.frame) - MarginX - BtnWidth, 4, BtnWidth, BtnHight);
    _singBtn.frame = CGRectMake(CGRectGetMaxX(_lookBtn.frame) + MarginX, 4, BtnWidth, BtnHight);
    
    _lineV = [[UIView alloc] init];
    _lineV.backgroundColor = [UIColor redColor];
    _lineV.frame = CGRectMake(CGRectGetMinX(_listenBtn.frame), 44, BtnWidth, 2);
    [titleV addSubview:_lineV];

    [titleV addSubview:_lookBtn];
    [titleV addSubview:_listenBtn];
    [titleV addSubview:_singBtn];
    self.navigationItem.titleView = titleV;
    
}

- (void)pageChangedAction:(UIButton *)sender{
    
    self.listenBtn.enabled = YES;
    self.lookBtn.enabled = YES;
    self.singBtn.enabled = YES;
    sender.enabled = NO;
    
    CGFloat orignalX = CGRectGetMinX(sender.frame);
    CGRect oldRect = self.lineV.frame;
    oldRect.origin.x = orignalX;
    [UIView animateWithDuration:0.25 animations:^{
        self.lineV.frame = oldRect;
    }];
    
    if (sender.tag == MListenNavBtnIndex ) {
        self.view.transform = CGAffineTransformIdentity;
        self.scrollV.contentOffset = CGPointZero;
    }else if (sender.tag == MLookNavBtnIndex ) {
        self.view.transform = CGAffineTransformIdentity;
        self.scrollV.contentOffset = CGPointMake(self.view.width, 0);
    }else{
        self.view.transform = CGAffineTransformIdentity;
        self.scrollV.contentOffset = CGPointMake(self.view.width * 2, 0);
    }

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
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(taotwo)];
    tap.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:tap];
}


- (void)taotwo
{
    
    Class class = NSClassFromString(@"PersonalInfoViewController");
    UIViewController *VC = [[class alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Private

- (void)didOpenLeftViewController{

    if ([AppDelegate appDelegate].drawer.isClose) {
        
        [[AppDelegate appDelegate].drawer openLeftViewController];
    }else{
    
        [[AppDelegate appDelegate].drawer closeLeftViewController];
    }
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

- (void)refreshPersonImageBtn:(NSNotification *)notify{
    
    NSDictionary *dic = notify.userInfo;
    NSData *imageData = dic[@"personImg"];
    [_leftImageBtn setImage:[UIImage imageWithData:imageData] forState:UIControlStateNormal];
    
}

- (void)pushPersonnalInfoVC:(NSNotification *)notify{
    
    NSDictionary *dic = notify.userInfo;
    NSString *classname = dic[@"className"];
    Class class = NSClassFromString(classname);
    UIViewController *VC = [[class alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

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
