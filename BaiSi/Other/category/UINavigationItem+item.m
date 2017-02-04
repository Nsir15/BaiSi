//
//  UINavigationItem+item.m
//  BaiSi
//
//  Created by N-X on 2017/2/3.
//  Copyright © 2017年 Marauder. All rights reserved.
//

#import "UINavigationItem+item.h"

@implementation UINavigationItem (item)
+ (UIBarButtonItem *)customeButtonItemWithImage:(NSString *)image highLightImage:(NSString *)highLightImage target:(id)target action:(SEL)action{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highLightImage] forState:UIControlStateHighlighted];
    [button sizeToFit];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIView * containerView = [[UIView alloc]initWithFrame:button.bounds];
    [containerView addSubview:button];
    return [[UIBarButtonItem alloc]initWithCustomView:containerView];
}
+ (UIBarButtonItem *)customeButtonItemWithImage:(NSString *)image selectedImage:(NSString *)highLightImage target:(id)target action:(SEL)action{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highLightImage] forState:UIControlStateSelected];
    [button sizeToFit];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIView * containerView = [[UIView alloc]initWithFrame:button.bounds];
    [containerView addSubview:button];
    return [[UIBarButtonItem alloc]initWithCustomView:containerView];
}
+(UIBarButtonItem *)backButtonItemWithImage:(NSString *)image highLightImage:(NSString *)highLightImage target:(id)target action:(SEL)action title:(NSString *)title{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highLightImage] forState:UIControlStateHighlighted];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button sizeToFit];
    button.contentEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIView * containerView = [[UIView alloc]initWithFrame:button.bounds];
    [containerView addSubview:button];
    return [[UIBarButtonItem alloc]initWithCustomView:containerView];
}
@end
