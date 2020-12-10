//
//  AppPageControl.h
//  XiaoYeMa
//
//  Created by EGLS_BMAC on 2019/12/19.
//  Copyright © 2019 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger,AppPageHorizontalControlType){
    PageControlHorizontalMiddle = 0, //
    PageControlHorizontalRight, //
    PageControlHorizontalLeft, //
};

typedef NS_ENUM(NSUInteger,AppPageVerticalControlType) {
    PageControlVerticalUp,
    PageControlVerticalMid,
    PageControlVerticalBottom,
};

@class AppPageControl;
@protocol AppPageControlDelegate <NSObject>

@optional
-(void)app_PageControlClick:(AppPageControl*)pageControl index:(NSInteger)clickIndex;

@end
@interface AppPageControl : UIControl

//其他点是高度的倍数,默认1
@property(nonatomic) NSInteger otherMultiple;
//当前点h是高度的倍数,默认2
@property(nonatomic) NSInteger currentMultiple;


/**
 控件水平位置,默认中间
 */
@property (nonatomic, assign)   AppPageHorizontalControlType horizontalType;
/**
 控件垂直位置,默认中间
 */
@property (nonatomic, assign)   AppPageVerticalControlType verticalType;
/*
 分页数量
 */
@property(nonatomic) NSInteger numberOfPages;
/*
 当前点所在下标
 */
@property(nonatomic) NSInteger currentPage;
/*
 点的大小
 */
@property(nonatomic) NSInteger controlSize;
/*
 点的间距
 */
@property(nonatomic) NSInteger controlSpacing;
/*
 其他未选中点颜色
 */
@property(nonatomic,strong) UIColor *otherColor;
/*
 当前点颜色
 */
@property(nonatomic,strong) UIColor *currentColor;
/*
 当前点背景图片
 */
@property(nonatomic,strong) UIImage *currentBkImg;

/*
 其他点背景图片
 */
@property(nonatomic,strong) UIImage *otherBkImg;

@property(nonatomic,weak)  id<AppPageControlDelegate > delegate;

@end

NS_ASSUME_NONNULL_END
