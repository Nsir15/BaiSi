//
//  NXTopicCell.m
//  BaiSi
//
//  Created by N-X on 2017/2/12.
//  Copyright © 2017年 Marauder. All rights reserved.
//

#import "NXTopicCell.h"
#import "NXTopicModel.h"
#import <UIImageView+WebCache.h>
#import "UIImage+Circle.h"
#import "NXTopicVoiceView.h"
#import "NXTopicVideoView.h"
#import "NXTopicPictureView.h"

@interface NXTopicCell()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *passtimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
/*热门评论容器view*/
@property (weak, nonatomic) IBOutlet UIView *hotCmtContainerView;
/*评论的用户名*/
@property (weak, nonatomic) IBOutlet UIButton *userName;

@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

/****************** middleView **********************/

@property (nonatomic ,strong) NXTopicVoiceView * voiceView;
@property (nonatomic ,strong)NXTopicPictureView *pictureView;
@property (nonatomic ,strong)NXTopicVideoView *videoView;

@end
@implementation NXTopicCell
#pragma mark -- middle  view  懒加载
- (NXTopicVoiceView *)voiceView
{
    if (!_voiceView) {
        _voiceView = [NXTopicVoiceView NX_ViewFromXib];
        [self.contentView addSubview:_voiceView];
    }
    return _voiceView;
}

- (NXTopicPictureView *)pictureView
{
    if (!_pictureView) {
        _pictureView = [NXTopicPictureView NX_ViewFromXib];
        [self.contentView addSubview:_pictureView];
    }
    return _pictureView;
}

- (NXTopicVideoView *)videoView
{
    if (!_videoView) {
        _videoView = [NXTopicVideoView NX_ViewFromXib];
        [self.contentView addSubview:_videoView];
    }
    return _videoView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setTopicModel:(NXTopicModel *)topicModel
{
    _topicModel = topicModel;
    self.nameLabel.text = topicModel.name;
    self.passtimeLabel.text = topicModel.passtime;
    self.text_label.text = topicModel.text;
    UIImage * palceHolder = [UIImage circleImage:[UIImage imageNamed:@"defaultUserIcon"]];
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topicModel.profile_image] placeholderImage:palceHolder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image) {
            self.profileImageView.image = [UIImage circleImage:image];
        }
    }];
    if (!topicModel.top_cmtArray.count) {
        self.hotCmtContainerView.hidden = YES;
    }else
    {
        self.hotCmtContainerView.hidden = NO;
    }
    
    //添加中间内容
    switch (topicModel.type) {
        case TopicType_voice:
        {
            //这里会多次调用，所以应该用懒加载，免得重复加载
            self.voiceView.hidden = NO;
            self.videoView.hidden = YES;
            self.pictureView.hidden = YES;
            self.voiceView.topicModel = topicModel;
            break;
        }
        case TopicType_video:
        {
            self.voiceView.hidden = YES;
            self.videoView.hidden = NO;
            self.pictureView.hidden = YES;
            self.videoView.topicModel = topicModel;
            break;
        }
        case TopicType_image:
        {
            self.voiceView.hidden = YES;
            self.videoView.hidden = YES;
            self.pictureView.hidden = NO;
            self.pictureView.topicModel = topicModel;
            break;
        }
        case TopicType_word:
        {
            self.voiceView.hidden = YES;
            self.videoView.hidden = YES;
            self.pictureView.hidden = YES;
            break;
        }
        default:
        {
            break;
        }
    }
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    switch (self.topicModel.type) {
        case TopicType_voice:
        {
            self.voiceView.frame = self.topicModel.middleFrame;
            break;
        }
        case TopicType_video:
        {
            self.videoView.frame = self.topicModel.middleFrame;
            break;
        }
        case TopicType_image:
        {
            self.pictureView.frame = self.topicModel.middleFrame;
            break;
        }
        default:
            break;
    }

}
- (void)setFrame:(CGRect)frame
{
    frame.size.height -= NXMargin;
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
