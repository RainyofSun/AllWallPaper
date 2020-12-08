//
//  MPLocalData.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/27.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MPLocalDataConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface MPLocalData : NSObject

/**
 * 获取本地数据
 * @param localFileName 本地数据文件名
 * @param dataBlock     本地数据
 * @param error    错误
 */
+ (void)MPGetLocalDataFileName:(NSString *)localFileName localData:(LocalDataCallBack)dataBlock errorBlock:(ErrorCallBack)error;

@end

NS_ASSUME_NONNULL_END
