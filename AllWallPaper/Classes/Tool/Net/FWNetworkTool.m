//
//  FWNetworkTool.m
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/25.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "FWNetworkTool.h"
#import "FWNetworkConfig.h"

@implementation FWNetworkTool

#pragma mark -- GET请求 --
+ (void)getWithURLString:(NSString *)URLString
                 success:(void (^)(id))success
                 failure:(void (^)(NSError *))failure {
    WeakSelf;
    [[FWNetworkConfig netRequestConfig].manager GET:URLString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [weakSelf dictionaryForJsonData:(NSData *)responseObject];
        if (success) {
            success([dict objectForKey:@"data"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark -- POST请求 --
+ (void)postWithURLString:(NSString *)URLString
               parameters:(id)parameters
                  success:(void (^)(id))success
                  failure:(void (^)(NSError *))failure {
    WeakSelf;
    [[FWNetworkConfig netRequestConfig].manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [weakSelf dictionaryForJsonData:(NSData *)responseObject];
        if (success) {
            success([dict objectForKey:@"data"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark -- POST/GET网络请求 --
+ (void)requestWithURLString:(NSString *)URLString
                  parameters:(id)parameters
                        type:(HttpRequestType)type
                     success:(void (^)(id))success
                     failure:(void (^)(NSError *))failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    switch (type) {
        case HttpRequestTypeGet:
            [self getWithURLString:URLString success:success failure:failure];
            break;
        case HttpRequestTypePost:
            [self postWithURLString:URLString parameters:parameters success:success failure:failure];
            break;
    }
}

#pragma mark - 下载数据
+ (void)downLoadWithURLString:(NSString *)URLString progerss:(void (^)(CGFloat))progress success:(void (^)(NSURL * _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URLString]];
    NSURLSessionDownloadTask *downLoadTask = [[FWNetworkConfig netRequestConfig].manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        CGFloat p = downloadProgress.completedUnitCount / downloadProgress.totalUnitCount;
        FLOG(@"图片下载进度 %f",p);
        if (progress) {
            progress(p);
        }
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        //拼接缓存目录
        NSString *downloadDir = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"download"];
        //打开文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        //创建Download目录
        [fileManager createDirectoryAtPath:downloadDir withIntermediateDirectories:YES attributes:nil error:nil];
        //拼接文件路径
        NSString *filePath = [downloadDir stringByAppendingPathComponent:response.suggestedFilename];
        //返回文件位置的URL路径
        NSURL *fileUrl = [NSURL fileURLWithPath:filePath];
        if (success) {
            success(fileUrl);
        }
        return fileUrl;
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (failure) {
            failure(error);
        }
    }];
    [downLoadTask resume];
}

@end
