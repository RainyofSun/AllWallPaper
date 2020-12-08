//
//  AppDelegate+Advertising.m
//  FontLove
//
//  Created by EGLS_BMAC on 2020/11/19.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "AppDelegate+Advertising.h"

#define BUADKEY     @"5123765"
#define SLOTID      @"887408290"

static char *const AdvertisingKey = "AdvertisingKey";
static char *const networkKey     = "networkKey";

@implementation AppDelegate (Advertising)

- (void)FWInitChuanShanJiaSDK {
    [self startNetObserver];
    [self addNotification];
#if DEBUG
    [BUAdSDKManager setLoglevel:BUAdSDKLogLevelDebug];
#endif
    [BUAdSDKManager setAppID:BUADKEY];
    [BUAdSDKManager setIsPaidApp:NO];
    self.adView = [[BUSplashAdView alloc] initWithSlotID:SLOTID frame:[UIScreen mainScreen].bounds];
    self.adView.tolerateTimeout = 10;
    self.adView.delegate = self;
    [self.adView loadAdData];
    [KeyWindow.rootViewController.view addSubview:self.adView];
    self.adView.rootViewController = KeyWindow.rootViewController;
    if (@available(ios 14.0, *)) {
        
    }
}

#pragma mark - BUSplashAdDelegate
//- (void)splashAdDidLoad:(BUSplashAdView *)splashAd {
//    if ([splashAd isKindOfClass:[BUSplashAdView class]]) {
//        self.adView = splashAd;
//        [self.window addSubview:splashAd];
//        self.adView.rootViewController = KeyWindow.rootViewController;
//    }
//}

- (void)splashAdWillVisible:(BUSplashAdView *)splashAd {
    
}

- (void)splashAdDidClick:(BUSplashAdView *)splashAd {
    if ([splashAd isKindOfClass:[BUSplashAdView class]]) {
        self.adView = splashAd;
        [splashAd.rootViewController removeFromParentViewController];
        [splashAd removeFromSuperview];
    }
}

- (void)splashAdDidClose:(BUSplashAdView *)splashAd {
    if ([splashAd isKindOfClass:[BUSplashAdView class]]) {
        self.adView = splashAd;
        [splashAd.rootViewController removeFromParentViewController];
        [splashAd removeFromSuperview];
    }
}

- (void)splashAdDidClickSkip:(BUSplashAdView *)splashAd {
    if ([splashAd isKindOfClass:[BUSplashAdView class]]) {
        self.adView = splashAd;
        [splashAd.rootViewController removeFromParentViewController];
        [splashAd removeFromSuperview];
    }
}

- (void)splashAdWillClose:(BUSplashAdView *)splashAd {
    if ([splashAd isKindOfClass:[BUSplashAdView class]]) {
        self.adView = splashAd;
        [splashAd.rootViewController removeFromParentViewController];
        [splashAd removeFromSuperview];
    }
}

- (void)splashAdCountdownToZero:(BUSplashAdView *)splashAd {
    if ([splashAd isKindOfClass:[BUSplashAdView class]]) {
        self.adView = splashAd;
        [splashAd.rootViewController removeFromParentViewController];
        [splashAd removeFromSuperview];
    }
}

- (void)splashAd:(BUSplashAdView *)splashAd didFailWithError:(NSError *)error {
    if ([splashAd isKindOfClass:[BUSplashAdView class]]) {
        self.adView = splashAd;
        [self.adView.rootViewController removeFromParentViewController];
        [splashAd removeFromSuperview];
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    if (![KeyWindow.rootViewController.view.subviews containsObject:self.adView]) {
        [KeyWindow.rootViewController.view addSubview:self.adView];
        self.adView.rootViewController = KeyWindow.rootViewController;
    }
    [self.adView loadAdData];
}

/*
    开始网络监测
 */
- (void)startNetObserver {
    self.netObserver = [Reachability reachabilityForInternetConnection];
    [self.netObserver startNotifier];
}

#pragma mark - 通知
- (void)netStatusChange:(NSNotification *)notification {
    Reachability *currReach = [notification object];
    NSParameterAssert([currReach isKindOfClass:[Reachability class]]);
    //对连接改变做出响应处理动作
    NetworkStatus status = [currReach currentReachabilityStatus];
    //如果没有连接到网络就弹出提醒实况
    if(status == NotReachable) {
        // 页面监测慎用
        [[NSNotificationCenter defaultCenter] postNotificationName:(NSNotificationName)NetChangeErrorNotify object:@{}];
    } else {
        if (![KeyWindow.rootViewController.view.subviews containsObject:self.adView]) {
            [KeyWindow.rootViewController.view addSubview:self.adView];
            self.adView.rootViewController = KeyWindow.rootViewController;
        }
        [self.adView loadAdData];
    }
}

/*
    添加通知
 */
- (void)addNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netStatusChange:) name:kReachabilityChangedNotification object:nil];
}

#pragma mark - setter/getter
- (BUSplashAdView *)adView {
    return objc_getAssociatedObject(self, AdvertisingKey);
}

- (Reachability *)netObserver {
    return objc_getAssociatedObject(self, networkKey);
}

- (void)setAdView:(BUSplashAdView *)adView {
    objc_setAssociatedObject(self, AdvertisingKey, adView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setNetObserver:(Reachability *)netObserver {
    objc_setAssociatedObject(self, networkKey, netObserver, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
