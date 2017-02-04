//
//  NXRecommendCell.h
//  BaiSi
//
//  Created by N-X on 2017/2/4.
//  Copyright © 2017年 Marauder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NXRecommendModel.h"
@interface NXRecommendCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *icon;

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *subTitle;
@property (nonatomic ,strong)NXRecommendModel *model;
@end
