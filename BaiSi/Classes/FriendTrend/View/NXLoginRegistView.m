//
//  NXLoginRegistView.m
//  BaiSi
//
//  Created by N-X on 2017/2/5.
//  Copyright © 2017年 Marauder. All rights reserved.
// 一个xib可以管理多个view 

#import "NXLoginRegistView.h"

@interface NXLoginRegistView()
@property (weak, nonatomic) IBOutlet UIButton *loginRegistBtn;

@end
@implementation NXLoginRegistView
+ (instancetype)loginView{
    return  [[[NSBundle mainBundle] loadNibNamed:@"NXLoginRegistView" owner:nil options:nil] firstObject];
}

+ (instancetype)registView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}
-(void)awakeFromNib
{
//    [super awakeFromNib];
//    //在这里设置按钮背景图片拉伸的问题
    UIImage * image = self.loginRegistBtn.currentBackgroundImage;
    image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
    [self.loginRegistBtn setBackgroundImage:image forState:UIControlStateNormal];
}

@end
