//
//  LeftPageViewController.m
//  kugou
//
//  Created by MCL on 16/6/30.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "LeftPageViewController.h"
#import "ListTableViewCell.h"
#import "LogInAndRegisterView.h"

#define TitleName   @"title"
#define ImageName   @"image"

@interface LeftPageViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *dataArr;

@end

@implementation LeftPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Left";
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageview.image = [UIImage imageNamed:@"newUserLoginBg.jpg"];
    [self.view addSubview:imageview];
    [self setupData];
    [self setupView];
    
}

- (void)setupView{
    
    CGFloat H = SCREEN_HEIGHT-396-10;
    CGFloat headerViewH = H * 0.6;
    CGFloat footerViewH = H * 0.4;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, headerViewH)];
    headerView.backgroundColor = [UIColor redColor];
    
    UIButton *personBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    personBtn.frame = CGRectMake(15, (headerViewH - 64)/2, 70, 70);
    personBtn.layer.cornerRadius = 35;
    [personBtn setImage:[UIImage imageNamed:@"detachbar_singerlogo"] forState:UIControlStateNormal];
    [personBtn addTarget:self action:@selector(setupLogInAndRegisterView) forControlEvents:UIControlEventTouchUpInside];
    
    [headerView addSubview:personBtn];
    [self.view addSubview:headerView];
    
    UITableView *tableView = [[UITableView alloc] init];
    tableView.frame = CGRectMake(0, headerViewH, SCREEN_WIDTH, 406);
    tableView.backgroundColor = [UIColor clearColor];
    tableView.dataSource = self;
    tableView.delegate  = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - footerViewH, SCREEN_WIDTH, footerViewH)];
    footerView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:footerView];
    
    UIView *headerLine = [[UIView alloc] initWithFrame:CGRectMake(10, headerViewH - 1, SCREEN_WIDTH - 80, 1)];
    headerLine.backgroundColor = [UIColor greenColor];
    [headerView addSubview:headerLine];
    UIView *footerLine = [[UIView alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH - 80, 1)];
    footerLine.backgroundColor = [UIColor greenColor];
    [footerView addSubview:footerLine];
    
}

- (void)setupLogInAndRegisterView{
    
    [[AppDelegate appDelegate].drawer closeLeftViewController];
    [AppDelegate appDelegate].drawer.isClose = YES;
    LogInAndRegisterView *loginView = [[LogInAndRegisterView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [[AppDelegate appDelegate].drawer.view addSubview:loginView];
}

- (void)setupData{

    NSArray *dataArr = @[@[@{TitleName :@"消息中心",ImageName:@"01dog"},
                         @{TitleName :@"我的好友",ImageName:@"02dog"},
                         @{TitleName :@"会员中心",ImageName:@"03dog"},
                         @{TitleName :@"定时关闭",ImageName:@"04dog"},
                         @{TitleName :@"蟒蛇音效",ImageName:@"05dog"},
                         @{TitleName :@"听歌识曲",ImageName:@"06dog"},
                         @{TitleName :@"启动问候音",ImageName:@"07dog"}],
                         @[@{TitleName :@"仅WiFi联网",ImageName:@"08dog"},
                         @{TitleName :@"通知栏歌词",ImageName:@"09dog"}]];
    self.dataArr = dataArr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSInteger k = section;
    NSArray *arr = _dataArr[k];
    return arr.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"点击了 %ld", (long)indexPath.row);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 5;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, 5)];
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(20, 2, SCREEN_WIDTH - 90, 1)];
        line.backgroundColor = [UIColor redColor];
        [view addSubview:line];
        return view;
    }
    return nil;
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    ListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[ListTableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:identifier];
    }
    if (indexPath.section == 0) {
        cell.textLabel.text  = _dataArr[0][indexPath.row][TitleName];
        cell.imageView.image =[UIImage imageNamed:_dataArr[0][indexPath.row][ImageName]];
    }else{
        cell.textLabel.text  = _dataArr[1][indexPath.row][TitleName];
        cell.imageView.image =[UIImage imageNamed:_dataArr[1][indexPath.row][ImageName]];
    }
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArr.count;
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
