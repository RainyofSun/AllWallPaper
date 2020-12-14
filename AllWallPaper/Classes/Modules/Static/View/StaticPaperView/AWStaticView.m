//
//  AWStaticView.m
//  AllWallPaper
//
//  Created by macos on 2020/12/14.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "AWStaticView.h"
#import "AWDiscoverCollectionViewCell.h"

static NSString *StaticWallPaperCell = @"WallPaperCell";

@interface AWStaticView ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

/** collectionView */
@property (nonatomic,strong) UICollectionView *collectionView;
/** dataSurce */
@property (nonatomic,strong) NSArray <AWStaticCellModel *>*dataSource;

@end

@implementation AWStaticView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupUI];
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
- (void)loadStaticPaperSource:(NSArray<AWStaticCellModel *> *)paperSource {
    self.dataSource = paperSource;
    [self.collectionView reloadData];
    if ([self.collectionView.mj_header isRefreshing]) {
        [self.collectionView.mj_header endRefreshing];
    }
    if ([self.collectionView.mj_footer isRefreshing]) {
        [self.collectionView.mj_footer endRefreshing];
    }
}

- (void)resetStaticPaperSource:(NSArray<AWStaticCellModel *> *)paperSource {
    self.dataSource = paperSource;
}

- (void)resetFooterStatus:(MJRefreshState)status {
    if (status == MJRefreshStateNoMoreData) {
        [self.collectionView.mj_footer endRefreshingWithNoMoreData];
    }
    self.collectionView.mj_footer.hidden = status == MJRefreshStateNoMoreData ? YES : NO;
    self.collectionView.mj_footer.state = status;
}

- (void)staticWallPaperRefresh {
    [self.collectionView.mj_header beginRefreshing];
}

#pragma mark - 刷新
- (void)refreshMoreData {
    NSLog(@"刷新");
    if (self.staticPaperDelegate != nil && [self.staticPaperDelegate respondsToSelector:@selector(pullRefreshPage)]) {
        self.collectionView.mj_footer.state = MJRefreshStateIdle;
        self.collectionView.mj_footer.hidden = NO;
        [self.staticPaperDelegate pullRefreshPage];
    }
}

- (void)loadMoreData {
    NSLog(@"加载更多");
    if (self.staticPaperDelegate != nil && [self.staticPaperDelegate respondsToSelector:@selector(dragLoadMore)]) {
        [self.staticPaperDelegate dragLoadMore];
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout & UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AWDiscoverCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:StaticWallPaperCell forIndexPath:indexPath];
    [cell resetWallPaperImg:self.dataSource[indexPath.item].imageUrlSmall];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.staticPaperDelegate != nil && [self.staticPaperDelegate respondsToSelector:@selector(didSelectedWallPaper:)]) {
        [self.staticPaperDelegate didSelectedWallPaper:self.dataSource[indexPath.item]];
    }
}

#pragma mark - private methods
- (void)setupUI {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat W = (ScreenWidth - 24)/2;
    layout.itemSize = CGSizeMake(W, W * 2);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 8;
    layout.sectionInset = UIEdgeInsetsMake(0, 8, 0, 8);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.backgroundColor = HexColor(0xF7F7F7);
    [self.collectionView registerNib:[UINib nibWithNibName:@"AWDiscoverCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:StaticWallPaperCell];
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
