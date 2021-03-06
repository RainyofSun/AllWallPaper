//
//  AWHeadPortraitViewController.m
//  AllWallPaper
//
//  Created by EGLS_BMAC on 2020/12/7.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "AWHeadPortraitViewController.h"
#import "AWHeadPortraitViewModel.h"

@interface AWHeadPortraitViewController ()

/** headPortraitVM */
@property (nonatomic,strong) AWHeadPortraitViewModel *headPortraitVM;

@end

@implementation AWHeadPortraitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.headPortraitVM loadHeadPortraitControl:self];
}

#pragma mark - lazy
- (AWHeadPortraitViewModel *)headPortraitVM {
    if (!_headPortraitVM) {
        _headPortraitVM = [[AWHeadPortraitViewModel alloc] init];
    }
    return _headPortraitVM;
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
