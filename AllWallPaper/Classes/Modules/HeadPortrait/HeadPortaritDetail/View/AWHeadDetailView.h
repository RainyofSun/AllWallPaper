//
//  AWHeadDetailView.h
//  AllWallPaper
//
//  Created by macos on 2020/12/15.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AWStaticModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol AWHeadDetailDelegate <NSObject>

@optional;
/// 下拉刷新
- (void)pullRefreshPage;
/// 上拉加载
- (void)dragLoadMore;
/// 选中图片
- (void)didSelectedHeadWallPaper:(AWStaticCellModel *)paperModel;

@end

@interface AWHeadDetailView : UIView

/** headDelegate */
@property (nonatomic,weak) id<AWHeadDetailDelegate> headDelegate;

- (void)loadHeadDetailPaperSource:(NSArray <AWStaticCellModel *>*)paperSource;

- (void)headWallPaperRefresh;
- (void)resetFooterStatus:(MJRefreshState)status;

@end

NS_ASSUME_NONNULL_END
