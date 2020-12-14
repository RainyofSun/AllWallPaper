//
//  AWFenLeiDetailView.m
//  AllWallPaper
//
//  Created by macos on 2020/12/14.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "AWFenLeiDetailView.h"
#import "AWDiscoverCollectionViewCell.h"

static NSString *WallPaperCell = @"WallPaperCell";

@interface AWFenLeiDetailView ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

/** collectionView */
@property (nonatomic,strong) UICollectionView *collectionView;
/** dataSource */
@property (nonatomic,strong) NSArray <AWDiscoverCellModel *>*dataSource;

@end

@implementation AWFenLeiDetailView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupCollectionView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.collectionView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
}

- (void)dealloc {
    NSLog(@"DELLOC %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (void)loadFenLeiWallPaperSource:(NSArray<AWDiscoverCellModel *> *)papaerSource {
    self.dataSource = papaerSource;
    [self.collectionView reloadData];
    if (self.collectionView.mj_header.refreshing) {
        [self.collectionView.mj_header endRefreshing];
    }
    if (self.collectionView.mj_footer.refreshing) {
        [self.collectionView.mj_footer endRefreshing];
    }
}

- (void)wallPaperStartRefresh {
    [self.collectionView.mj_header beginRefreshing];
}

- (void)resetFooterStatus:(MJRefreshState)status {
    if (status == MJRefreshStateNoMoreData) {
        [self.collectionView.mj_footer endRefreshingWithNoMoreData];
    }
    self.collectionView.mj_footer.hidden = status == MJRefreshStateNoMoreData ? YES : NO;
    self.collectionView.mj_footer.state = status;
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
- (void)setupCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat W = (ScreenWidth - 32)/3;
    layout.itemSize = CGSizeMake(W, W * 1.5);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 8;
    layout.sectionInset = UIEdgeInsetsMake(0, 8, 0, 8);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.backgroundColor = HexColor(0xF7F7F7);
    [self.collectionView registerNib:[UINib nibWithNibName:@"AWDiscoverCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:WallPaperCell];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self addSubview:self.collectionView];
    [self setRefreshHeaderFooter];
}

- (void)setRefreshHeaderFooter {
    FWRefreshHeader *header = [FWRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshMoreData)];
    self.collectionView.mj_header = header;
    FWRefreshFooter *footer = [FWRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.collectionView.mj_footer = footer;
}

@end
