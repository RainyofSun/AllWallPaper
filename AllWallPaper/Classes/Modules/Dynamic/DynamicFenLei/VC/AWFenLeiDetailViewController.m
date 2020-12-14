//
//  AWFenLeiDetailViewController.m
//  AllWallPaper
//
//  Created by macos on 2020/12/14.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "AWFenLeiDetailViewController.h"
#import "AWFenLeiDetailViewModel.h"

@interface AWFenLeiDetailViewController ()

/** fenLeiDetailVM */
@property (nonatomic,strong) AWFenLeiDetailViewModel *fenLeiDetailVM;

@end

@implementation AWFenLeiDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.fenLeiDetailVM loadFenLeiDetailView:self.view];
}

#pragma mark - 消息透传
- (void)modulesSendMsg:(id)paprams {
    if ([paprams isKindOfClass:[NSDictionary class]]) {
        self.title = (NSString *)[paprams objectForKey:@"title"];
        self.fenLeiDetailVM.dataIndex = [[paprams objectForKey:@"index"] integerValue];
    }
}

#pragma mark - lazy
- (AWFenLeiDetailViewModel *)fenLeiDetailVM {
    if (!_fenLeiDetailVM) {
        _fenLeiDetailVM = [[AWFenLeiDetailViewModel alloc] init];
    }
    return _fenLeiDetailVM;
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
