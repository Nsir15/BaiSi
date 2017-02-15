//
//  NXTopicPictureView.m
//  BaiSi
//
//  Created by N-X on 2017/2/13.
//  Copyright © 2017年 Marauder. All rights reserved.
//

#import "NXTopicPictureView.h"
#import "NXTopicModel.h"
#import <UIImageView+WebCache.h>
#import <AFNetworkReachabilityManager.h>
#import "NXBigPictureViewController.h"
@interface NXTopicPictureView()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *gifLogo;
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;

@end
@implementation NXTopicPictureView

- (void)awakeFromNib
{
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bigPicture)];
    [self.imageView addGestureRecognizer:tap];
    self.imageView.userInteractionEnabled = YES;  //这个必须得打开
}

- (void)setTopicModel:(NXTopicModel *)topicModel
{
    _topicModel = topicModel;
    self.gifLogo.hidden = !topicModel.is_gif;
    UIImage * placeholder = nil;
    //先从本地取原图
    UIImage * originImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:topicModel.image1];
    if (originImage) {
        self.imageView.image = originImage;
    }else
    {
        AFNetworkReachabilityManager * manager = [AFNetworkReachabilityManager sharedManager];
        if (manager.isReachableViaWWAN) {//通过手机上网
            [self.imageView sd_setImageWithURL:[NSURL URLWithString:topicModel.image0] placeholderImage:nil];
        }else if(manager.isReachableViaWiFi)//通过wifi
        {
            [self.imageView sd_setImageWithURL:[NSURL URLWithString:topicModel.image1] placeholderImage:nil];
        }else //没网
        {
            UIImage * thumb = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:topicModel.image0];
            if (thumb) {
                self.imageView.image = thumb;
            }else
            {
                self.imageView.image = placeholder;
            }
        }
    }
    
    if (topicModel.isBigImage) {
        self.seeBigButton.hidden = NO;
        self.imageView.contentMode = UIViewContentModeTop;
        self.imageView.clipsToBounds = YES;
        
        if (self.imageView.image) {
            CGFloat imageW = SCREENW - NXMargin * 2;
            CGFloat imageH = topicModel.height * imageW / topicModel.width;
            CGSize size = CGSizeMake(imageW, imageH);
            UIGraphicsBeginImageContext(size);
            [self.imageView.image drawInRect:CGRectMake(0, 0, imageW, imageH)];
            self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        }
    }else
    {
        self.seeBigButton.hidden = YES;
        self.imageView.contentMode = UIViewContentModeScaleToFill;
        self.imageView.clipsToBounds = NO;
    }
    
}


- (void)bigPicture{
    NXBigPictureViewController * bigVc = [[NXBigPictureViewController alloc]init];
    bigVc.model = self.topicModel;
    [self.window.rootViewController  presentViewController:bigVc animated:YES completion:nil];
}

@end
