//
//  AWStaticSliderBarTitleCollectionViewCell.m
//  AllWallPaper
//
//  Created by macos on 2020/12/14.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "AWStaticSliderBarTitleCollectionViewCell.h"

static CGFloat CellScaleValueMax = 1.2f;

@interface AWStaticSliderBarTitleCollectionViewCell ()

/** isSelected */
@property (nonatomic,assign) BOOL isSelected;

@end

@implementation AWStaticSliderBarTitleCollectionViewCell

- (void)dealloc {
    NSLog(@"DELLOC %@",NSStringFromClass(self.class));
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.isSelected) {
        self.transform = CGAffineTransformMakeScale(CellScaleValueMax, CellScaleValueMax);
    }else {
        self.transform = CGAffineTransformIdentity;
    }
}

//通过此父类方法配置cell是否被选中
- (void)configCellOfSelected:(BOOL)selected {
    [super configCellOfSelected:selected];
    
    self.isSelected = selected;
    
    UIColor *color = selected ? self.config.titleSelectedColor : self.config.titleNormalColor;
    [self updateSubviewsColor:color];
    
    if (selected) {
        self.transform = CGAffineTransformMakeScale(CellScaleValueMax, CellScaleValueMax);
    }else {
        self.transform = CGAffineTransformIdentity;
    }
}

- (void)showAnimationOfProgress:(CGFloat)progress type:(XLPageTitleCellAnimationType)type {
    [super showAnimationOfProgress:progress type:type];
    //动画包括颜色渐变 缩放
    if (type == XLPageTitleCellAnimationTypeSelected) {
        //第一步 颜色渐变
        UIColor *newColor = [XLPageViewControllerUtil colorTransformFrom:self.config.titleSelectedColor to:self.config.titleNormalColor progress:progress];
        [self updateSubviewsColor:newColor];
        //第二步 缩放 逐渐变小
        CGFloat scale = (1 - progress)*(CellScaleValueMax - 1);
        self.transform = CGAffineTransformMakeScale(1 + scale, 1 + scale);
    }else if (type == XLPageTitleCellAnimationTypeWillSelected){
        //第一步 颜色渐变
        UIColor *newColor = [XLPageViewControllerUtil colorTransformFrom:self.config.titleNormalColor to:self.config.titleSelectedColor progress:progress];
        [self updateSubviewsColor:newColor];
        
        //第二步 缩放 逐渐变大
        CGFloat scale = progress*(CellScaleValueMax - 1);
        self.transform = CGAffineTransformMakeScale(1 + scale, 1 + scale);
    }
}

- (void)updateSubviewsColor:(UIColor *)color {
    self.textLabel.textColor = color;
}

@end
