//
//  NXTopicVoiceView.m
//  BaiSi
//
//  Created by N-X on 2017/2/13.
//  Copyright © 2017年 Marauder. All rights reserved.
//

#import "NXTopicVoiceView.h"
#import "NXTopicModel.h"
@interface NXTopicVoiceView()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *voicetimeLabel;

@end
@implementation NXTopicVoiceView

- (void)setTopicModel:(NXTopicModel *)topicModel
{
    _topicModel = topicModel;
    
}

@end
