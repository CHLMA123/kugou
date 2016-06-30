//
//  AppFrameTabBarController.m
//  kugou
//
//  Created by MCL on 16/6/29.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "AppFrameTabBarController.h"
#import "BaseNavigationController.h"

#define ClassName   @"Class"
#define TitleName   @"Title"
#define NorImgName  @"NorImg"
#define SelImgName  @"SelImg"
#define Global_tintColor [UIColor colorWithRed:0 green:(190 / 255.0) blue:(12 / 255.0) alpha:1]

@interface AppFrameTabBarController ()

@end

@implementation AppFrameTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
//    // 20160630 test
//    NSArray *childItemsArray = @[@{ClassName:@"MainViewController",
//                                   TitleName:@"Main",
//                                   NorImgName:@"tabbar_mainframe",
//                                   SelImgName:@"tabbar_mainframeHL"},
//                                 
//                                 @{ClassName:@"ContactsViewController",
//                                   TitleName:@"Contacts",
//                                   NorImgName:@"tabbar_contacts",
//                                   SelImgName:@"tabbar_contactsHL"},
//                                 
//                                 @{ClassName:@"DiscoverViewController",
//                                   TitleName:@"Discover",
//                                   NorImgName:@"tabbar_discover",
//                                   SelImgName:@"tabbar_discoverHL"},
//                                 
//                                 @{ClassName:@"MeViewController",
//                                   TitleName:@"Me",
//                                   NorImgName:@"tabbar_me",
//                                   SelImgName:@"tabbar_meHL"}];
//    
//    [childItemsArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        UIViewController *vc = [[NSClassFromString(obj[ClassName]) alloc] init];
//        vc.title = obj[TitleName];
//        BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
//        UITabBarItem *item = nav.tabBarItem;
//        [item setImage:[UIImage imageNamed:obj[NorImgName]]];
//        item.selectedImage = [[UIImage imageNamed:obj[SelImgName]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        [item setTitleTextAttributes:@{NSForegroundColorAttributeName : Global_tintColor} forState:UIControlStateSelected];
//        item.title = obj[TitleName];
//        
//        [self addChildViewController:nav];
//    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
