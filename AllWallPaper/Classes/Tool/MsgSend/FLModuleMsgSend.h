//
//  FLModuleMsgSend.h
//  FontLove
//
//  Created by EGLS_BMAC on 2020/11/17.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FLModuleMsgSend : NSObject

/// VC 跳转之间跳转传值
+ (UIViewController *)sendMsg:(id _Nullable)msg vcName:(NSString  * _Nonnull)name;
/// 不同层级之间通信(无参数)
+ (void)sendCumtomMethodMsg:(id _Nullable)obj methodName:(SEL)imp;
/// 不同层级之间通信(有参数)
+ (void)sendCumtomMethodMsg:(id _Nullable)obj methodName:(SEL)imp params:(id)params;

@end

NS_ASSUME_NONNULL_END
