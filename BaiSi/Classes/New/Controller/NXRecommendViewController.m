//
//  NXRecommendViewController.m
//  BaiSi
//
//  Created by N-X on 2017/2/4.
//  Copyright © 2017年 Marauder. All rights reserved.
//

#import "NXRecommendViewController.h"
#import "NXRecommendCell.h"
#import <MJExtension/MJExtension.h>
#import "NXRecommendModel.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "NXRequest.h"
static  NSString * _Nullable cellId = @"recommendCell";
@interface NXRecommendViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)UITableView *tableView;
@property (nonatomic ,strong)NSMutableArray *dataArray;
@property (nonatomic ,strong)NXRequest *request;
@end

@implementation NXRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    _tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView registerNib:[UINib nibWithNibName:@"NXRecommendCell" bundle:nil] forCellReuseIdentifier:cellId];
//    self.tableView.separatorInset = UIEdgeInsetsZero; //分隔线顶头，这个只是设置tableView 顶头，还需要在cell里设置cell的顶头
    self.tableView.backgroundColor = NXColor(220, 220, 221);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)loadData{
    NSString * url = @"http://api.budejie.com/api/api_open.php";
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    [SVProgressHUD showWithStatus:@"正在加载中。。。"];
    NXRequest * request = [[NXRequest alloc]init];
    _request = request;
    
    [request requetsType:GET url:url params:params finish:^(id result, NSError *error) {
        if (!error) {
            [SVProgressHUD dismiss];
            [result writeToFile:@"/Users/nancy/work/Practise/BaiSi/submit.plist" atomically:YES];
            _dataArray = [NXRecommendModel mj_objectArrayWithKeyValuesArray:result];
            [self.tableView reloadData];
        }else
        {
            NXLog(@"error:%@",error);
            [SVProgressHUD dismiss];
        }

    }];
}
- (void)viewWillDisappear:(BOOL)animated
{
    // 停止下载
//    [_manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    [_request cancelTasks];
    [SVProgressHUD dismiss];
}
- (void)viewDidAppear:(BOOL)animated
{
    NXLog(@"margin:%@",NSStringFromUIEdgeInsets(self.tableView.separatorInset));
}
#pragma mark -- tableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NXRecommendCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    NXRecommendModel* model = _dataArray[indexPath.row];
    cell.model = model;
    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0;
}
@end
