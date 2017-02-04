//
//  NXNewController.m
//  BaiSi
//
//  Created by N-X on 2016/12/8.
//  Copyright © 2016年 Marauder. All rights reserved.
//

#import "NXNewController.h"
#import "UINavigationItem+item.h"
@interface NXNewController ()

@end

@implementation NXNewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavagationBar];
}
- (void)setUpNavagationBar{
    self.navigationItem.leftBarButtonItem = [UINavigationItem customeButtonItemWithImage:@"MainTagSubIcon" highLightImage:@"MainTagSubIconClick" target:self action:@selector(subClick)];
}
- (void)subClick{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
