//
//  PXNetWorkingManager.m
//  Demo
//
//  Created by VID on 16/9/27.
//  Copyright © 2016年 铁甲小宝. All rights reserved.
//

#import "PXNetWorkingManager.h"
#import <AFNetworking.h>
#import "PXNetWorkingCache.h"

typedef enum {
    httpMethodTypeGet,
    httpMethodTypePost,
}httpMethodType;

@interface PXNetWorkingManager () {
   
}


@end
@implementation PXNetWorkingManager

static AFHTTPSessionManager *_manager;

static BOOL _isGetCache;

/** 监测网络*/
+ (void)detectNetwork {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
        if (([manager isReachableViaWiFi] || [manager isReachableViaWWAN])) {
            _isGetCache =  YES;
        } else {
            _isGetCache = NO;
        }
        [manager startMonitoring];

    });
}

+ (void)initialize {
    _manager = [AFHTTPSessionManager manager];
    //设置请求参数的类型:JSON (AFJSONRequestSerializer,AFHTTPRequestSerializer)
    _manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //设置请求的超时时间
    _manager.requestSerializer.timeoutInterval = 15.f;
    //设置服务器返回结果的类型:JSON (AFJSONResponseSerializer,AFHTTPResponseSerializer)
    _manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*", nil];
}

+ (NSURLSessionTask *)getWithUrl:(NSString *)url parameters:(NSDictionary *)parameters success:(responseSuccess)responseSuccess faliure:(responseFailure)responseFailure {
    return [self requestUrl:url parameters:parameters httpMethod:httpMethodTypeGet success:responseSuccess faliure:responseFailure];
}

+ (NSURLSessionTask *)postWithUrl:(NSString *)url parameters:(NSDictionary *)parameters success:(responseSuccess)responseSuccess faliure:(responseFailure)responseFailure {
    return [self postWithUrl:url parameters:parameters success:responseSuccess faliure:responseFailure];
}
/** 集中处理网络请求*/
+ (NSURLSessionTask *)requestUrl:(NSString *) url
                      parameters:(NSDictionary *) parameters
                      httpMethod:(httpMethodType) httpMethod
                         success:(responseSuccess) responseSuccess
                         faliure:(responseFailure) responseFailure{
    
    // 监测网络状态
     [self detectNetwork];
   // NSLog(@"%@",[self getNetWorkStates]);
    
    if (!_isGetCache) { // 读取缓存
        if (responseSuccess) {
            if ([PXNetWorkingCache cacheUrl:url params:parameters] != nil) {
                responseSuccess([PXNetWorkingCache cacheUrl:url params:parameters]);
                return nil;
            }
        }
    }

    if (httpMethod == httpMethodTypeGet) {
        
        return [_manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            // 缓存数据
            [PXNetWorkingCache saveCache:responseObject url:url params:parameters];
            
            if (responseSuccess) {
                responseSuccess(responseObject);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (responseFailure) {
                responseFailure(error);
            }
            
            
        }];
    } else {
        return [_manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            // 缓存数据
            [PXNetWorkingCache saveCache:responseObject url:url params:parameters];
            
            if (responseSuccess) {
                responseSuccess(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (responseFailure) {
                responseFailure(error);
            }
        }];
    }
}
/*
+(NSString *)getNetWorkStates{
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *children = [[[app valueForKeyPath:@"statusBar"]valueForKeyPath:@"foregroundView"]subviews];
    //    NSLog(@"%@",children);
    NSString *state = [[NSString alloc]init];
    int netType = 0;
    //获取到网络返回码
    for (id child in children) {
        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            //获取到状态栏
            netType = [[child valueForKeyPath:@"dataNetworkType"]intValue];
            
            switch (netType) {
                case 0:
                    state = @"无网络";
                    //无网模式
                    break;
                case 1:
                    state = @"2G";
                    break;
                case 2:
                    state = @"3G";
                    break;
                case 3:
                    state = @"4G";
                    break;
                case 5:
                {
                    state = @"WiFi";
                }
                    break;
                default:
                    state = @"无网络";
                    
                    break;
            }
        }
    }
    //根据状态选择
    //    NSLog(@"%@",state);
    return state;
}
*/
@end
