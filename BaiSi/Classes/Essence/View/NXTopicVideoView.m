//
//  NXTopicVideoView.m
//  BaiSi
//
//  Created by N-X on 2017/2/13.
//  Copyright © 2017年 Marauder. All rights reserved.
//

#import "NXTopicVideoView.h"
#import "NXTopicModel.h"
#import <UIImageView+WebCache.h>
@interface NXTopicVideoView()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *videoTimeLabel;

@end
@implementation NXTopicVideoView

- (void)setTopicModel:(NXTopicModel *)topicModel
{
    _topicModel = topicModel;
    self.playCountLabel.text = [NSString stringWithFormat:@"%@播放",topicModel.playcount];
    self.videoTimeLabel.text = [NSString stringWithFormat:@"%@", [self timeStr:topicModel.videotime]];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topicModel.image1] placeholderImage:[UIImage imageNamed:@""]];
}

- (NSString *)timeStr:(NSString *)strTime{
    NSString * timeString;
    NSInteger time = [strTime integerValue];
    if (time > 60 * 60) {
        timeString = [NSString stringWithFormat:@"%zd:%02zd:%zd",time/3600,(time % 3600)/60,(time % 3600) % 60];
    }else if (time > 60){
        timeString = [NSString stringWithFormat:@"%02zd:%02zd",time/60,time % 60];
    }else
    {
        timeString = [NSString stringWithFormat:@"00:%2zd",time];
    }
    return timeString;
}
@end
