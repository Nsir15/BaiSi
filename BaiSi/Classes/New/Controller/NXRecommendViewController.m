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
static  NSString * _Nullable cellId = @"recommendCell";
@interface NXRecommendViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)UITableView *tableView;
@property (nonatomic ,strong)NSMutableArray *dataArray;
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
}

- (void)loadData{
    NSString * url = @"http://api.budejie.com/api/api_open.php";
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    [NXRequest requetsType:GET url:url params:params finish:^(id result, NSError *error) {
        if (!error) {
            NXLog(@"result:%@",result);
            [result writeToFile:@"/Users/nancy/work/Practise/BaiSi/submit.plist" atomically:YES];
          _dataArray = [NXRecommendModel mj_objectArrayWithKeyValuesArray:result];
            [self.tableView reloadData];
        }else
        {
            NXLog(@"error:%@",error);
        }
    }];
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
