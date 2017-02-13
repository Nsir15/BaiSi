//
//  NXAllViewController.m
//  BaiSi
//
//  Created by N-X on 2017/2/10.
//  Copyright © 2017年 Marauder. All rights reserved.
//

#import "NXAllViewController.h"
#import "NXRequest.h"
#import <MJExtension/MJExtension.h>
#import "NXTopicModel.h"
#import "NXTopicCell.h"
static NSString * const cellID = @"allViewCell";
static NSString * const topicCell = @"topcCell";
@interface NXAllViewController ()
@property (nonatomic ,strong)UIView *footer;
@property (nonatomic ,strong)UILabel *footerLabel;
@property (nonatomic ,strong)UIView *header;
@property (nonatomic ,strong)UILabel *headerLabel;
@property (nonatomic ,assign)NSInteger  dataCount;
@property (nonatomic ,assign , getter=isHeaderRefresh)BOOL  headerRefresh;
/*判断是否是正在加载更多*/
@property (nonatomic ,assign ,getter=isLoading)BOOL  Loading;

@property (nonatomic ,strong)NSMutableArray *dataArray;
@property(nonatomic,copy)NSString * maxtime;
@end

@implementation NXAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = NXColor(235, 235, 241);
    self.dataCount = 0;
    self.tableView.contentInset = UIEdgeInsetsMake(NXNavMaxY + NXTitlesViewH, 0, NXTabBarH, 0);
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(NXNavMaxY + NXTitlesViewH, 0, NXTabBarH, 0);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarButtonDidRepeatClick) name:UITabBarButtonDidRepeatClickNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(titleButtonRepeatClick) name:TitleButtonDidRepeatClickNotification object:nil];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    [self setUpFooter];
    [self setUpHeader];
    [self beginRefresh];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"NXTopicCell" bundle:nil] forCellReuseIdentifier:topicCell];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITabBarButtonDidRepeatClickNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:TitleButtonDidRepeatClickNotification object:nil];
}

#pragma mark -- 设置UI
- (void)setUpFooter{
    UIView * footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.nx_width, 35)];
    _footer = footer;
    footer.backgroundColor = [UIColor greenColor];
    UILabel * footerLabel = [[UILabel alloc]initWithFrame:footer.bounds];
    _footerLabel = footerLabel;
    footerLabel.textAlignment = NSTextAlignmentCenter;
    footerLabel.text = @"上拉加载更多";
    footerLabel.textColor = [UIColor whiteColor];
    [footer addSubview:footerLabel];
    self.tableView.tableFooterView = footer;
}
- (void)setUpHeader{
    UIView * header = [[UIView alloc]initWithFrame:CGRectMake(0, -45, self.tableView.nx_width, 45)];
    _header = header;
    header.backgroundColor = [UIColor redColor];
    UILabel * headerLabel = [[UILabel alloc]initWithFrame:header.bounds];
    _headerLabel = headerLabel;
//    NXLog(@"frame:%@,bounds:%@",NSStringFromCGRect(header.frame),NSStringFromCGRect(header.bounds));
    headerLabel.text = @"下拉刷新";
    headerLabel.textAlignment = NSTextAlignmentCenter;
    headerLabel.textColor = [UIColor whiteColor];
    [header addSubview:headerLabel];
    [self.tableView addSubview:header];
}
#pragma mark -- 点击事件处理
- (void)tabBarButtonDidRepeatClick{
    //当前的view 不在window 中，说明当前点击的不是精华tabBarButton
    if (!self.view.window) {
        return;
    }
    //说明当前显示的tableView  不是allView  页面
    if (self.tableView.scrollsToTop == NO) {
        return;
    }
    NXLog(@"重复点击,刷新数据");
    [self beginRefresh];
}
- (void)titleButtonRepeatClick{
    [self tabBarButtonDidRepeatClick];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.footer.hidden = (self.dataArray.count == 0);
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NXTopicCell * cell = [tableView dequeueReusableCellWithIdentifier:topicCell];
    NXTopicModel * model = self.dataArray[indexPath.row];
    cell.topicModel = model;
    return cell;
}

