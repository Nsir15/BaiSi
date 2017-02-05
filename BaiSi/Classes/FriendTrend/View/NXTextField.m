//
//  NXTextField.m
//  BaiSi
//
//  Created by N-X on 2017/2/5.
//  Copyright © 2017年 Marauder. All rights reserved.
//

#import "NXTextField.h"
#import "UITextField+NXTextField.h"
@implementation NXTextField

- (void)awakeFromNib{
    self.tintColor = [UIColor whiteColor]; //设置光标颜色是白色
    //在编辑的时候placehold 文字高亮变成白色
    [self addTarget:self action:@selector(beginEdit) forControlEvents:UIControlEventEditingDidBegin];
    [self addTarget:self action:@selector(endEdit) forControlEvents:UIControlEventEditingDidEnd];
//    UILabel * placeholderLabel = [self valueForKey:@"placeholderLabel"];
//    placeholderLabel.textColor = [UIColor lightGrayColor];
    
    self.placeholdColor = [UIColor lightGrayColor];
}

- (void)beginEdit{
    
//    UITextField * textField; //随便写一个textField ,通过断点可以看到内部有一个 placeholderLabel 的私有属性
//    UILabel * placeholderLabel = [self valueForKey:@"placeholderLabel"]; //通过kvc 去获取
//    placeholderLabel.textColor = [UIColor whiteColor];
//    self.placeholdColor = [UIColor whiteColor];
    
    //第一个参数: 需要被设置属性的字符串
    //第二个参数: 需要设置的属性
    self.attributedPlaceholder = [[NSAttributedString alloc]initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

- (void)endEdit{
    UILabel * placeholderLabel = [self valueForKey:@"placeholderLabel"];
    placeholderLabel.textColor = [UIColor lightGrayColor];
}
@end
