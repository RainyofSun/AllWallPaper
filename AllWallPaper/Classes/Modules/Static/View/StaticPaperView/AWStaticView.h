//
//  AWStaticView.h
//  AllWallPaper
//
//  Created by macos on 2020/12/14.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AWStaticModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol AWStaticPaperDelegate <NSObject>

@optional;
/// 下拉刷新
- (void)pullRefreshPage;
/// 上拉加载
- (void)dragLoadMore;
/// 选中图片
- (void)didSelectedWallPaper:(AWStaticCellModel *)paperModel;

@end

@interface AWStaticView : UIView

/** staticPaperDelegate */
@property (nonatomic,weak) id<AWStaticPaperDelegate> staticPaperDelegate;

- (void)loadStaticPaperSource:(NSArray <AWStaticCellModel *>*)paperSource;
- (void)resetStaticPaperSource:(NSArray <AWStaticCellModel *>*)paperSource;
- (void)resetFooterStatus:(MJRefreshState)status;

- (void)staticWallPaperRefresh;

@end

NS_ASSUME_NONNULL_END
