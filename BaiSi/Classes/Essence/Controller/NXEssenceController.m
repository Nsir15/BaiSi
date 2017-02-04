//
//  NXEssenceViewController.m
//  BaiSi
//
//  Created by N-X on 2016/12/8.
//  Copyright © 2016年 Marauder. All rights reserved.
// 精华

#import "NXEssenceController.h"
#import "UINavigationItem+item.h"

@interface NXEssenceController ()

@end

@implementation NXEssenceController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavagationBar];
    NSLog(@"screenH : %f", [UIScreen mainScreen].bounds.size.height);
}

- (void)setUpNavagationBar{
    self.navigationItem.leftBarButtonItem = [UINavigationItem customeButtonItemWithImage:@"nav_item_game_icon" highLightImage:@"nav_item_game_click_icon" target:self action:@selector(game)];
    self.navigationItem.rightBarButtonItem = [UINavigationItem customeButtonItemWithImage:@"navigationButtonRandom" highLightImage:@"navigationButtonRandomClick" target:self action:@selector(random)];
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
}

- (void)game{
    
}
- (void)random{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
