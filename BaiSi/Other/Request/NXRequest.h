//
//  NXRequest.h
//  BaiSi
//
//  Created by N-X on 2017/2/4.
//  Copyright © 2017年 Marauder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

typedef  NS_ENUM(NSInteger,requestType){
    GET,
    POST,
};
@interface NXRequest : NSObject
-(void)requetsType:(requestType)type url:(NSString *)url params:(NSDictionary *)params  finish:(void(^)(id  result,NSError * error))finish;
-(void)cancelTasks;
@end
