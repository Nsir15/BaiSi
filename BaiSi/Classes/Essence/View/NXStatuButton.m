//
//  NXStatuButton.m
//  BaiSi
//
//  Created by N-X on 2017/2/7.
//  Copyright © 2017年 Marauder. All rights reserved.
//

#import "NXStatuButton.h"

@implementation NXStatuButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        self.titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

// 重写这个方法，防止选择的按钮长按下去变黑
- (void)setHighlighted:(BOOL)highlighted
{
    
}
@end
