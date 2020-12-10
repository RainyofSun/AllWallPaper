//
//  AWDynamicViewController.m
//  AllWallPaper
//
//  Created by EGLS_BMAC on 2020/12/7.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "AWDynamicViewController.h"
#import "AWDynamicViewModel.h"

@interface AWDynamicViewController ()

/** dynamicVM */
@property (nonatomic,strong) AWDynamicViewModel *dynamicVM;

@end

@implementation AWDynamicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.dynamicVM loadMainDynamicView:self.view];
}

#pragma mark - lazy
- (AWDynamicViewModel *)dynamicVM {
    if (!_dynamicVM) {
        _dynamicVM = [[AWDynamicViewModel alloc] init];
    }
    return _dynamicVM;
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
