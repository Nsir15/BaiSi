//
//  UINavigationItem+item.h
//  BaiSi
//
//  Created by N-X on 2017/2/3.
//  Copyright © 2017年 Marauder. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationItem (item)
+ (UIBarButtonItem *)customeButtonItemWithImage:(NSString *)image highLightImage:(NSString *)highLightImage target:(id)target action:(SEL)action;
+ (UIBarButtonItem *)customeButtonItemWithImage:(NSString *)image selectedImage:(NSString *)highLightImage target:(id)target action:(SEL)action;
+ (UIBarButtonItem *)backButtonItemWithImage:(NSString *)image highLightImage:(NSString *)highLightImage target:(id)target action:(SEL)action title:(NSString *)title;
@end
