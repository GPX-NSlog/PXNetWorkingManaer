//
//  PXNetWorkingManager.h
//  Demo
//
//  Created by VID on 16/9/27.
//  Copyright © 2016年 铁甲小宝. All rights reserved.
//

#import <Foundation/Foundation.h>
/** 请求成功block*/
typedef void(^responseSuccess)(id responseObject);
/** 请求失败block*/
typedef void(^responseFailure)(NSError *error);

@interface PXNetWorkingManager : NSObject

/**
 *  get请求
 *
 *  @param url             请求地址
 *  @param parameters      参数
 *  @param responseSuccess 请求成功的block
 *  @param responseFailure 请求失败的block
 */
+ (NSURLSessionTask *)getWithUrl:(NSString *) url parameters:(NSDictionary *)parameters success:(responseSuccess)responseSuccess faliure:(responseFailure)responseFailure;
/**
 *  post请求
 *
 *  @param url             请求地址
 *  @param parameters      参数
 *  @param responseSuccess 请求成功的block
 *  @param responseFailure 请求失败的block
 */
+ (NSURLSessionTask *)postWithUrl:(NSString *) url parameters:(NSDictionary *)parameters success:(responseSuccess)responseSuccess faliure:(responseFailure)responseFailure;
@end
