//
//  FWNetworkConfig.m
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/25.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "FWNetworkConfig.h"

static FWNetworkConfig *config = nil;

@implementation FWNetworkConfig

+ (instancetype)netRequestConfig {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!config) {
            config = [[FWNetworkConfig alloc] init];
        }
    });
    return config;
}

- (instancetype)init {
    if (self = [super init]) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        config.timeoutIntervalForRequest = 60;
        self.manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:HOSTURL] sessionConfiguration:config];
        self.manager.requestSerializer.HTTPMethodsEncodingParametersInURI = [NSSet setWithArray:@[@"POST",@"GET", @"HEAD"]];
        self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",@"image/png",@"image/jpeg", nil];
        [self.manager.requestSerializer setValue:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] forHTTPHeaderField:@"versionNumber"];
        [self.manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    }
    return self;
}

@end
