//
//  FWNetworkTool.h
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/25.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class FWUploadParam;

@interface FWNetworkTool : NSObject

/**
 *  网络请求类型
 */
typedef NS_ENUM(NSUInteger,HttpRequestType) {
    /**
     *  get请求
     */
    HttpRequestTypeGet = 0,
    /**
     *  post请求
     */
    HttpRequestTypePost
};

/**
 *  发送get请求
 *
 *  @param URLString  请求的网址字符串
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
+ (void)getWithURLString:(NSString *)URLString
                 success:(void (^)(id responseObject))success
                 failure:(void (^)(NSError *error))failure;

/**
 *  发送post请求
 *
 *  @param URLString  请求的网址字符串
 *  @param parameters 请求的参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
+ (void)postWithURLString:(NSString *)URLString
               parameters:(id)parameters
                  success:(void (^)(id responseObject))success
                  failure:(void (^)(NSError *error))failure;

/**
 *  发送网络请求
 *
 *  @param URLString   请求的网址字符串
 *  @param parameters  请求的参数
 *  @param type        请求的类型
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
+ (void)requestWithURLString:(NSString *)URLString
                  parameters:(id)parameters
                        type:(HttpRequestType)type
                     success:(void (^)(id responseObject))success
                     failure:(void (^)(NSError *error))failure;

/**
 *  下载数据
 *
 *  @param URLString   下载数据的网址
 *  @param progress    下载进度
 *  @param success     下载成功的回调
 *  @param failure     下载失败的回调
 */
+ (void)downLoadWithURLString:(NSString *)URLString
                     progerss:(void (^)(CGFloat progress))progress
                      success:(void (^)(NSURL *targetPath))success
                      failure:(void (^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
