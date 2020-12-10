//
//  AppCycleScrollview.h
//  LibTools
//
//  Created by 刘冉 on 2018/10/17.
//  Copyright © 2018年 LRCY. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class AppCycleScrollview;
@protocol AppCycleScrollviewDelegate <NSObject>

/** 点击图片回调 */
- (void)cycleScrollView:(AppCycleScrollview *)cycleScrollView didSelectItemAtIndex:(NSInteger)index;

@end

@interface AppCycleScrollview : UIView

//*是否无线循环，默认yes
@property (nonatomic,assign) BOOL infiniteLoop;
//*是否自动滑动，默认yes
@property (nonatomic,assign) BOOL autoScroll;
/**是否缩放，默认不缩放*/
@property (nonatomic,assign) BOOL isZoom;
/** 是否显示pageControl */
@property (nonatomic,assign) BOOL isHidePageControl;
//*自动滚动间隔时间，默认2s
@property (nonatomic,assign) CGFloat autoScrollTimeInterval;
//cell宽度
@property (nonatomic,assign) CGFloat itemWidth;
//cell间距
@property (nonatomic,assign) CGFloat itemSpace;
//imagView圆角，默认为0；
@property (nonatomic,assign) CGFloat imgCornerRadius;
/** 图片与整体的高度比例 默认0.8 */
@property (nonatomic,assign) CGFloat heightProportion;
/** 占位图，用于网络未加载到图片时 */
@property (nonatomic, strong) UIImage *placeholderImage;
/** cell的占位图，用于网络未加载到图片时*/
@property (nonatomic,strong) UIImage *cellPlaceholderImage;
//代理方法
@property (nonatomic,weak) id<AppCycleScrollviewDelegate> delegate;
/** imgDataSource */
@property (nonatomic,strong) NSArray <NSString *> *imageURLStringsGroup;

//初始化方法
+(instancetype)appCycleScrollViewWithFrame:(CGRect)frame shouldInfiniteLoop:(BOOL)infiniteLoop cycleDelegate:(id<AppCycleScrollviewDelegate>)delegate;
- (void)invalidateTimer;

@end

NS_ASSUME_NONNULL_END
