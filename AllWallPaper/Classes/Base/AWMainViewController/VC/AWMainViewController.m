//
//  AWMainViewController.m
//  AllWallPaper
//
//  Created by EGLS_BMAC on 2020/12/7.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "AWMainViewController.h"
#import "AWMainViewModel.h"

@interface AWMainViewController ()

/** mainVM */
@property (nonatomic,strong) AWMainViewModel *mainVM;

@end

@implementation AWMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.mainVM loadTabBarController:self];
}

#pragma mark - lazy
- (AWMainViewModel *)mainVM {
    if (!_mainVM) {
        _mainVM = [[AWMainViewModel alloc] init];
    }
    return _mainVM;
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
