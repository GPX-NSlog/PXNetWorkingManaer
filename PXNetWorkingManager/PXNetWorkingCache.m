//
//  PXNetWorkingCache.m
//  Demo
//
//  Created by VID on 16/9/27.
//  Copyright © 2016年 铁甲小宝. All rights reserved.
//

#import "PXNetWorkingCache.h"
#import <YYCache.h>

@implementation PXNetWorkingCache

static NSString *const NetworkResponseCache = @"NetworkResponseCache";
static YYCache *_dataCache;

+ (void)initialize {
    _dataCache = [[YYCache alloc] initWithName:NetworkResponseCache];
}

+ (void)saveCache:(id)response url:(NSString *)url params:(NSDictionary *)params {
    NSString *cacheKey = [self geturl:url params:params];

    [_dataCache setObject:response forKey:cacheKey withBlock:nil];
    
}

+ (id)cacheUrl:(NSString *)url params:(NSDictionary *)params {
    
    NSString *cacheKey = [self geturl:url params:params];
    return [_dataCache objectForKey:cacheKey];
}

+ (NSInteger)getCacheSize {
    return [_dataCache.diskCache totalCount];
}

+ (void)clearCache {
    [_dataCache.diskCache removeAllObjects];
}

+ (NSString *)geturl:(NSString *)url params:(NSDictionary *)params {

    if(!params){return url;};
    
    // 将参数字典转换成字符串
    NSData *stringData = [NSJSONSerialization dataWithJSONObject:params options:0 error:nil];
    NSString *paraString = [[NSString alloc] initWithData:stringData encoding:NSUTF8StringEncoding];
    
    // 将URL与转换好的参数字符串拼接在一起,成为最终存储的KEY值
    NSString *cacheKey = [NSString stringWithFormat:@"%@%@",url,paraString];
    
    return cacheKey;
}
@end