/**
 这个方法的特点：
 1.默认情况下
 1> 每次刷新表格时，有多少数据，这个方法就一次性调用多少次（比如有100条数据，每次reloadData时，这个方法就会一次性调用100次）
 2> 每当有cell进入屏幕范围内，就会调用一次这个方法
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NXTopicModel * model = self.dataArray[indexPath.row];
    return model.cellHeight;
}
#pragma mark -- scrollView  delegate  在这里处理上拉加载和下拉刷新

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
   
    [self dealHeaderRefresh];
    [self dealFooterLoading];
}

//停止拖拽
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    CGFloat headerOffSet = -(self.tableView.contentInset.top + self.header.nx_height);
    if (self.tableView.contentOffset.y  < headerOffSet) {
        [self beginRefresh];
    }
}

/*下拉刷新*/
- (void)dealHeaderRefresh{
    if (_headerRefresh) {
        return;
    }
    //header 完全出现的偏移量
    CGFloat headerOffSet = -(self.tableView.contentInset.top + self.header.nx_height);
    if (self.tableView.contentOffset.y < headerOffSet) {
        NXLog(@"header完全出现了，下拉加载");
        self.headerLabel.text = @"释放可以刷新";
    }else
    {
        self.headerLabel.text = @"下拉刷新";
    }
}
- (void)dealFooterLoading{
    //没有内容的时候直接返回(程序刚进来的时候会调用一次scroll 的这个方法，此时内容还为空)
    if (self.tableView.contentSize.height == 0) {
        return;
    }
    if (_Loading) {
        return;
    }
//    NXLog(@"contentSize.height:%f,bottom:%f,tableViewHeight:%f",self.tableView.contentSize.height,self.tableView.contentInset.bottom,self.tableView.nx_height);
    //footer 完全出现的时候的偏移量
    CGFloat footerOffSet = self.tableView.contentSize.height + self.tableView.contentInset.bottom - self.tableView.nx_height;
    if (self.tableView.contentOffset.y >= footerOffSet  && self.tableView.contentOffset.y > - self.tableView.contentInset.top) {//并且得是上拉状态
        NXLog(@"footer完全出现了");
        [self beginLoading];
    }

}

- (NSUInteger)type{
    return TopicType_all;
}

- (void)refreshData{
    //重新请求数据
    
    NXRequest * request = [[NXRequest alloc]init];
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @([self type]);
    [request requetsType:GET url:@"http://api.budejie.com/api/api_open.php" params:params finish:^(NSDictionary *result, NSError *error) {
        if (!error) {
           
            //结束刷新
            [self endReFresh];
            NXWriteToFile(homeData);
          _dataArray = [NXTopicModel mj_objectArrayWithKeyValuesArray:result[@"list"]];
            _maxtime = result[@"info"][@"maxtime"];
            [self.tableView reloadData];
            
        }else
        {
            //结束刷新
            [self endReFresh];
            NXLog(@"error:%@",error);
        }
    }];
}

- (void)loadingMoreData{
    
    NXRequest * request = [[NXRequest alloc]init];
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @"1";
    params[@"maxtime"] = _maxtime;
    [request requetsType:GET url:@"http://api.budejie.com/api/api_open.php" params:params finish:^(NSDictionary *result, NSError *error) {
        if (!error) {
            
            //结束刷新
            [self endLoading];
//                        NXWriteToFile(homeData);
            [_dataArray addObjectsFromArray:[NXTopicModel mj_objectArrayWithKeyValuesArray:result[@"list"]]];
            _maxtime = result[@"info"][@"maxtime"];
            [self.tableView reloadData];
            
        }else
        {
            //结束刷新
            [self endLoading];
            NXLog(@"error:%@",error);
        }
    }];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.dataCount +=5;
        [self.tableView reloadData];
        
        //结束加载
        [self endLoading];
    });

}

- (void)beginRefresh{
    if (_headerRefresh) {
        return;
    }
    self.headerLabel.text = @"正在刷新中";
    _headerRefresh = YES;
    [UIView animateWithDuration:0.25 animations:^{
        CGFloat contentInsetTop = self.tableView.contentInset.top;
        contentInsetTop += self.header.nx_height;
        self.tableView.contentInset = UIEdgeInsetsMake(contentInsetTop, 0, self.tableView.contentInset.bottom, 0);
        
        // 修改偏移量
        self.tableView.contentOffset = CGPointMake(self.tableView.contentOffset.x,  -contentInsetTop);
    }];
    //开始重新请求数据，刷新数据
    [self refreshData];
}
- (void)endReFresh{
    self.headerLabel.text = @"下拉刷新";
    [UIView animateWithDuration:0.25 animations:^{
        CGFloat contentInsetTop = self.tableView.contentInset.top;
        contentInsetTop -= self.header.nx_height;
        self.tableView.contentInset = UIEdgeInsetsMake(contentInsetTop, 0, self.tableView.contentInset.bottom, 0);
    }];
    
    _headerRefresh = NO;
}

- (void)beginLoading{
    if (_Loading) {
        return;
    }
    self.footerLabel.text = @"正在加载中.....";
    _Loading = YES;
    //加载更多数据
    [self loadingMoreData];
}
- (void)endLoading{
    self.footerLabel.text = @"上拉加载更多数据";
    _Loading = NO;
}
@end
