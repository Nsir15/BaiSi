//
//  NXLoginViewController.m
//  BaiSi
//
//  Created by N-X on 2017/2/5.
//  Copyright © 2017年 Marauder. All rights reserved.
//

#import "NXLoginViewController.h"
#import "NXLoginRegistView.h"
#import "NXFastLoginView.h"
@interface NXLoginViewController ()
@property (weak, nonatomic) IBOutlet UIView *middleView;

@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leading;

@end

@implementation NXLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView * loginView = [NXLoginRegistView loginView];
    [self.middleView addSubview:loginView];
    UIView * registView = [NXLoginRegistView registView];
    [self.middleView addSubview:registView];
    UIView * fastLogin = [NXFastLoginView fastLoginView];
    [self.bottomView addSubview:fastLogin];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    //在这里面设置尺寸
    UIView * loginView = [self.middleView subviews][0];
    loginView.frame = CGRectMake(0, 0, self.middleView.frame.size.width * 0.5, self.middleView.frame.size.height);
    UIView * registView = [self.middleView subviews][1];
    registView.frame = CGRectMake(self.middleView.frame.size.width * 0.5, 0, self.middleView.frame.size.width * 0.5, self.middleView.frame.size.height);
    UIView * fastLogin = [self.bottomView subviews][0];
    fastLogin.frame = CGRectMake(0, 0, self.bottomView.frame.size.width, self.bottomView.frame.size.height);
}
#pragma mark -- 点击事件处理
- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)registClick:(UIButton *)sender {
    sender.selected = ! sender.selected;
    self.leading.constant = self.leading.constant == 0 ? self.leading.constant -= self.middleView.frame.size.width * 0.5 :0;
    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutIfNeeded];
    } completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
