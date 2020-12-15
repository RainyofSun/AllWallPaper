//
//  AWHeadPortaritDetailViewController.m
//  AllWallPaper
//
//  Created by macos on 2020/12/15.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "AWHeadPortaritDetailViewController.h"
#import "AWHeadPortaritDetailViewModel.h"

@interface AWHeadPortaritDetailViewController ()

/** detailVM */
@property (nonatomic,strong) AWHeadPortaritDetailViewModel *detailVM;

@end

@implementation AWHeadPortaritDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.detailVM loadHeadPortaritDetailView:self.view];
}

#pragma mark - 消息透传
- (void)modulesSendMsg:(id)paprams {
    if ([paprams isKindOfClass:[NSDictionary class]]) {
        self.title = (NSString *)[paprams objectForKey:@"title"];
        self.detailVM.dataIndex = [[paprams objectForKey:@"index"] integerValue];
        self.detailVM.viewStyle = [[paprams objectForKey:@"viewStyle"] integerValue];
    }
}

#pragma mark - lazy
- (AWHeadPortaritDetailViewModel *)detailVM {
    if (!_detailVM) {
        _detailVM = [[AWHeadPortaritDetailViewModel alloc] init];
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
