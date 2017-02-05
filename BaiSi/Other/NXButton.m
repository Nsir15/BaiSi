//
//  NXButton.m
//  BaiSi
//
//  Created by N-X on 2017/2/5.
//  Copyright © 2017年 Marauder. All rights reserved.
//

#import "NXButton.h"
@implementation NXButton

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.nx_y = 0;
    self.imageView.nx_centerX = self.nx_centerX;
    self.titleLabel.nx_y = self.nx_height - self.titleLabel.nx_height;
    self.titleLabel.nx_centerX = self.nx_centerX;
}
@end
