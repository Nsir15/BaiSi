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
    [super awakeFromNib];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bigPicture)];
    [self.imageView addGestureRecognizer:tap];
    self.imageView.userInteractionEnabled = YES;  //这个必须得打开
}

- (void)NX_SetOriginImage:(NSString *)originImageUrl thumbnailImage:(NSString *)thumbnailImageUrl placeholder:(UIImage *)placeholder complete:(void(^)(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL))complete
{
    //先从本地取原图
    UIImage * originImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:originImageUrl];
    if (originImage) {
        self.imageView.image = originImage;
        complete(originImage,nil,0,[NSURL URLWithString:originImageUrl]);
    }else
    {
        AFNetworkReachabilityManager * manager = [AFNetworkReachabilityManager sharedManager];
        if (manager.isReachableViaWWAN) {//通过手机上网
            [self.imageView sd_setImageWithURL:[NSURL URLWithString:thumbnailImageUrl] placeholderImage:nil completed:complete];
        }else if(manager.isReachableViaWiFi)//通过wifi
        {
            [self.imageView sd_setImageWithURL:[NSURL URLWithString:originImageUrl] placeholderImage:nil completed:complete];
        }else //没网
        {
            UIImage * thumb = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:thumbnailImageUrl];
            if (thumb) {//缩略图已经被下载过
                self.imageView.image = thumb;
                complete(thumb,nil,0,[NSURL URLWithString:thumbnailImageUrl]);
            }else
            {//没有下载过任何图片
                self.imageView.image = placeholder;
            }
        }
    }

}

- (void)setTopicModel:(NXTopicModel *)topicModel
{
    _topicModel = topicModel;
    self.gifLogo.hidden = !topicModel.is_gif;
    
    [self NX_SetOriginImage:self.topicModel.image1 thumbnailImage:self.topicModel.image0 placeholder:nil complete:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //大图处理
        if (self.imageView.image && topicModel.isBigImage) {
            CGFloat imageW = SCREENW - NXMargin * 2;
            CGFloat imageH = topicModel.height * imageW / topicModel.width;
            CGSize size = CGSizeMake(imageW, imageH);
            UIGraphicsBeginImageContext(size);
            [self.imageView.image drawInRect:CGRectMake(0, 0, imageW, imageH)];
            self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        }
    }];
    if (topicModel.isBigImage) {
        self.seeBigButton.hidden = NO;
        self.imageView.contentMode = UIViewContentModeTop;
        self.imageView.clipsToBounds = YES;
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
