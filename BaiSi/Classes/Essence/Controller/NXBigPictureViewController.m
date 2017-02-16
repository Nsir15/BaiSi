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
#import <Photos/Photos.h>
#import <SVProgressHUD.h>
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

/*
 一、保存图片到【自定义相册】
 1.保存图片到【相机胶卷】
 1> C语言函数UIImageWriteToSavedPhotosAlbum,这里的回调函数得注意，不能自己随便写，得写成建议的那种写法:点进头文件上面有回掉函数写法
 2> AssetsLibrary框架
 3> Photos框架
 
 2.拥有一个【自定义相册】
 1> AssetsLibrary框架
 2> Photos框架
 
 3.添加刚才保存的图片到【自定义相册】
 1> AssetsLibrary框架
 2> Photos框架
 
 二、Photos框架须知
 1.PHAsset : 一个PHAsset对象就代表相册中的一张图片或者一个视频
 1> 查 : [PHAsset fetchAssets...]
 2> 增删改 : PHAssetChangeRequest(包括图片\视频相关的所有改动操作)
 
 2.PHAssetCollection : 一个PHAssetCollection对象就代表一个相册
 1> 查 : [PHAssetCollection fetchAssetCollections...]
 2> 增删改 : PHAssetCollectionChangeRequest(包括相册相关的所有改动操作)
 
 3.对相片\相册的任何【增删改】操作，都必须放到以下方法的block中执行
 -[PHPhotoLibrary performChanges:completionHandler:]
 -[PHPhotoLibrary performChangesAndWait:error:]
 */

/*
 Foundation和Core Foundation的数据类型可以互相转换，比如NSString *和CFStringRef
 NSString *string = (__bridge NSString *)kCFBundleNameKey;
 CFStringRef string = (__bridge CFStringRef)@"test";
 
 获得相机胶卷相册
 [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil]
 */

- (IBAction)saveClick:(id)sender {
    
    //先获取授权
//    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    //请求权限
    // 如果用户还没有做出选择，会自动弹框，用户对弹框做出选择后，才会调用block
    // 如果之前已经做过选择，会直接执行block
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        NXLog(@"quque:%@",[NSThread currentThread]); //quque:<NSThread: 0x608000268380>{number = 6, name = (null)},说明当前不是在主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            switch (status) {
                case PHAuthorizationStatusAuthorized://允许
                {
                    [self saveImage];
                    break;
                }
                case PHAuthorizationStatusDenied://拒绝
                {
                    [SVProgressHUD showInfoWithStatus:@"请在设置中授权访问相册功能"];
                    break;
                }
                case PHAuthorizationStatusRestricted://无法访问，因为权限问题(比如：设置了家长控制)
                {
                    [SVProgressHUD showInfoWithStatus:@"没有权限访问相册功能"];
                    break;
                }
            }

        });
    }];
}
#pragma mark -- 保存图片处理

/*保存照片到自定义相册*/
- (void)saveImage
{
    //1.先保存照片到系通相册
    
    NSError * error;
    __block NSString * assetID = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
       assetID = [PHAssetChangeRequest creationRequestForAssetFromImage:self.imageView.image].placeholderForCreatedAsset.localIdentifier;
    } error:(&error)];
    
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存到系统相册失败"];
        return;
    }
    
    //2.创建自定义相册
    
    PHAssetCollection * collection = [self creatCollection];
    if (collection == nil) {
        [SVProgressHUD showErrorWithStatus:@"创建相册失败"];
        return;
    }
    
    //3.添加保存的照片到自定义相册
    //获取照片
   PHFetchResult<PHAsset *> * results = [PHAsset fetchAssetsWithLocalIdentifiers:@[assetID] options:nil];
    
    //添加
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
       PHAssetCollectionChangeRequest  * request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:collection];
        [request insertAssets:results atIndexes:[NSIndexSet indexSetWithIndex:0]];
    } error:&error];
    
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存图片失败"];
    }else
    {
        [SVProgressHUD showSuccessWithStatus:@"保存图片成功"];
    }
}

/*获取自定义相册*/
- (PHAssetCollection *)creatCollection
{
    //获取应用名称
    NSString * appName = [[NSBundle mainBundle] infoDictionary][(NSString *)kCFBundleNameKey];
    
    //先获取所有的自定义相册，看是否已经创建过
    PHFetchResult<PHAssetCollection *> * collections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    // 进入头文件可以看到该类型遵守快速遍历协议：NSFastEnumeration，所以可以使用for in 遍历
    for (PHAssetCollection * collection in collections) {
        if ([collection.localizedTitle isEqualToString:appName]) {
            return collection;
        }
    }
    
    //如果没有，那么创建自定义相册
    NSError * error;
    __block NSString * creationCollectionID = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
      creationCollectionID = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:appName].placeholderForCreatedAssetCollection.localIdentifier;
    } error:&error];
 
    if (error) {
        return nil;
    }
    
    return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[creationCollectionID] options:nil].firstObject;
}


//进行缩放的view
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
   return  self.imageView;
}
@end
