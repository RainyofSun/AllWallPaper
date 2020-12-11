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

@interface AWDiscoverCollectionView ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UIScrollViewDelegate>

/** discoverCollectionView */
@property (nonatomic,strong) UICollectionView *discoverCollectionView;
/** dataSource */
@property (nonatomic,strong) NSArray <AWDiscoverCellModel *>*dataSource;
/** canScroll */
@property (nonatomic,assign) BOOL canScroll;

@end

@implementation AWDiscoverCollectionView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setDefaultStatus];
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
    [self refreshMoreData];
}

#pragma mark - 加载更多
- (void)refreshMoreData {
    NSLog(@"刷新");
    if (self.wallPaperDelegate != nil && [self.wallPaperDelegate respondsToSelector:@selector(pullRefreshPage)]) {
        [self.wallPaperDelegate pullRefreshPage];
    }
}

- (void)loadMoreData {
    NSLog(@"加载更多");
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

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.canScroll = (scrollView.contentOffset.y == 0);
    self.discoverCollectionView.scrollEnabled = !self.canScroll;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"subGetTop" object:[NSNumber numberWithBool:self.canScroll]];
}

#pragma mark - private methods
- (void)setDefaultStatus {
    self.canScroll = NO;
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
    self.discoverCollectionView.scrollEnabled = self.canScroll;
    self.discoverCollectionView.bounces = NO;
    [self addSubview:self.discoverCollectionView];
    [self setRefreshHeaderFooter];
}

- (void)setRefreshHeaderFooter {
    FWRefreshFooter *footer = [FWRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.discoverCollectionView.mj_footer = footer;
}

@end
