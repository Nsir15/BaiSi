//
//  NXRecommendCell.m
//  BaiSi
//
//  Created by N-X on 2017/2/4.
//  Copyright © 2017年 Marauder. All rights reserved.
//

#import "NXRecommendCell.h"
#import <UIImageView+WebCache.h>

@implementation NXRecommendCell

- (void)setModel:(NXRecommendModel *)model
{
    _model = model;
    self.title.text = model.theme_name;
    NSString * subStr = [NSString  stringWithFormat:@"%@人订阅",model.sub_number];
    if ([model.sub_number floatValue] > 10000.0) {
        CGFloat number = [model.sub_number floatValue] / 10000.0;
        subStr = [NSString stringWithFormat:@"%.1f万人订阅",number];
        subStr = [subStr stringByReplacingOccurrencesOfString:@".0" withString:@""]; //小数点后面是0的话就去掉0
    }
    self.subTitle.text = subStr;
//    [self.icon sd_setImageWithURL:[NSURL URLWithString:model.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    [self.icon sd_setImageWithURL:[NSURL URLWithString:model.image_list] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //裁剪圆角图片  ， 需要利用图形上下文
        //1.获取图形上下文
        //第三个参数 主要是做屏幕适配的，0 会自适应，3的话是plus，retina是。。
        UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
        //2.描述裁剪区域
        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
        //3.设置裁剪区域
        [bezierPath addClip];
        //4.画图片
        [image drawAtPoint:CGPointZero];
        //5.取出图片
        image = UIGraphicsGetImageFromCurrentImageContext();
        //6.关闭上下文
        UIGraphicsEndImageContext();
        self.icon.image = image;
    }];
}
//从xib加载完成的时候会调用一次
- (void)awakeFromNib {
    [super awakeFromNib];
    //设置头像圆角   iOS9之后用下面的方法设置圆角不会产生性能问题
//    self.icon.layer.cornerRadius = self.icon.frame.size.width * 0.5;
//    self.icon.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (IBAction)submitClick:(id)sender {
    NXLog(@"submitClick");
}
@end
