//
//  UITextField+NXTextField.h
//  BaiSi
//
//  Created by N-X on 2017/2/5.
//  Copyright © 2017年 Marauder. All rights reserved.
// 这里对textField 进行扩展，直接实现点击placehold 文字高亮为白色

#import <UIKit/UIKit.h>

@interface UITextField (NXTextField)
@property (nonatomic ,strong)UIColor *placeholdColor;
- (void)setNX_Placeholder:(NSString *)placeholder;
@end
