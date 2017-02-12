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
@interface NXTopicCell()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *passtimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;


@end
@implementation NXTopicCell

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
