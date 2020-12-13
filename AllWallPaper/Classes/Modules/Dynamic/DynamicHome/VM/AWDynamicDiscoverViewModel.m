//
//  AWDynamicDiscoverViewModel.m
//  AllWallPaper
//
//  Created by macos on 2020/12/11.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "AWDynamicDiscoverViewModel.h"
#import "AWDynamicDiscoverView.h"
#import "AWDiscoverDataTool.h"
#import "AWDiscoverCollectionView.h"

@interface AWDynamicDiscoverViewModel ()<AWDynamicDiscoverDelegate,AWDiscoverViewDelegate>

/** discoverView */
@property (nonatomic,strong) AWDynamicDiscoverView *discoverView;
/** dataTool */
@property (nonatomic,strong) AWDiscoverDataTool *dataTool;
/** selectedIndex */
@property (nonatomic,assign) NSInteger selectedIndex;
/** paperViewDict */
@property (nonatomic,strong) NSMutableDictionary *paperViewDict;
/** totalSource */
@property (nonatomic,strong) NSMutableDictionary *totalSource;
/** recordLoadPage */
@property (nonatomic,strong) NSMutableDictionary *recordLoadPage;
/** localSource */
@property (nonatomic,strong) NSMutableArray <AWDiscoverCellModel *>*localSource;
/** collectionH */
@property (nonatomic,assign) CGFloat collectionH;
/** getDataInCache */
@property (nonatomic,assign) BOOL getDataInCache;

@end

@implementation AWDynamicDiscoverViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setDefaultData];
    }
    return self;
}

