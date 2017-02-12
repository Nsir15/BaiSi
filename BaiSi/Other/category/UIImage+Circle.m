//
//  UIImage+Circle.m
//  BaiSi
//
//  Created by N-X on 2016/2/12.
//  Copyright © 2016年 Marauder. All rights reserved.
//

#import "UIImage+Circle.h"

@implementation UIImage (Circle)
+ (instancetype)circleImage:(UIImage *)image
{
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
    return  image;
}
@end
