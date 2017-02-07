//
//  NXSettingViewController.m
//  BaiSi
//
//  Created by N-X on 2017/2/3.
//  Copyright © 2017年 Marauder. All rights reserved.
//

#import "NXSettingViewController.h"
#import <SDWebImage/SDImageCache.h>
static NSString * const cellID = @"cell";
@interface NXSettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)UITableView *tableView;
@end

@implementation NXSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    self.tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
}


#pragma mark -- tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.textLabel.text = @"清除缓存";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   NSUInteger  cach = [[SDImageCache sharedImageCache] getSize];
    NXLog(@"sdweb-----caches:%lu",(unsigned long)cach);
    
    //1.先获取cache 目录的路径
    NSString * cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    // 这里先以获取 default  文件夹大小做实验，看看是否和 SDImageCache 获取的一样
    NSString * directorPath = [cachePath stringByAppendingPathComponent:@"default"];
    
    [self getFileSize:directorPath completion:^(NSUInteger totoalSize) {
        
    }];
}

- (void)getFileSize:(NSString *)directorPath completion:(void(^)(NSUInteger totoalSize))completion{
   
    //2.声明一个文件管理对象
    NSFileManager * fileManager = [NSFileManager defaultManager];
    
    // 在这里做一些异常的处理
    //判断是否是文件夹
    BOOL isDirector;
    BOOL fileExist = [fileManager fileExistsAtPath:directorPath isDirectory:&isDirector];
    if (!fileExist || !isDirector) {
       NSException * exception = [NSException exceptionWithName:@"PathError" reason:@"hey,man,这里需要的是一个文件夹的路径，并且是存在的" userInfo:nil];
        [exception raise];
    }
    
    
    //3.在 SDImageCache 的getSize 方法里面我们看到调用了一个方法  NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];所以我们也模仿他去做
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //这个可以获取所有的子文件及子文件下的文件
        NSArray * subPaths = [fileManager subpathsAtPath:directorPath];
        NSUInteger totoalSize = 0 ;
        for (NSString * path in subPaths) {
            NSString * filePath = [directorPath stringByAppendingPathComponent:path];
            
            //判断是否是隐藏文件
            if ([filePath containsString:@".DS"]) {
                continue;
            }
            //判断是否是文件夹
            BOOL isDirector;
            BOOL fileExist = [fileManager fileExistsAtPath:filePath isDirectory:&isDirector];
            if (!fileExist || isDirector) {
                continue;
            }
            NSDictionary * attrs = [fileManager attributesOfItemAtPath:filePath error:nil];
            //4.最后获取size
            totoalSize += [attrs fileSize];
        }
        //完成之后回调
        //这里需要在主线程去回调。不然接收不到值。这里可以用同步操作，不会太耗时
        dispatch_sync(dispatch_get_main_queue(), ^{
            if (completion) {
                completion(totoalSize);
            }
        });
       
    });
}

- (void)removeFiles:(NSString *)directorPath{
     NSFileManager * manager = [NSFileManager defaultManager];
    //这个方法是获取该文件下的所有子文件夹，不会获取子文件夹里的文件(这里没必要了，直接删除文件夹就可以)
    NSArray * subDirectors = [manager contentsOfDirectoryAtPath:directorPath error:nil];
    for (NSString * path in subDirectors) {
        NSString * filePath = [directorPath stringByAppendingPathComponent:path];
        //删除文件夹
        [manager removeItemAtPath:filePath error:nil];
    }
    
}
@end
