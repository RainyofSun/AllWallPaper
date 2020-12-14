//
//  AWHeadPortraitSubViewController.m
//  AllWallPaper
//
//  Created by macos on 2020/12/14.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "AWHeadPortraitSubViewController.h"

@interface AWHeadPortraitSubViewController ()

@end

@implementation AWHeadPortraitSubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)addPortraitSubView:(UIView *)view {
    [self.view addSubview:view];
    [view autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
