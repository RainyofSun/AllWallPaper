//
//  AWDynamicDiscoverTableViewCell.m
//  AllWallPaper
//
//  Created by macos on 2020/12/11.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "AWDynamicDiscoverTableViewCell.h"
#import "AWDynamicDiscoverViewModel.h"

@interface AWDynamicDiscoverTableViewCell ()

/** discoverVM */
@property (nonatomic,strong) AWDynamicDiscoverViewModel *discoverVM;

@end

@implementation AWDynamicDiscoverTableViewCell

- (void)dealloc {
    NSLog(@"DELLOC %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (UICollectionView *)currentDiscoverScrollView {
    return [self.discoverVM getCurrentDiscoverCollection];
}

- (void)setupDiscoverView:(CGFloat)cellH {
    if (!_discoverVM) {
        [self.discoverVM setupDiscoverView:self.contentView discoverViewH:cellH];
    }
}

#pragma mark - lazy
- (AWDynamicDiscoverViewModel *)discoverVM {
    if (!_discoverVM) {
        _discoverVM = [[AWDynamicDiscoverViewModel alloc] init];
    }
    return _discoverVM;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
