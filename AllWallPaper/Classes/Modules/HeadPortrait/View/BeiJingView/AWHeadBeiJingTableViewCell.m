//
//  AWHeadBeiJingTableViewCell.m
//  AllWallPaper
//
//  Created by macos on 2020/12/14.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "AWHeadBeiJingTableViewCell.h"

@interface AWHeadBeiJingTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *beiJingImgView;

@end

@implementation AWHeadBeiJingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.beiJingImgView.layer.cornerRadius = 5.f;
    self.beiJingImgView.clipsToBounds = YES;
}

- (void)dealloc {
    NSLog(@"DELLOC %@",NSStringFromClass(self.class));
}

- (void)loadHeadBeiJingCellSource:(NSArray<AWHeadGroupModel *> *)cellSource {
    [self.beiJingImgView loadNetworkImg:cellSource.firstObject.imageUrlSmall bigPlaceHolder:NO];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
