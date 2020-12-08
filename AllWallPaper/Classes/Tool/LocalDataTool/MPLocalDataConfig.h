//
//  MPLocalDataConfig.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/27.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#ifndef MPLocalDataConfig_h
#define MPLocalDataConfig_h

/*
    block 回调
 */
typedef void(^ _Nonnull LocalDataCallBack)(id _Nonnull responseObject);
typedef void(^ _Nullable ErrorCallBack)(NSString * _Nullable errorInfo);

#endif /* MPLocalDataConfig_h */
