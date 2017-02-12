//
//  NXEssenceViewController.m
//  BaiSi
//
//  Created by N-X on 2016/12/8.
//  Copyright © 2016年 Marauder. All rights reserved.
// 精华

#import "NXEssenceController.h"
#import "UINavigationItem+item.h"
#import "NXStatuButton.h"
#import "NXAllViewController.h"
#import "NXVideoViewController.h"
#import "NXVoiceViewController.h"
#import "NXPictureViewController.h"
#import "NXJokeViewController.h"

@interface NXEssenceController ()<UIScrollViewDelegate>
@property (nonatomic ,strong)UIButton *beforeButton;
@property (nonatomic ,strong)UIView *titleUnderLine;
@property (nonatomic ,strong)UIView *statusView;
@property (nonatomic ,strong)UIScrollView *scrollView;
@end

@implementation NXEssenceController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavagationBar];
    [self setUpAllChildrenControllers];
    [self setUpContainerScroll];
    [self setUpStatusBar];
    [self setTitleUnderLine];
    [self addChildTableViewForIndex:0];
}

- (void)setUpContainerScroll{
    // 不允许自动修改UIScrollView的内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView * containerScroll = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    _scrollView = containerScroll;
    containerScroll.delegate = self;
    containerScroll.backgroundColor = [UIColor orangeColor];
    NSInteger count = self.childViewControllers.count;
    containerScroll.contentSize = CGSizeMake(self.view.nx_width * count , 0);
    containerScroll.showsHorizontalScrollIndicator = NO;
    containerScroll.pagingEnabled = YES;
    containerScroll.scrollsToTop = NO;
    [self.view addSubview:containerScroll];
}

- (void)setUpStatusBar{
    UIView * statusView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.nx_width, 45)];
    _statusView = statusView;
    statusView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.6];
    [self.view addSubview:statusView];
//    NSArray * titles = @[@"全部",@"美女",@"推荐",@"精彩",@"文字",@"语音",@"直播",@"更多"];
    NSArray *titles = @[@"全部", @"视频", @"声音", @"图片", @"段子"];

    CGFloat buttonW = self.view.nx_width / titles.count;
    [titles enumerateObjectsUsingBlock:^(NSString   * title, NSUInteger idx, BOOL * _Nonnull stop) {
        NXStatuButton * button = [NXStatuButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:title forState:UIControlStateNormal];
        button.tag = idx;
//        [button sizeToFit];
        button.nx_width = buttonW;
        button.nx_x = idx * button.nx_width;
        button.nx_height = statusView.nx_height;
//        button.backgroundColor = RANDOM_COLOR;
        [statusView addSubview:button];
    }];
}

//设置标题下划线
- (void)setTitleUnderLine{
    //
    NXStatuButton * titleButton = [[_statusView subviews] firstObject];
    _titleUnderLine = [[UIView alloc]init];
    _titleUnderLine.backgroundColor = [titleButton titleColorForState:UIControlStateSelected]; //根据按钮title 颜色设置下划线颜色
    _titleUnderLine.nx_height = 2;
    //根绝button 的大小计算下划线的宽度
    _titleUnderLine.nx_width = [[titleButton currentTitle] sizeWithAttributes:@{NSFontAttributeName:titleButton.titleLabel.font}].width;
    _titleUnderLine.nx_y = _statusView.nx_height - 2;
    titleButton.selected = YES;
    _beforeButton = titleButton;
    _titleUnderLine.nx_centerX = titleButton.center.x;
    [_statusView addSubview:_titleUnderLine];
}
- (void)setUpNavagationBar{
    self.navigationItem.leftBarButtonItem = [UINavigationItem customeButtonItemWithImage:@"nav_item_game_icon" highLightImage:@"nav_item_game_click_icon" target:self action:@selector(game)];
    self.navigationItem.rightBarButtonItem = [UINavigationItem customeButtonItemWithImage:@"navigationButtonRandom" highLightImage:@"navigationButtonRandomClick" target:self action:@selector(random)];
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
}

- (void)setUpAllChildrenControllers{
    [self addChildViewController:[[NXAllViewController alloc]init]];
    [self addChildViewController:[[NXVideoViewController alloc]init]];
    [self addChildViewController:[[NXVoiceViewController alloc]init]];
    [self addChildViewController:[[NXPictureViewController alloc]init]];
    [self addChildViewController:[[NXJokeViewController alloc]init]];
}

- (void)titleButtonClick:(UIButton *)button{
    if (button == _beforeButton) {
        //发送重复点击通知
        [[NSNotificationCenter defaultCenter] postNotificationName:TitleButtonDidRepeatClickNotification object:nil];
    }
    [self dealTitleButtonClick:button];
}

- (void)dealTitleButtonClick:(UIButton *)button{
    _beforeButton.selected = NO;
    [UIView animateWithDuration:0.3 animations:^{
        _beforeButton.titleLabel.font = [UIFont systemFontOfSize:16];
    }];
    button.selected = YES;
    _beforeButton = button;
    NSUInteger index = button.tag;
    [UIView animateWithDuration:0.3 animations:^{
        _titleUnderLine.nx_centerX = button.nx_centerX;
        button.titleLabel.font = [UIFont systemFontOfSize:18];
        CGFloat contentOffSetX = _scrollView.nx_width * index;
        _scrollView.contentOffset = CGPointMake(contentOffSetX, _scrollView.contentOffset.y);
    } completion:^(BOOL finished) {
        [self addChildTableViewForIndex:button.tag];
    }];
    
    for (NSUInteger i=0; i<self.childViewControllers.count; i++) {
        UIViewController * childVC = self.childViewControllers[i];
        //如果还没有被加载，就不做操作
        if (!childVC.isViewLoaded) {
            continue;
        }
        UIScrollView * scroll = (UIScrollView *)childVC.view;
        if (![scroll isKindOfClass:[UIScrollView class]]) {
            continue;
        }
        scroll.scrollsToTop = (i == button.tag);
    }

}
- (void)addChildTableViewForIndex:(NSUInteger)index{
    UIViewController * vc = self.childViewControllers[index];
    if (vc.isViewLoaded) {//如果已经被加载过就不重复加载(加载view  的时候会调用 viewDidLoad)
        return ;
    }
    UIView * view = vc.view;
    view.frame = _scrollView.bounds;
    //        view.frame = CGRectMake(_scrollView.nx_width * index, 0, _scrollView.nx_width, _scrollView.nx_height);
//    view.backgroundColor = RANDOM_COLOR;
    [_scrollView addSubview:view];

}
#pragma mark --scrollViewDelegate

//开始减速的时候调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSUInteger index = scrollView.contentOffset.x / scrollView.nx_width;
    NXStatuButton * titleButton = self.statusView.subviews[index];
//    [self titleButtonClick:titleButton];
    [self dealTitleButtonClick:titleButton];
}
- (void)game{
    
}
- (void)random{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
