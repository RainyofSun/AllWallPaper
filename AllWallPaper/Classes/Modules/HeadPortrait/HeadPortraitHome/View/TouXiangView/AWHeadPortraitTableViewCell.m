//
//  AWHeadPortraitTableViewCell.m
//  AllWallPaper
//
//  Created by macos on 2020/12/14.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "AWHeadPortraitTableViewCell.h"

@interface AWHeadPortraitTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *typeLab;
@property (weak, nonatomic) IBOutlet UIButton *leftImgBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightImgBtn;

/** cellSource */
@property (nonatomic,strong) NSArray <AWHeadGroupModel *>*cellSource;

@end

@implementation AWHeadPortraitTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.leftImgBtn.layer.cornerRadius = self.rightImgBtn.layer.cornerRadius = 5.f;
    self.leftImgBtn.clipsToBounds = self.rightImgBtn.clipsToBounds = YES;
}

- (void)dealloc {
    NSLog(@"DELLOC %@",NSStringFromClass(self.class));
}

- (void)loadHeadPortraitCellModel:(NSArray<AWHeadGroupModel *> *)modelSource typeName:(NSString *)name {
    self.typeLab.text = name;
    [self.leftImgBtn loadBackgroudNetworkImg:modelSource.firstObject.imageUrlSmall bigPlaceHolder:NO];
    [self.rightImgBtn loadBackgroudNetworkImg:modelSource.lastObject.imageUrlSmall bigPlaceHolder:NO];
//    self.leftImgBtn.contentMode = self.rightImgBtn.contentMode = UIViewContentModeScaleAspectFill;
    self.cellSource = modelSource;
}

- (IBAction)showMore:(UIButton *)sender {

}

- (IBAction)touchImg:(UIButton *)sender {

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
