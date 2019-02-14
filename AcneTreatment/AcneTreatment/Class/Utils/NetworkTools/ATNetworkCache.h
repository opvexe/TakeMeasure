//
//  WDNetworkCache.h
//  AcneTreatment
//
//  Created by Facebook on 2018/7/31.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ATNetworkCache : NSObject
/// 异步缓存网络数据,根据请求的 URL与parameters
+ (void)setHttpCache:(id)httpData URL:(NSString *)URL parameters:(id)parameters;
/// 根据请求的 URL与parameters 同步取出缓存数据
+ (id)httpCacheForURL:(NSString *)URL parameters:(id)parameters;
/// 获取网络缓存的总大小 bytes(字节)
+ (NSInteger)getAllHttpCacheSize;
/// 删除所有网络缓存
+ (void)removeAllHttpCache;

+(void)saveHttpCache:(id)httpCache  forKey:(NSString *)key;
+(id)getHttpCacheForKey:(NSString *)key ;
@end
