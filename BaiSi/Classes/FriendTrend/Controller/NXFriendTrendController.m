//
//  NXFriendTrendController.m
//  BaiSi
//
//  Created by N-X on 2016/12/8.
//  Copyright © 2016年 Marauder. All rights reserved.
// 关注

#import "NXFriendTrendController.h"
#import "UINavigationItem+item.h"
#import "NXLoginViewController.h"
@interface NXFriendTrendController ()

@end

@implementation NXFriendTrendController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavagationBar];
}
- (void)setUpNavagationBar{
    self.navigationItem.leftBarButtonItem = [UINavigationItem customeButtonItemWithImage:@"friendsRecommentIcon" highLightImage:@"friendsRecommentIcon-click" target:self action:@selector(attentionClick)];
}
- (IBAction)loginClick:(id)sender {
    NXLoginViewController * loginVc = [[NXLoginViewController alloc]init];
    [self presentViewController:loginVc animated:YES completion:nil];
}
- (void)attentionClick{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
