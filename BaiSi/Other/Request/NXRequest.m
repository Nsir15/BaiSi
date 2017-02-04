//
//  NXRequest.m
//  BaiSi
//
//  Created by N-X on 2017/2/4.
//  Copyright © 2017年 Marauder. All rights reserved.
//

#import "NXRequest.h"
#import <AFNetworking/AFNetworking.h>
@implementation NXRequest
+(void)requetsType:(requestType)type url:(NSString *)url params:(NSDictionary *)params finish:(void(^)(id  result,NSError * error))finish{
    
    AFHTTPSessionManager * mgr = [AFHTTPSessionManager manager];
    mgr.requestSerializer.timeoutInterval = 5;
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
@end
