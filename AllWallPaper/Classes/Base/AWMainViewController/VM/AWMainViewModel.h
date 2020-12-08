//
//  AWMainViewModel.h
//  AllWallPaper
//
//  Created by EGLS_BMAC on 2020/12/7.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "AWBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AWMainViewModel : AWBaseViewModel

/// 配置tabbar
- (void)loadTabBarController:(UIViewController *)vc;

@end

NS_ASSUME_NONNULL_END
