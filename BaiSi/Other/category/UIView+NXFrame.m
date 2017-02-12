//
//  UIView+NXFrame.m
//  BaiSi
//
//  Created by N-X on 2016/2/5.
//  Copyright © 2016年 Marauder. All rights reserved.
//

#import "UIView+NXFrame.h"

@implementation UIView (NXFrame)
- (void)setNx_x:(CGFloat)nx_x
{
    CGRect frame = self.frame;
    frame.origin.x = nx_x;
    self.frame = frame;
}

- (CGFloat)nx_x
{
    return self.frame.origin.x;
}

- (void)setNx_y:(CGFloat)nx_y
{
    CGRect frame = self.frame;
    frame.origin.y = nx_y;
    self.frame = frame;
}
- (CGFloat)nx_y{
    return  self.frame.origin.y;
}
- (void)setNx_centerX:(CGFloat)nx_centerX
{
    CGPoint center = self.center;
    center.x = nx_centerX;
    self.center = center;
}
- (CGFloat)nx_centerX
{
    return self.center.x;
}
- (void)setNx_centerY:(CGFloat)nx_centerY
{
    CGPoint center = self.center;
    center.y = nx_centerY;
    self.center = center;
}
- (CGFloat)nx_centerY{
    return  self.center.y;
}
- (void)setNx_width:(CGFloat)nx_width
{
    CGRect frame = self.frame;
    frame.size.width = nx_width;
    self.frame = frame;
}
- (CGFloat)nx_width
{
    return  self.frame.size.width;
}

- (void)setNx_height:(CGFloat)nx_height
{
    CGRect frame = self.frame;
    frame.size.height = nx_height;
    self.frame = frame;
}
- (CGFloat)nx_height
{
    return self.frame.size.height;
}
@end
