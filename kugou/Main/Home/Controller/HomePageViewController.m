//
//  HomeViewController.m
//  kugou
//
//  Created by MCL on 16/6/30.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "HomePageViewController.h"

@interface HomePageViewController ()

@property (nonatomic, strong) UIButton *imageBtn;

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Home";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupNavView];
    [self addGestureRecognizer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshPersonImageBtn:) name:@"getPersonImgMsg" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushPersonnalInfoVC:) name:@"pushPersonnalInfoVCMsg" object:nil];
}

- (void)setupNavView{
    
    _imageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _imageBtn.frame = CGRectMake(0, 4, 36, 36);
    _imageBtn.layer.cornerRadius = 18;
    _imageBtn.clipsToBounds = YES;
    [_imageBtn addTarget:self action:@selector(didOpenLeftViewController) forControlEvents:UIControlEventTouchUpInside];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:@"personImg"];
    UIImage *image = [UIImage imageWithData:data];
    if (!image) {
        image = [UIImage imageNamed:@"kugou"];
    }
    [_imageBtn setImage:image forState:UIControlStateNormal];
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
    [_imageBtn setImage:[UIImage imageWithData:imageData] forState:UIControlStateNormal];
    
}

- (void)pushPersonnalInfoVC:(NSNotification *)notify{
    
    NSDictionary *dic = notify.userInfo;
    NSString *classname = dic[@"className"];
    Class class = NSClassFromString(classname);
    UIViewController *VC = [[class alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
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
