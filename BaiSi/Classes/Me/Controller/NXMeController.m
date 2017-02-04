//
//  NXMeController.m
//  BaiSi
//
//  Created by N-X on 2016/12/8.
//  Copyright © 2016年 Marauder. All rights reserved.
//

#import "NXMeController.h"
#import "UINavigationItem+item.h"
#import "NXSettingViewController.h"
@interface NXMeController ()

@end

@implementation NXMeController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavagationBar];
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void)setUpNavagationBar{
    UIBarButtonItem * settingItem = [UINavigationItem customeButtonItemWithImage:@"mine-setting-icon" highLightImage:@"mine-setting-icon-click" target:self action:@selector(setting)];
    UIBarButtonItem * moonItem = [UINavigationItem customeButtonItemWithImage:@"mine-moon-icon" selectedImage:@"mine-moon-icon-click" target:self action:@selector(moon:)];
    self.navigationItem.rightBarButtonItems = @[settingItem,moonItem];
}
- (void)moon:(UIButton *)button{
    button.selected = !button.selected;
}
- (void)setting{
    NXSettingViewController * vc = [[NXSettingViewController alloc]init];
    //这个需要在push 之前设置才生效
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
