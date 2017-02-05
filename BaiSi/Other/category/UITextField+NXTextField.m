//
//  UITextField+NXTextField.m
//  BaiSi
//
//  Created by N-X on 2017/2/5.
//  Copyright © 2017年 Marauder. All rights reserved.
//

#import "UITextField+NXTextField.h"
#import <objc/message.h>
@implementation UITextField (NXTextField)
+ (void)load{
    Method setPlaceholder = class_getInstanceMethod(self, @selector(setPlaceholder:));
    Method setNx_Placeholder = class_getInstanceMethod(self, @selector(setNX_Placeholder:));
    method_exchangeImplementations(setPlaceholder, setNx_Placeholder);
}

- (void)setPlaceholdColor:(UIColor *)placeholdColor
{
    //先将placeholdColor 存起来
    //参数一：给哪个对象添加成员属性
    //参数二：成员属性的名字
    //参数三：成员属性的值
    objc_setAssociatedObject(self, @"placeholdColor", placeholdColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    //根据判断，textField 内部的 placehold  是一个label 的标签
    
    UILabel * placeholderLabel = [self valueForKey:@"placeholderLabel"];
    placeholderLabel.textColor = placeholdColor;
    
}
- (UIColor *)placeholdColor{
    return objc_getAssociatedObject(self, @"placeholdColor");
}

//自顶一个setPlaceholder方法，在内部1.先设置文字。 2.设置颜色
- (void)setNX_Placeholder:(NSString *)placeholder
{
    self.placeholder = placeholder;
    self.placeholdColor = self.placeholdColor;
}
@end
