//
//  AWStaticViewController.m
//  AllWallPaper
//
//  Created by EGLS_BMAC on 2020/12/7.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "AWStaticViewController.h"
#import "AWStaticViewModel.h"

@interface AWStaticViewController ()

/** staticVM */
@property (nonatomic,strong) AWStaticViewModel *staticVM;

@end

@implementation AWStaticViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.staticVM loadStaticView:self];
}

#pragma mark - lazy
- (AWStaticViewModel *)staticVM {
    if (!_staticVM) {
        _staticVM = [[AWStaticViewModel alloc] init];
    }
    return _staticVM;
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
