//
//  NXRequest.m
//  BaiSi
//
//  Created by N-X on 2017/2/4.
//  Copyright © 2017年 Marauder. All rights reserved.
//

#import "NXRequest.h"
@interface NXRequest()
@property (nonatomic ,strong)AFHTTPSessionManager *manager;
@end
@implementation NXRequest
static AFHTTPSessionManager * manager;
- (AFHTTPSessionManager *)shareManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
    });
    return manager;
}
-(void)requetsType:(requestType)type url:(NSString *)url params:(NSDictionary *)params  finish:(void(^)(id  result,NSError * error))finish{
    
    AFHTTPSessionManager * mgr = [self shareManager];
    mgr.requestSerializer.timeoutInterval = 5;
    _manager = mgr;
    switch (type) {
        case GET:
        {
            [mgr GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                finish(responseObject,nil);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                finish(nil,error);
            }];
            
            break;
        }
           
        case POST:
        {
            [mgr POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                finish(responseObject,nil);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                finish(nil,error);
            }];
            break;
        }
        default:
            break;
    }
  
}
- (void)cancelTasks
{
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
}
@end
