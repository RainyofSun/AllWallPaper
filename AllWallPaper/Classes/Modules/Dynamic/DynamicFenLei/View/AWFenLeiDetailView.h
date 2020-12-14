//
//  AWFenLeiDetailView.h
//  AllWallPaper
//
//  Created by macos on 2020/12/14.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AWDiscoverModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol AWFenLeiDetailViewDelegate <NSObject>

@optional;
/// 下拉刷新
- (void)pullRefreshPage;
/// 上拉加载
- (void)dragLoadMore;
/// 选中图片
- (void)didSelectedWallPaper:(AWDiscoverCellModel *)paperModel;

@end

@interface AWFenLeiDetailView : UIView

/** wallPaperDelegate */
@property (nonatomic,weak) id<AWFenLeiDetailViewDelegate> wallPaperDelegate;

- (void)loadFenLeiWallPaperSource:(NSArray <AWDiscoverCellModel *>*)papaerSource;

- (void)resetFooterStatus:(MJRefreshState)status;
- (void)wallPaperStartRefresh;

@end

NS_ASSUME_NONNULL_END
