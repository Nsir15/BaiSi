//
//  NXTabBar.m
//  BaiSi
//
//  Created by N-X on 2016/12/11.
//  Copyright © 2016年 Marauder. All rights reserved.
//

#import "NXTabBar.h"
@interface NXTabBar ()
@property(nonatomic,strong)UIButton * publishBtn;
@property (nonatomic ,strong)UIButton *previousButton;
@end
@implementation NXTabBar

- (UIButton *)publishBtn
{
    if (!_publishBtn) {
        _publishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_publishBtn setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [_publishBtn setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateSelected];
        [_publishBtn sizeToFit]; // 不写这个按钮不出来
        [self addSubview:_publishBtn];
    }
    return _publishBtn;
}
- (void)layoutSubviews
{
    [super layoutSubviews]; // 这个别忘了
//    NSLog(@"self.subViews:%@",self.subviews);
    CGFloat width = self.frame.size.width / (self.items.count + 1);
    CGFloat height = self.bounds.size.height;
    int i=0;
    for (UIControl * subView in self.subviews) {
        if ([subView isKindOfClass:NSClassFromString(@"UITabBarButton")]) {// 如果有些类可以打印出来但是敲不出来不能用，那就是苹果的私有类
            if (i==0) {
                _previousButton = (UIButton *)subView;
            }
            if (i==2) {
                i += 1;
            }
            subView.frame = CGRectMake(i * width, 0 , width,height);
            i++;
           
            [subView addTarget:self action:@selector(tabBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    self.publishBtn.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
}

-(void)tabBarButtonClick:(UIButton *)tabBarButton
{
    
    if (tabBarButton == _previousButton) {
        //重复点击，发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:UITabBarButtonDidRepeatClickNotification object:nil];
    }
}

@end
