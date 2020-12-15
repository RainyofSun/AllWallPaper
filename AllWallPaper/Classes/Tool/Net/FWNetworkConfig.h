//
//  FWNetworkConfig.h
//  FashionWallPaper
//
//  Created by EGLS_BMAC on 2020/11/25.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FWNetworkConfig : NSObject

/** 网络请求管理 */
@property (nonatomic,strong) AFHTTPSessionManager* manager;

+ (instancetype)netRequestConfig;

@end

NS_ASSUME_NONNULL_END
