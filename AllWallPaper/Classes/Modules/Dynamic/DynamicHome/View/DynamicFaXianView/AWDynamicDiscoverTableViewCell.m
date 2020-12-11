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

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupDiscoverView];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"DELLOC %@",NSStringFromClass(self.class));
}

#pragma mark - public methods

#pragma mark - private methods
- (void)setupDiscoverView {
    [self.discoverVM setupDiscoverView:self.contentView];
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
