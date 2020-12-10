//
//  AWDynamicSectionHeaderView.m
//  AllWallPaper
//
//  Created by macos on 2020/12/10.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "AWDynamicSectionHeaderView.h"

@interface AWDynamicSectionHeaderView ()

@property (weak, nonatomic) IBOutlet UILabel *sectionTitleLab;
/** sectionH */
@property (nonatomic,assign,readwrite) CGFloat sectionH;

@end

@implementation AWDynamicSectionHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.sectionH = CGRectGetHeight(self.bounds);
}

- (void)dealloc {
    NSLog(@"DELLOC %@",NSStringFromClass(self.class));
}

- (void)reloadSectionTitle:(NSString *)title {
    self.sectionTitleLab.text = title;
}

@end
