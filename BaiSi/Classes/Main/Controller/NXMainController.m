//
//  NXMainController.m
//  BaiSi
//
//  Created by N-X on 2016/12/8.
//  Copyright © 2016年 Marauder. All rights reserved.
//

#import "NXMainController.h"
#import "Common.h"
#import "NXTabBar.h"
#import "NXNavigationController.h"
@interface NXMainController ()

@end

@implementation NXMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 解析plist获取各个控制器
    NSString * path = [[NSBundle mainBundle]pathForResource:@"Controllers" ofType:@"plist"];
    NSArray * array = [NSArray arrayWithContentsOfFile:path];
    NSLog(@"array:%@",array);
    __block NSString * classStr;
    __block Class class;
    __block NSString * title;
    __block NSString * imageName;
    __block NSString * imageClickName;
    weakify(self);
    [array enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
        classStr = dict[@"class"];
        class = NSClassFromString(classStr);
        title = dict[@"title"];
        imageName = dict[@"imageName"];
        imageClickName = dict[@"imageClickName"];
        [weakself createChildController:class title:title imageName:imageName imageClickName:imageClickName];
    }];
    NXTabBar * nTabBar = [[NXTabBar alloc]init];
//    self.tabBar = nTabBar;
    [self setValue:nTabBar forKey:@"tabBar"];
}

- (void)createChildController:(Class)class title:(NSString *)title imageName:(NSString *)imageName imageClickName:(NSString *)imageClickName
{
    UIViewController * vc;
    if ([title isEqualToString:@"我"]) {
        vc = [[UIStoryboard storyboardWithName:@"NXMeController" bundle:nil] instantiateInitialViewController];
    }else
    {
        vc = [[class alloc]init];
    }
    if ([title isEqualToString:@""]) {
//        vc.tabBarItem.image = [UIImage imageNamed:imageName];
//        vc.tabBarItem.selectedImage = [UIImage imageNamed:imageClickName];
//        vc.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
//        [self addChildViewController:vc];
    }else
    {
        vc.title = title;
        NXNavigationController * navc = [[NXNavigationController alloc]initWithRootViewController:vc];
        navc.tabBarItem.image = [UIImage imageNamed:imageName];
        navc.tabBarItem.selectedImage = [UIImage imageNamed:imageClickName];
        [self addChildViewController:navc];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
