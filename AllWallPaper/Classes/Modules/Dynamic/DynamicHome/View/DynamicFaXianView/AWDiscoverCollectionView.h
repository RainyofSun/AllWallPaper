//
//  AWDiscoverCollectionView.h
//  AllWallPaper
//
//  Created by macos on 2020/12/11.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AWDiscoverModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol AWDiscoverViewDelegate <NSObject>

@optional;
/// 下拉刷新
- (void)pullRefreshPage;
/// 上拉加载
- (void)dragLoadMore;
/// 选中图片
- (void)didSelectedWallPaper:(AWDiscoverCellModel *)paperModel;

@end

@interface AWDiscoverCollectionView : UIView

/** wallPaperDelegate */
@property (nonatomic,weak) id<AWDiscoverViewDelegate> wallPaperDelegate;

- (void)loadWallPaperSource:(NSArray <AWDiscoverCellModel *>*)papaerSource;
- (void)resetWallPaperSource:(NSArray <AWDiscoverCellModel *>*)paperSource;
- (void)resetFooterStatus:(MJRefreshState)status;

- (void)wallPaperStartRefresh;

- (UICollectionView *)currentDiscoverCollectionView;

@end

NS_ASSUME_NONNULL_END
