//
//  PXNetWorkingCache.h
//  Demo
//
//  Created by VID on 16/9/27.
//  Copyright © 2016年 铁甲小宝. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PXNetWorkingCache : NSObject

/**
 *  存储缓存
 *
 *  @param response 请求下来的数据
 *  @param url      请求地址
 *  @param params   请求参数
 */
+ (void)saveCache:(id)response url:(NSString *)url params:(NSDictionary *)params;
/**
 *  读取换出
 *
 *  @param url    请求地址
 *  @param params 请求参数
 *
 *  @return 缓存数据
 */
+ (id)cacheUrl:(NSString *)url params:(NSDictionary *)params;
/** 获取缓存大小*/
+ (NSInteger)getCacheSize;
/** 清除缓存 */
+ (void)clearCache;
@end
