//
//  AWDynamicDetailView.m
//  AllWallPaper
//
//  Created by macos on 2020/12/15.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "AWDynamicDetailView.h"

@interface AWDynamicDetailView ()

@property (weak, nonatomic) IBOutlet UIImageView *backgroudImgView;
@property (weak, nonatomic) IBOutlet UIButton *downloadBtn;

@end

@implementation AWDynamicDetailView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.downloadBtn.layer.cornerRadius = CGRectGetHeight(self.downloadBtn.bounds)/2;
    self.downloadBtn.clipsToBounds = YES;
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (void)loadDetailPaper:(NSString *)paperUrl {
    [self.backgroudImgView loadNetworkImg:paperUrl bigPlaceHolder:YES];
}

#pragma mark - Target
- (IBAction)clickDownloadBtn:(UIButton *)sender {
    if (self.paperDownLoadDelegate != nil && [self.paperDownLoadDelegate respondsToSelector:@selector(downloadWallPaper)]) {
        [self.paperDownLoadDelegate downloadWallPaper];
    }
}

- (IBAction)clickBackBtn:(UIButton *)sender {
    [[self nearsetViewController].navigationController popViewControllerAnimated:YES];
}

@end
