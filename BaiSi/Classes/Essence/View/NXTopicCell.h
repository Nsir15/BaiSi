//
//  NXTopicCell.h
//  BaiSi
//
//  Created by N-X on 2017/2/12.
//  Copyright © 2017年 Marauder. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NXTopicModel;
@interface NXTopicCell : UITableViewCell
@property (nonatomic ,strong)NXTopicModel *topicModel;
//顶部的容器view
@property (weak, nonatomic) IBOutlet UIView *topContainerView;
//底部的容器view
@property (weak, nonatomic) IBOutlet UIView *bottomContainerView;
@property (weak, nonatomic) IBOutlet UILabel *text_label;

@end
