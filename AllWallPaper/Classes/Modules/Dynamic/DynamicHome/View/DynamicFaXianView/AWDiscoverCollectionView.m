//
//  AWDiscoverCollectionView.m
//  AllWallPaper
//
//  Created by macos on 2020/12/11.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "AWDiscoverCollectionView.h"
#import "AWDiscoverCollectionViewCell.h"

static NSString *WallPaperCell = @"WallPaperCell";

@interface AWDiscoverCollectionView ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

/** discoverCollectionView */
@property (nonatomic,strong) UICollectionView *discoverCollectionView;
/** dataSource */
@property (nonatomic,strong) NSArray <AWDiscoverCellModel *>*dataSource;
/** needHiddenRefreshHeader */
@property (nonatomic,assign) BOOL needAddRefreshHeader;

@end

@implementation AWDiscoverCollectionView

- (instancetype)initNeedAddRefreshHeader:(BOOL)hiddenHeader discoverCollectionFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setDefaultStatus];
        self.needAddRefreshHeader = hiddenHeader;
        [self setupCollectionView];
    }
    return self;
}

- (void)layoutSubviews {
    [self.discoverCollectionView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
}

- (void)dealloc {
    NSLog(@"DELLOC %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (void)loadWallPaperSource:(NSArray<AWDiscoverCellModel *> *)papaerSource {
    self.dataSource = papaerSource;
    [self.discoverCollectionView reloadData];
    if (self.discoverCollectionView.mj_header.refreshing) {
        [self.discoverCollectionView.mj_header endRefreshing];
    }
    if (self.discoverCollectionView.mj_footer.refreshing) {
        [self.discoverCollectionView.mj_footer endRefreshing];
    }
}

- (void)resetWallPaperSource:(NSArray<AWDiscoverCellModel *> *)paperSource {
    self.dataSource = paperSource;
}

- (void)resetFooterStatus:(MJRefreshState)status {
    if (status == MJRefreshStateNoMoreData) {
        [self.discoverCollectionView.mj_footer endRefreshingWithNoMoreData];
    }
    self.discoverCollectionView.mj_footer.state = status;
}

- (void)wallPaperStartRefresh {
    self.needAddRefreshHeader ? [self.discoverCollectionView.mj_header beginRefreshing] : [self refreshMoreData];
}

- (UICollectionView *)currentDiscoverCollectionView {
    return self.discoverCollectionView;
}

#pragma mark - 加载更多
- (void)refreshMoreData {
    FLOG(@"刷新");
    if (self.wallPaperDelegate != nil && [self.wallPaperDelegate respondsToSelector:@selector(pullRefreshPage)]) {
        [self.wallPaperDelegate pullRefreshPage];
    }
}

- (void)loadMoreData {
    FLOG(@"加载更多");
    if (self.wallPaperDelegate != nil && [self.wallPaperDelegate respondsToSelector:@selector(dragLoadMore)]) {
        [self.wallPaperDelegate dragLoadMore];
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout & UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AWDiscoverCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:WallPaperCell forIndexPath:indexPath];
    [cell resetWallPaperImg:self.dataSource[indexPath.item].smallUrl];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.wallPaperDelegate != nil && [self.wallPaperDelegate respondsToSelector:@selector(didSelectedWallPaper:)]) {
        [self.wallPaperDelegate didSelectedWallPaper:self.dataSource[indexPath.item]];
    }
}

#pragma mark - private methods
- (void)setDefaultStatus {
    self.needAddRefreshHeader = NO;
}

- (void)setupCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat W = (ScreenWidth - 32)/3;
    layout.itemSize = CGSizeMake(W, W * 2);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 8;
    layout.sectionInset = UIEdgeInsetsMake(0, 8, 0, 8);
    self.discoverCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.discoverCollectionView.backgroundColor = HexColor(0xF7F7F7);
    [self.discoverCollectionView registerNib:[UINib nibWithNibName:@"AWDiscoverCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:WallPaperCell];
    self.discoverCollectionView.dataSource = self;
    self.discoverCollectionView.delegate = self;
    self.discoverCollectionView.scrollEnabled = NO;
    self.discoverCollectionView.bounces = NO;
    [self addSubview:self.discoverCollectionView];
    [self setRefreshHeaderFooter];
}

- (void)setRefreshHeaderFooter {
    if (self.needAddRefreshHeader) {
        FWRefreshHeader *header = [FWRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshMoreData)];
        self.discoverCollectionView.mj_header = header;
    }
    FWRefreshFooter *footer = [FWRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.discoverCollectionView.mj_footer = footer;
}

@end
