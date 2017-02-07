//
//  NXMeController.m
//  BaiSi
//
//  Created by N-X on 2016/12/8.
//  Copyright © 2016年 Marauder. All rights reserved.
//  这里要用到静态单元格，所以用storyBoard

#import "NXMeController.h"
#import "UINavigationItem+item.h"
#import "NXSettingViewController.h"
#import "NXRequest.h"
#import "NXMeSquareModel.h"
#import <MJExtension/MJExtension.h>
#import "NXSquareCell.h"
#import "NXWebViewController.h"
static NSInteger  const column = 4;
static CGFloat  const margin = 1;
static NSString * const collectionCell = @"squareCell";
#define itemW   (self.view.nx_width- margin * (column -1)) / column

@interface NXMeController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic ,strong)NSArray *dataArray;
@property (nonatomic ,strong)UICollectionView * collectionView;

@end

@implementation NXMeController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavagationBar];
    [self loadData];
    [self setUpFooter];
    self.tableView.sectionFooterHeight = 10;
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
}
- (void)loadData{
    NXRequest * request = [[NXRequest alloc]init];
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"a"] = @"square";
    params[@"c"] = @"topic";
    [request requetsType:GET url:@"http://api.budejie.com/api/api_open.php" params:params finish:^(NSDictionary * result, NSError *error) {
        if (!error) {
            [result writeToFile:@"/Users/nancy/work/Practise/BaiSi/Me.plist" atomically:YES];
            NSArray * dictArray = result[@"square_list"];
          _dataArray = [NXMeSquareModel mj_objectArrayWithKeyValuesArray:dictArray];
            [self.collectionView reloadData];
            
            //重新计算collection 的高度
            NSInteger row = (_dataArray.count -1) / column +1;
            CGFloat h = itemW * row;
            self.collectionView.nx_height = h;
            
            // 设置tableView滚动范围:自己计算
            self.tableView.tableFooterView = self.collectionView;

        }else
        {
            NXLog(@"error:%@",error);
        }
    }];
}
- (void)setUpFooter{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(itemW,itemW);
    layout.minimumInteritemSpacing = margin;
    layout.minimumLineSpacing = margin;
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 0, 300) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = NXColor(235, 235, 241);
    //禁止collectionView 滚动
    _collectionView.scrollEnabled = NO;
    self.tableView.tableFooterView = _collectionView;
    
    [_collectionView registerNib:[UINib nibWithNibName:@"NXSquareCell" bundle:nil] forCellWithReuseIdentifier:collectionCell];
}
- (void)setUpNavagationBar{
    UIBarButtonItem * settingItem = [UINavigationItem customeButtonItemWithImage:@"mine-setting-icon" highLightImage:@"mine-setting-icon-click" target:self action:@selector(setting)];
    UIBarButtonItem * moonItem = [UINavigationItem customeButtonItemWithImage:@"mine-moon-icon" selectedImage:@"mine-moon-icon-click" target:self action:@selector(moon:)];
    self.navigationItem.rightBarButtonItems = @[settingItem,moonItem];
}

#pragma mark -- 点击事件处理
- (void)moon:(UIButton *)button{
    button.selected = !button.selected;
}
- (void)setting{
    NXSettingViewController * vc = [[NXSettingViewController alloc]init];
    //这个需要在push 之前设置才生效
//    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -- tableView  delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark-- collectionView delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NXSquareCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCell forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NXMeSquareModel * model = self.dataArray[indexPath.item];
    if(![model.url containsString:@"http"]) return;
    
    NXWebViewController * webVc = [[NXWebViewController alloc]init];
    webVc.url = model.url;
    [self.navigationController pushViewController:webVc animated:YES];
}
@end