- (void)dealloc {
    for (AWDynamicDiscoverView *tempView in self.paperViewDict.allValues) {
        tempView.discoverDelegate = nil;
        [tempView removeFromSuperview];
    }
    [self.paperViewDict removeAllObjects];
    NSLog(@"DELLOC %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (void)setupDiscoverView:(UIView *)view discoverViewH:(CGFloat)viewH {
    self.collectionH = viewH;
    self.discoverView.discoverDelegate = self;
    [view addSubview:self.discoverView];
    [self.discoverView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    [self.discoverView loadTopSliderTitles:[self.dataTool discoverTopSliderBarTitle]];
    AWDiscoverCollectionView *firstView = [self createSubView:self.selectedIndex];
    [self.discoverView addFirstDiscoverView:firstView];
    [firstView wallPaperStartRefresh];
}

- (UICollectionView *)getCurrentDiscoverCollection {
    AWDiscoverCollectionView *tempCollectionView = (AWDiscoverCollectionView *)[self.paperViewDict objectForKey:[NSString stringWithFormat:@"%ld",(long)self.selectedIndex]];
    return [tempCollectionView currentDiscoverCollectionView];
}

#pragma mark - AWDynamicDiscoverDelegate
- (UIView *)addNewDiscoverView:(NSInteger)scrollIndex {
    // 页面滑动删除数据源，防止数据混乱
    self.getDataInCache = NO;
    [self.localSource removeAllObjects];
    self.selectedIndex = scrollIndex;
    AWDiscoverCollectionView *discoverView = [self createSubView:scrollIndex];
    [discoverView wallPaperStartRefresh];
    FLOG(@"切换到新创建的");
    return discoverView;
}

- (void)reloadOldDiscoverViewData:(NSInteger)scrollIndex {
    // 页面滑动删除数据源，防止数据混乱
    [self.localSource removeAllObjects];
    self.selectedIndex = scrollIndex;
    NSArray <AWDiscoverCellModel *>* cacheSource = [self.totalSource objectForKey:[NSString stringWithFormat:@"%ld",(long)self.selectedIndex]];
    if (cacheSource.count) {
        self.getDataInCache = YES;
        // 滑动至已创建的页面,从缓存中取出数据和已加载的页数
        [self.localSource addObjectsFromArray:cacheSource];
        NSDictionary *tempDict = (NSDictionary *)[self.recordLoadPage objectForKey:[NSString stringWithFormat:@"%ld",(long)self.selectedIndex]];
        [self.dataTool removeLocalCache];
        self.dataTool.page = [[tempDict objectForKey:@"page"] integerValue];
        self.dataTool.isResetNoMoreData = [[tempDict objectForKey:@"isNoMore"] boolValue];
        AWDiscoverCollectionView *tempView = (AWDiscoverCollectionView *)[self.paperViewDict valueForKey:[NSString stringWithFormat:@"%ld",(long)self.selectedIndex]];
        ![[tempDict objectForKey:@"isNoMore"] boolValue] ? [tempView resetFooterStatus:MJRefreshStateIdle] : nil;
        [tempView resetWallPaperSource:self.localSource];
        FLOG(@"切换到已缓存的 缓存page %ld",(long)self.dataTool.page);
    }
}

#pragma mark - AWDiscoverViewDelegate
- (void)pullRefreshPage {
    [self requestLocalData:AWLoadingType_Normal];
}

- (void)dragLoadMore {
    [self requestLocalData:AWLoadingType_More];
}

- (void)didSelectedWallPaper:(AWDiscoverCellModel *)paperModel {
    NSLog(@"page %@",paperModel);
}

#pragma mark - private methods
- (void)setDefaultData {
    self.selectedIndex = 0;
    self.getDataInCache = NO;
}

- (void)requestLocalData:(AWLoadingType)loadType {
    WeakSelf;
    [self.dataTool requestLocalPaperData:self.selectedIndex dataBlock:^(id  _Nonnull responseObject, BOOL isNoMoreData) {
        !weakSelf.getDataInCache ? [weakSelf.localSource removeAllObjects] : nil;
        [weakSelf.localSource addObjectsFromArray:(NSArray <AWDiscoverCellModel *>*)responseObject];
        // 数据更新时，同时更新数据缓存中的数据和已加载的页数
        [weakSelf.totalSource setValue:[weakSelf.localSource copy] forKey:[NSString stringWithFormat:@"%ld",(long)weakSelf.selectedIndex]];
        NSDictionary *tempDict = @{@"page":[@(weakSelf.dataTool.page) copy],@"isNoMore":@(isNoMoreData)};
        [weakSelf.recordLoadPage setValue:tempDict forKey:[NSString stringWithFormat:@"%ld",(long)weakSelf.selectedIndex]];
        AWDiscoverCollectionView *tempView = (AWDiscoverCollectionView *)[self.paperViewDict valueForKey:[NSString stringWithFormat:@"%ld",(long)weakSelf.selectedIndex]];
        [tempView loadWallPaperSource:weakSelf.localSource];
        isNoMoreData ? [tempView resetFooterStatus:MJRefreshStateNoMoreData] : nil;
        isNoMoreData ? [MBHUDToastManager showBriefAlert:@"没有更多数据了"] : nil;
    } loadingDataType:loadType];
}

- (AWDiscoverCollectionView *)createSubView:(NSInteger)index {
    CGRect discoverFrame = CGRectMake(index * ScreenWidth, 0, ScreenWidth, (self.collectionH - [self.discoverView discoverTopbarHight]));
    AWDiscoverCollectionView *discoverView = [[AWDiscoverCollectionView alloc] initNeedAddRefreshHeader:NO discoverCollectionFrame:discoverFrame];
    discoverView.wallPaperDelegate = self;
    [self.paperViewDict setValue:discoverView forKey:[NSString stringWithFormat:@"%ld",(long)index]];
    return discoverView;
}

#pragma mark - lazy
- (AWDynamicDiscoverView *)discoverView {
    if (!_discoverView) {
        _discoverView = [[AWDynamicDiscoverView alloc] init];
    }
    return _discoverView;
}

- (AWDiscoverDataTool *)dataTool {
    if (!_dataTool) {
        _dataTool = [[AWDiscoverDataTool alloc] init];
    }
    return _dataTool;
}

- (NSMutableDictionary *)paperViewDict {
    if (!_paperViewDict) {
        _paperViewDict = [NSMutableDictionary dictionary];
    }
    return _paperViewDict;
}

- (NSMutableArray<AWDiscoverCellModel *> *)localSource {
    if (!_localSource) {
        _localSource = [NSMutableArray array];
    }
    return _localSource;
}

- (NSMutableDictionary *)totalSource {
    if (!_totalSource) {
        _totalSource = [NSMutableDictionary dictionary];
    }
    return _totalSource;
}

- (NSMutableDictionary *)recordLoadPage {
    if (!_recordLoadPage) {
        _recordLoadPage = [NSMutableDictionary dictionary];
    }
    return _recordLoadPage;
}

@end
