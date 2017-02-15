//
//  NXBigPictureViewController.m
//  BaiSi
//
//  Created by N-X on 2017/2/15.
//  Copyright © 2017年 Marauder. All rights reserved.
//

#import "NXBigPictureViewController.h"
#import <UIImageView+WebCache.h>
#import "NXTopicModel.h"
@interface NXBigPictureViewController ()<UIScrollViewDelegate>
@property (nonatomic ,strong)UIScrollView *scrollView;
@property (nonatomic ,strong)UIImageView *imageView;
@end

@implementation NXBigPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _scrollView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _scrollView.backgroundColor = [UIColor blackColor];
    [self.view insertSubview:_scrollView atIndex:0];
    CGFloat imageW = SCREENW;
    CGFloat imageH = self.model.height * imageW / self.model.width;
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, imageW, imageH)];
    [_scrollView addSubview:_imageView];
    _imageView.backgroundColor = [UIColor redColor];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backClick)];
    [_imageView addGestureRecognizer:tap];
    _imageView.userInteractionEnabled = YES;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:self.model.image1] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image) {
            self.imageView.image = image;
        }
    }];
    if (imageH > SCREENH) {
        _scrollView.contentSize =CGSizeMake(imageW, imageH);
    }else
    {
        _imageView.nx_centerY = SCREENH * 0.5;
    }
    CGFloat scale = self.model.width / SCREENW;
    if (scale > 1) {
        _scrollView.maximumZoomScale = scale;//缩放比例
        _scrollView.delegate = self;
    }
}

- (IBAction)backClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)saveClick:(id)sender {
    
}

//进行缩放的view
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
   return  self.imageView;
}
@end
