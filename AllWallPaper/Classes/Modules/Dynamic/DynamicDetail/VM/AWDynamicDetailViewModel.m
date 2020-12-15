//
//  AWDynamicDetailViewModel.m
//  AllWallPaper
//
//  Created by macos on 2020/12/15.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "AWDynamicDetailViewModel.h"
#import "AWDynamicDetailView.h"

@interface AWDynamicDetailViewModel ()<AWDynamicDetailDelegate>

/** detailView */
@property (nonatomic,strong) AWDynamicDetailView *detailView;

@end

@implementation AWDynamicDetailViewModel

- (void)dealloc {
    NSLog(@"DELLOC %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (void)loadDynamicDetailView:(UIView *)view {
    [view addSubview:self.detailView];
    self.detailView.paperDownLoadDelegate = self;
    [self.detailView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    [self.detailView loadDetailPaper:self.downLoadUrl];
}

#pragma mark - AWDynamicDetailDelegate
- (void)downloadWallPaper {
    WeakSelf;
    [FWNetworkTool downLoadWithURLString:self.downLoadUrl progerss:^(CGFloat progress) {
        // TODO 下载进度
    } success:^(NSURL * _Nonnull targetPath) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf saveImageToPhotos:[UIImage imageWithData:[NSData dataWithContentsOfURL:targetPath]]];
        });
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

#pragma mark - lazy
- (AWDynamicDetailView *)detailView {
    if (!_detailView) {
        _detailView = [[[NSBundle mainBundle] loadNibNamed:@"AWDynamicDetailView" owner:nil options:nil] firstObject];
    }
    return _detailView;
}

@end
