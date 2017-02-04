//
//  NXAdViewController.m
//  BaiSi
//
//  Created by N-X on 2017/2/4.
//  Copyright © 2017年 Marauder. All rights reserved.
//

#import "NXAdViewController.h"
#define SCREENH     [UIScreen mainScreen].bounds.size.height
#define SCREENW     [UIScreen mainScreen].bounds.size.width
#define iPhone4     SCREENH == 480
#define iPhone5     SCREENH == 568
#define iPhone6     SCREENH == 667
#define iPhone6P     SCREENH == 736

@interface NXAdViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *launchImage;

@end

@implementation NXAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpBg];
    
}
// 6p : 736； 6 : 667 ； 5 : 568 ； 4 : 480；
- (void)setUpBg{
    NSString * imageName;
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
