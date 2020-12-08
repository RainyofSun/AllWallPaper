//
//  AWMainViewModel.m
//  AllWallPaper
//
//  Created by EGLS_BMAC on 2020/12/7.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "AWMainViewModel.h"
#import "AWTabBarViewController.h"

@implementation AWMainViewModel

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
// 配置tabbar
- (void)loadTabBarController:(UIViewController *)vc {
    AWTabBarViewController *tabBar = [[AWTabBarViewController alloc] init];
    [vc.view addSubview:tabBar.view];
    [vc addChildViewController:tabBar];
    tabBar.view.translatesAutoresizingMaskIntoConstraints = NO;
    [tabBar.view autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
}

@end
