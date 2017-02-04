//
//  NXRecommendModel.h
//  BaiSi
//
//  Created by N-X on 2017/2/4.
//  Copyright © 2017年 Marauder. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NXRecommendModel : NSObject
@property(nonatomic,copy)NSString * image_list;
@property(nonatomic,copy)NSString * theme_name;
@property(nonatomic,copy)NSString * sub_number;
@property(nonatomic,copy)NSString * theme_id;
@property (nonatomic ,assign)int is_sub;
@property (nonatomic ,assign)int is_default;


@end
