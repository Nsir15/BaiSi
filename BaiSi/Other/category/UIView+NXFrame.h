//
//  UIView+NXFrame.h
//  BaiSi
//
//  Created by N-X on 2016/2/5.
//  Copyright © 2016年 Marauder. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (NXFrame)
@property (nonatomic ,assign)CGFloat nx_x;
@property (nonatomic ,assign)CGFloat nx_y;
@property (nonatomic ,assign)CGFloat nx_centerX;
@property (nonatomic ,assign)CGFloat nx_centerY;
@property (nonatomic ,assign)CGFloat nx_height;
@property (nonatomic ,assign)CGFloat nx_width;

/*从xib加载view*/
+(instancetype)NX_ViewFromXib;
@end
