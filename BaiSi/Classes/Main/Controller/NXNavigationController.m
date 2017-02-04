//
//  NXNavigationController.m
//  BaiSi
//
//  Created by N-X on 2017/2/3.
//  Copyright © 2017年 Marauder. All rights reserved.
//

#import "NXNavigationController.h"
#import "UINavigationItem+item.h"
@interface NXNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation NXNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.interactivePopGestureRecognizer.delegate = self;//用于设置滑动返回(这个只是最左侧返回)
    
    //设置全屏返回
//    ((UIScreenEdgePanGestureRecognizer *)(self.interactivePopGestureRecognizer)).edges = UIRectEdgeNone;
    
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
    //用于判断是否触发手势，只在非根控制器的时候才触发，不然会造成假死，和代理方法配合使用
    pan.delegate = self;
    [self.view addGestureRecognizer:pan];
    
    //将之前的手势禁掉
    self.interactivePopGestureRecognizer.enabled = NO;
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
//    NSLog(@"childViewController:%@",self.childViewControllers);
    //自定义返回按钮会导致系统默认的滑动返回功能失效。
    if (self.childViewControllers.count >0) {
        viewController.navigationItem.leftBarButtonItem = [UINavigationItem backButtonItemWithImage:@"navigationButtonReturn" highLightImage:@"navigationButtonReturnClick" target:self action:@selector(backClick) title:@"返回"];
    }
// NSLog(@"self.interactivePopGestureRecognizer:%@",self.interactivePopGestureRecognizer);
    //真正去跳转
    [super pushViewController:viewController animated:animated];
//    NSLog(@"childViewController---after+++++++:%@",self.childViewControllers);

}
- (void)backClick{
    [self popViewControllerAnimated:YES];
}
#pragma mark-- gestureDelegate
//是否触发手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
//    NSLog(@"childViewController----------:%@",self.childViewControllers);

    return self.childViewControllers.count > 1;  //如果大于1 说明当前不是在根视图，可以触发手势
}

/*
 :<UIScreenEdgePanGestureRecognizer: 0x7fff30c151a0; state = Possible; delaysTouchesBegan = YES; view = <UILayoutContainerView 0x7fff30c2f040>; target= <(action=handleNavigationTransition:, target=<_UINavigationInteractiveTransition 0x7fff30c2f910>)>>

 */

@end
