//
//  AppDelegate+Advertising.h
//  FontLove
//
//  Created by EGLS_BMAC on 2020/11/19.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "AppDelegate.h"
#import "Reachability.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (Advertising)<BUSplashAdDelegate>

/** adView */
@property (nonatomic,strong) BUSplashAdView *adView;
/** 网络监测 */
@property (nonatomic,strong) Reachability *netObserver;

- (void)FWInitChuanShanJiaSDK;

@end

NS_ASSUME_NONNULL_END
