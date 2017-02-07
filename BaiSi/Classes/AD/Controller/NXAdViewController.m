//
//  NXAdViewController.m
//  BaiSi
//
//  Created by N-X on 2017/2/4.
//  Copyright © 2017年 Marauder. All rights reserved.
//

#import "NXAdViewController.h"
#import <MJExtension/MJExtension.h>
#import "NXAdModel.h"
#import "NXMainController.h"
#import <UIImageView+WebCache.h>
#import "NXRequest.h"
static const NSString * code2 = @"phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam";

static  NSString * adUrl = @"http://mobads.baidu.com/cpro/ui/mads.php";

@interface NXAdViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *launchImage;
@property (weak, nonatomic) IBOutlet UIView *adContainerView;
@property (weak, nonatomic) IBOutlet UIButton *tapBtn;
@property (nonatomic ,strong)UIImageView *adImageView;
@property (nonatomic ,weak)NSTimer * timer;
@property (nonatomic ,strong)NXAdModel *model;
@end

@implementation NXAdViewController
#pragma mark -- 点击事件处理
//点击跳过
- (IBAction)tapClick:(id)sender {
    [self removeAd];
}

- (void)tapAd{
    UIApplication * app = [UIApplication sharedApplication];
    if ([app canOpenURL:[NSURL URLWithString:_model.ori_curl]]) {
        [app openURL:[NSURL URLWithString:_model.ori_curl]];
    }
}
//倒计时
- (void)timerClick{
    static int time = 3;
    [self.tapBtn setTitle:[NSString stringWithFormat:@"点击跳过(%d)",time] forState:UIControlStateNormal];
    if (time < 0) {
        [self removeAd];
    }
    time -- ;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpBg];
    [self getAdData];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerClick) userInfo:nil repeats:YES];
}
// 6p : 736； 6 : 667 ； 5 : 568 ； 4 : 480；
- (void)setUpBg{
    NSString * imageName=@"";
    if (iPhone4) {
        imageName = @"LaunchImage-700";
    }else if (iPhone5){
        imageName = @"LaunchImage-700-568h";
    }else if (iPhone6){
        imageName = @"LaunchImage-800-667h";
    }else if (iPhone6P){
        imageName = @"LaunchImage-800-Portrait-736h";
    }
    _launchImage.image = [UIImage imageNamed:imageName];
}

- (void)getAdData{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"code2"] = code2;
    NXRequest * request = [[NXRequest alloc]init];
    [request requetsType:GET url:adUrl params:params  finish:^(id result, NSError *error) {
        if (!error) {
//            [result writeToFile:@"/Users/nancy/work/Practise/BaiSi/ad.plist" atomically:YES];
            _model = [[NXAdModel alloc]init];
            NSDictionary * adDict = [result[@"ad"] lastObject];
            [_model mj_setKeyValues:adDict];
            if(_model.w >0){
                CGFloat h = SCREENW / _model.w * _model.h;
                self.adImageView.frame = CGRectMake(0, 0, SCREENW, h);
                [self.adImageView sd_setImageWithURL:[NSURL URLWithString:_model.w_picurl]];
            }
            
        }else
        {
            NXLog(@"error:%@",error);
        }
    }];
}
- (UIImageView *)adImageView{
    if (!_adImageView) {
        _adImageView = [[UIImageView alloc]init];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAd)];
        [_adImageView addGestureRecognizer:tap];
        _adImageView.userInteractionEnabled = YES;  //这个不开启不能点击
        [self.adContainerView addSubview:_adImageView];
    }
    return _adImageView;
}
- (void)removeAd{
    [_timer invalidate];
    NXMainController * mainVc = [[NXMainController alloc]init];
    [UIApplication sharedApplication].keyWindow.rootViewController = mainVc;
}
@end
