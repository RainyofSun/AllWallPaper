//
//  AppCycleCollectionViewCell.h
//  LibTools
//
//  Created by 刘冉 on 2018/10/17.
//  Copyright © 2018年 LRCY. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppCycleCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,assign) CGFloat imgCornerRadius;
@property (nonatomic,strong) UIView *bottomView;
@property (nonatomic,strong) UILabel *bannerText;
@property (nonatomic,strong) UIButton *bannerBtn;

/** cell的占位图，用于网络未加载到图片时*/
@property (nonatomic,strong) UIImage *cellPlaceholderImage;

@end

NS_ASSUME_NONNULL_END
