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
@interface NXEssenceController ()
@property (nonatomic ,strong)UIButton *beforeButton;
@property (nonatomic ,strong)UIView *titleUnderLine;
@property (nonatomic ,strong)UIView *statusView;
@end

@implementation NXEssenceController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavagationBar];
    [self setUpContainerScroll];
    [self setUpStatusBar];
    [self setTitleUnderLine];
}

- (void)setUpContainerScroll{
    UIScrollView * containerScroll = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    containerScroll.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:containerScroll];
}

- (void)setUpStatusBar{
    UIView * statusView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.nx_width, 45)];
    _statusView = statusView;
    statusView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.6];
    [self.view addSubview:statusView];
    NSArray * titles = @[@"全部",@"美女",@"推荐",@"精彩",@"文字",@"语音",@"直播",@"更多"];
    CGFloat buttonW = self.view.nx_width / titles.count;
    [titles enumerateObjectsUsingBlock:^(NSString   * title, NSUInteger idx, BOOL * _Nonnull stop) {
        NXStatuButton * button = [NXStatuButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:title forState:UIControlStateNormal];
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
    [_statusView addSubview:_titleUnderLine];
}
- (void)setUpNavagationBar{
    self.navigationItem.leftBarButtonItem = [UINavigationItem customeButtonItemWithImage:@"nav_item_game_icon" highLightImage:@"nav_item_game_click_icon" target:self action:@selector(game)];
    self.navigationItem.rightBarButtonItem = [UINavigationItem customeButtonItemWithImage:@"navigationButtonRandom" highLightImage:@"navigationButtonRandomClick" target:self action:@selector(random)];
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
}

#pragma mark -- 点击事件处理
- (void)titleButtonClick:(UIButton *)button{
    _beforeButton.selected = NO;
    [UIView animateWithDuration:0.3 animations:^{
        _beforeButton.titleLabel.font = [UIFont systemFontOfSize:16];
    }];
    button.selected = YES;
    _beforeButton = button;
    [UIView animateWithDuration:0.3 animations:^{
        _titleUnderLine.nx_centerX = button.nx_centerX;
        button.titleLabel.font = [UIFont systemFontOfSize:17];
    }];
}

- (void)game{
    
}
- (void)random{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
