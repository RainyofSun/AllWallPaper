//
//  AppCycleCollectionViewCell.m
//  LibTools
//
//  Created by 刘冉 on 2018/10/17.
//  Copyright © 2018年 LRCY. All rights reserved.
//

#import "AppCycleCollectionViewCell.h"

@implementation AppCycleCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        [self setupUI];
//        [self setSubviewsFrame];
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    self.imageView.frame = self.bounds;
    self.imageView.image = self.cellPlaceholderImage;
    self.imageView.layer.cornerRadius = self.imgCornerRadius;
    self.imageView.clipsToBounds = YES;
//    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.imageView.bounds cornerRadius:self.imgCornerRadius];
//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//    //设置大小
//    maskLayer.frame = self.bounds;
//
//    //设置图形样子
//    maskLayer.path = maskPath.CGPath;
//    _imageView.layer.mask = maskLayer;
//
//    self.bottomView.layer.cornerRadius = self.imgCornerRadius;
//    self.bottomView.clipsToBounds = YES;
}

- (void)setupUI {
//
//    self.bottomView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
//
//    [self.bannerBtn setImage:[UIImage imageNamed:@"loopEnter"] forState:UIControlStateNormal];
//    self.bannerText.font = [UIFont systemFontOfSize:15];
//    self.bannerText.textColor = [UIColor whiteColor];
    self.backgroundColor = self.contentView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.imageView];
//    [self.bottomView addSubview:self.bannerText];
//    [self.bottomView addSubview:self.bannerBtn];
//    [self.contentView addSubview:self.bottomView];
}

- (void)setSubviewsFrame {
    [self.bottomView autoAlignAxis:ALAxisVertical toSameAxisOfView:self.contentView];
    [self.bottomView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.contentView];
    [self.bottomView autoSetDimensionsToSize:CGSizeMake(CGRectGetWidth(self.contentView.frame), 30)];
    
    [self.bannerText autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.bottomView withOffset:8];
    [self.bannerText autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.bottomView];
    [self.bannerText autoSetDimension:ALDimensionWidth toSize:CGRectGetWidth(self.contentView.frame)/3*2];
    
    [self.bannerBtn autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.bottomView withOffset:-8];
    [self.bannerBtn autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.bottomView];
    
}

-(UIImageView *)imageView {
    if(_imageView == nil) {
        _imageView = [[UIImageView alloc]init];
    }
    return _imageView;
}

-(UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
    }
    return _bottomView;
}

- (UILabel *)bannerText {
    if (!_bannerText) {
        _bannerText = [[UILabel alloc] init];
    }
    return _bannerText;
}

- (UIButton *)bannerBtn {
    if (!_bannerBtn) {
        _bannerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _bannerBtn;
}

@end
