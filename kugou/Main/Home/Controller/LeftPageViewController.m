//
//  LeftPageViewController.m
//  kugou
//
//  Created by MCL on 16/6/30.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "LeftPageViewController.h"
#import "ListTableViewCell.h"

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
    
    UITableView *tableview = [[UITableView alloc] init];
    tableview.backgroundColor = [UIColor clearColor];
    tableview.frame = self.view.bounds;
    tableview.dataSource = self;
    tableview.delegate  = self;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView = tableview;
    [self.view addSubview:tableview];
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
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 5;
    }
    return SCREEN_HEIGHT * 0.2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return SCREEN_HEIGHT * 0.2;
    }else{
        return 5;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSInteger k = section;
    NSArray *arr = _dataArr[k];
    return arr.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"点击了 %ld", indexPath.row);
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 180)];
        view.backgroundColor = [UIColor clearColor];
        return view;
    }else{
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 5)];
        view.backgroundColor = [UIColor clearColor];
        return view;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 5)];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 4, self.tableView.bounds.size.width, 1)];
    line.backgroundColor = [UIColor greenColor];
    [view addSubview:line];
    return view;
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    ListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[ListTableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:identifier];
    }
    cell.backgroundColor = CLEARCOLOR;
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font  = [UIFont systemFontOfSize:15];
    NSInteger k = 0;
    if (indexPath.section == 1) {
        k = 1;
    }
    cell.textLabel.text  = _dataArr[k][indexPath.row][TitleName];
    cell.imageView.image =[UIImage imageNamed:_dataArr[k][indexPath.row][ImageName]];
    
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
