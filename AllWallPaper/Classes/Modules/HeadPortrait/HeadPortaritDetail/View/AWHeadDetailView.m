//
//  AWHeadDetailView.m
//  AllWallPaper
//
//  Created by macos on 2020/12/15.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "AWHeadDetailView.h"
#import "AWDiscoverCollectionViewCell.h"

static NSString *HeadWallPaperCell = @"WallPaperCell";

@interface AWHeadDetailView ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

/** collectionView */
@property (nonatomic,strong) UICollectionView *collectionView;
/** dataSource */
@property (nonatomic,strong) NSArray <AWStaticCellModel *>*dataSource;

@end

@implementation AWHeadDetailView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupHeadCollectionView];
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
- (void)loadHeadDetailPaperSource:(NSArray<AWStaticCellModel *> *)paperSource {
    self.dataSource = paperSource;
    [self.collectionView reloadData];
    if ([self.collectionView.mj_header isRefreshing]) {
        [self.collectionView.mj_header endRefreshing];
    }
    if ([self.collectionView.mj_footer isRefreshing]) {
        [self.collectionView.mj_footer endRefreshing];
    }
}

- (void)resetFooterStatus:(MJRefreshState)status {
    if (status == MJRefreshStateNoMoreData) {
        [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        self.collectionView.mj_footer.hidden = YES;
    }
    self.collectionView.mj_footer.state = status;
}

- (void)headWallPaperRefresh {
    [self.collectionView.mj_header beginRefreshing];
}

#pragma mark - 刷新
- (void)refreshData {
    if (self.headDelegate != nil && [self.headDelegate respondsToSelector:@selector(pullRefreshPage)]) {
        [self.headDelegate pullRefreshPage];
    }
}

- (void)loadMore {
    if (self.headDelegate != nil && [self.headDelegate respondsToSelector:@selector(dragLoadMore)]) {
        [self.headDelegate dragLoadMore];
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout & UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AWDiscoverCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HeadWallPaperCell forIndexPath:indexPath];
    [cell resetWallPaperImg:self.dataSource[indexPath.item].imageUrlSmall];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.headDelegate != nil && [self.headDelegate respondsToSelector:@selector(didSelectedHeadWallPaper:)]) {
        [self.headDelegate didSelectedHeadWallPaper:self.dataSource[indexPath.row]];
    }
}

#pragma mark - private methods
- (void)setupHeadCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat W = (ScreenWidth - 24)/2;
    layout.itemSize = CGSizeMake(W, W);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 8;
    layout.sectionInset = UIEdgeInsetsMake(0, 8, 0, 8);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.backgroundColor = HexColor(0xF7F7F7);
    [self.collectionView registerNib:[UINib nibWithNibName:@"AWDiscoverCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:HeadWallPaperCell];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self addSubview:self.collectionView];
    [self addRefreshHeaderAndFooter];
}

- (void)addRefreshHeaderAndFooter {
    FWRefreshHeader *header = [FWRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    self.collectionView.mj_header = header;
    FWRefreshFooter *footer = [FWRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    self.collectionView.mj_footer = footer;
}

@end
