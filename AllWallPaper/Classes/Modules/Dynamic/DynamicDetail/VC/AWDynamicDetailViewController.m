//
//  AWDynamicDetailViewController.m
//  AllWallPaper
//
//  Created by macos on 2020/12/15.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "AWDynamicDetailViewController.h"
#import "AWDynamicDetailViewModel.h"

@interface AWDynamicDetailViewController ()

/** detailVM */
@property (nonatomic,strong) AWDynamicDetailViewModel *detailVM;

@end

@implementation AWDynamicDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.detailVM loadDynamicDetailView:self.view];
    [self setNavHiden:YES];
}

#pragma mark - 消息透传
- (void)modulesSendMsg:(id)paprams {
    if ([paprams isKindOfClass:[NSString class]]) {
        self.detailVM.downLoadUrl = (NSString *)paprams;
    }
}

#pragma mark - lazy
- (AWDynamicDetailViewModel *)detailVM {
    if (!_detailVM) {
        _detailVM = [[AWDynamicDetailViewModel alloc] init];
    }
    return _detailVM;
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
