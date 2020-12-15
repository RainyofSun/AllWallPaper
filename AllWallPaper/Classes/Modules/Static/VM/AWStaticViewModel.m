//
//  AWStaticViewModel.m
//  AllWallPaper
//
//  Created by macos on 2020/12/14.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "AWStaticViewModel.h"
#import "AWStaticSliderBarTitleCollectionViewCell.h"
#import "AWStaticPapgeSubViewController.h"
#import "AWStaticView.h"
#import "AWStaticLocalDataTool.h"

static NSString *StaticTopSliderBarIndifier = @"StaticTopSliderBarIndifier";

@interface AWStaticViewModel ()<XLPageViewControllerDelegate,XLPageViewControllerDataSrouce,AWStaticPaperDelegate>

/** pageControlView */
@property (nonatomic,strong) XLPageViewController *pageControlView;
/** localDataTool */
@property (nonatomic,strong) AWStaticLocalDataTool *localDataTool;
/** selectedItemIndex */
@property (nonatomic,assign) NSInteger selectedItemIndex;
/** titleArray */
@property (nonatomic,strong) NSArray <NSString *>*titleArray;
/** paperViewDict */
@property (nonatomic,strong) NSMutableDictionary *paperViewDict;
/** localSource */
@property (nonatomic,strong) NSMutableArray <AWStaticCellModel *>*localSource;
/** totalSource */
@property (nonatomic,strong) NSMutableDictionary *totalSource;
/** recordLoadPage */
@property (nonatomic,strong) NSMutableDictionary *recordLoadPage;
/** getDataInCache */
@property (nonatomic,assign) BOOL getDataInCache;

@end

@implementation AWStaticViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setDefaultData];
    }
    return self;
}

- (void)dealloc {
    for (AWStaticView *view in self.paperViewDict.allValues) {
        view.staticPaperDelegate = nil;
        [view removeFromSuperview];
    }
    [self.paperViewDict removeAllObjects];
    NSLog(@"DELLOC %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (void)loadStaticView:(UIViewController *)vc {
    [vc addChildViewController:self.pageControlView];
    [vc.view addSubview:self.pageControlView.view];
    [self.pageControlView.view autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
    [self.pageControlView.view autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:vc.view withOffset:kStatusBarHeight];
    self.pageControlView.delegate = self;
    self.pageControlView.dataSource = self;
    [self.pageControlView registerClass:[AWStaticSliderBarTitleCollectionViewCell class] forTitleViewCellWithReuseIdentifier:StaticTopSliderBarIndifier];
    self.pageControlView.selectedIndex = self.selectedItemIndex;
    [self.paperViewDict.allValues.firstObject staticWallPaperRefresh];
}

#pragma mark - XLPageViewControllerDelegate & XLPageViewControllerDataSource
- (UIViewController *)pageViewController:(XLPageViewController *)pageViewController viewControllerForIndex:(NSInteger)index {
    AWStaticPapgeSubViewController *subVC = [[AWStaticPapgeSubViewController alloc] initWithNibName:@"AWStaticPapgeSubViewController" bundle:nil];
    [subVC addStaticSubView:[self createWallPaperView:index]];
    return subVC;
}

- (NSString *)pageViewController:(XLPageViewController *)pageViewController titleForIndex:(NSInteger)index {
    return self.titleArray[index];
}

- (NSInteger)pageViewControllerNumberOfPage {
    return self.titleArray.count;
}

- (XLPageTitleCell *)pageViewController:(XLPageViewController *)pageViewController titleViewCellForItemAtIndex:(NSInteger)index {
    AWStaticSliderBarTitleCollectionViewCell *cell = [pageViewController dequeueReusableTitleViewCellWithIdentifier:StaticTopSliderBarIndifier forIndex:index];
    return cell;
}

- (void)pageViewController:(XLPageViewController *)pageViewController didSelectedAtIndex:(NSInteger)index {
    // 页面滑动即删除数据源
    [self.localSource removeAllObjects];
    self.selectedItemIndex = index;
    NSArray <AWStaticCellModel *>* cacheSource = [self.totalSource objectForKey:[NSString stringWithFormat:@"%ld",(long)self.selectedItemIndex]];
    if (cacheSource.count) {
        // 滑动已创建的页面,从缓存中取出数据和已加载的页数
        [self.localSource addObjectsFromArray:cacheSource];
        NSDictionary *tempDict = (NSDictionary *)[self.recordLoadPage objectForKey:[NSString stringWithFormat:@"%ld",(long)self.selectedItemIndex]];
        [self.localDataTool removeLocalCache];
        self.localDataTool.page = [[tempDict objectForKey:@"page"] integerValue];
        self.localDataTool.isResetNoMoreData = [[tempDict objectForKey:@"isNoMore"] boolValue];
        AWStaticView *tempView = (AWStaticView *)[self.paperViewDict valueForKey:[NSString stringWithFormat:@"%ld",(long)self.selectedItemIndex]];
        ![[tempDict objectForKey:@"isNoMore"] boolValue] ? [tempView resetFooterStatus:MJRefreshStateIdle] : nil;
        [tempView resetStaticPaperSource:self.localSource];
        FLOG(@"切换到已缓存的 %@ vc = %@",self.titleArray[index],[pageViewController cellVCForRowAtIndex:index]);
    } else {
        // 滑动至新页面
        [self.localDataTool resetDefaultPage];
        [[self findPaperView:[pageViewController cellVCForRowAtIndex:index]] staticWallPaperRefresh];
        FLOG(@"切换到新创建的 %@ vc = %@",self.titleArray[index],[pageViewController cellVCForRowAtIndex:index]);
    }
}

#pragma mark - AWStaticPaperDelegate
- (void)pullRefreshPage {
    [self requestLocalData:AWLoadingType_Normal];
}

- (void)dragLoadMore {
    [self requestLocalData:AWLoadingType_More];
}

- (void)didSelectedWallPaper:(AWStaticCellModel *)paperModel {
    [self.pageControlView.parentViewController.navigationController pushViewController:[FLModuleMsgSend sendMsg:paperModel.imageUrl vcName:@"AWDynamicDetailViewController"] animated:YES];
}

#pragma mark - private methods
- (void)setDefaultData {
    self.titleArray = @[@"最热",@"最新",@"风景",@"建筑",@"人物",@"精选",@"动物",@"艺术",@"炫酷",];
    self.selectedItemIndex = 0;
    self.getDataInCache = NO;
}

- (XLPageViewControllerConfig *)pageControlConfig {
    XLPageViewControllerConfig *config = [XLPageViewControllerConfig defaultConfig];
    //标题按钮边缘距离
    config.btnDistanceToEdge = 10;
    //标题间距
    config.titleSpace = 20;
    //标题高度
    config.titleViewHeight = 45;
    //标题选中颜色
    config.titleSelectedColor = RGB(34, 34, 34);
    //标题选中字体
    config.titleSelectedFont = [UIFont boldSystemFontOfSize:17];
    //标题正常颜色
    config.titleNormalColor = RGBA(0, 0, 0, 0.8);
    //标题正常字体
    config.titleNormalFont = [UIFont systemFontOfSize:17];
    //阴影颜色
    config.shadowLineColor = RGB(45, 213, 118);
    //阴影宽度
    config.shadowLineWidth = 27;
    //阴影距离边缘位置
    config.shadowLineDistanceToEdge = 5;
    //分割线颜色
    config.separatorLineColor = RGB(238, 238, 238);
    //标题位置
    config.titleViewAlignment = XLPageTitleViewAlignmentCenter;
    
    return config;
}

- (AWStaticView *)createWallPaperView:(NSInteger)index {
    AWStaticView *paperView = [[AWStaticView alloc] init];
    paperView.staticPaperDelegate = self;
    [self.paperViewDict setValue:paperView forKey:[NSString stringWithFormat:@"%ld",(long)index]];
    return paperView;
}

- (AWStaticView *)findPaperView:(AWStaticPapgeSubViewController *)subVC {
    AWStaticView *tempView;
    for (UIView *view in subVC.view.subviews) {
        if ([view isKindOfClass:[AWStaticView class]]) {
            tempView = (AWStaticView *)view;
            break;
        }
    }
    return tempView;
}

- (void)requestLocalData:(AWLoadingType)loadType {
    WeakSelf;
    [self.localDataTool requestLocalPaperData:self.selectedItemIndex dataBlock:^(id  _Nonnull responseObject, BOOL isNoMoreData) {
        [weakSelf.localSource removeAllObjects];
        [weakSelf.localSource addObjectsFromArray:(NSArray <AWStaticCellModel *>*)responseObject];
        // 数据更新时，同时更新数据缓存中的数据和已加载的页数
        [weakSelf.totalSource setValue:[weakSelf.localSource copy] forKey:[NSString stringWithFormat:@"%ld",(long)weakSelf.selectedItemIndex]];
        NSDictionary *tempDict = @{@"page":[@(weakSelf.localDataTool.page) copy],@"isNoMore":@(isNoMoreData)};
        [weakSelf.recordLoadPage setValue:tempDict forKey:[NSString stringWithFormat:@"%ld",(long)weakSelf.selectedItemIndex]];
        AWStaticView *tempView = (AWStaticView *)[self.paperViewDict valueForKey:[NSString stringWithFormat:@"%ld",(long)self.selectedItemIndex]];
        [tempView loadStaticPaperSource:weakSelf.localSource];
        isNoMoreData ? [tempView resetFooterStatus:MJRefreshStateNoMoreData]: nil;
        isNoMoreData ? [MBHUDToastManager showBriefAlert:@"没有更多数据了"] : nil;
    } loadingDataType:loadType];
}

#pragma mark - lazy
- (XLPageViewController *)pageControlView {
    if (!_pageControlView) {
        _pageControlView = [[XLPageViewController alloc] initWithConfig:[self pageControlConfig]];
    }
    return _pageControlView;
}

- (AWStaticLocalDataTool *)localDataTool {
    if (!_localDataTool) {
        _localDataTool = [[AWStaticLocalDataTool alloc] init];
    }
    return _localDataTool;
}

- (NSMutableDictionary *)paperViewDict {
    if (!_paperViewDict) {
        _paperViewDict = [NSMutableDictionary dictionaryWithCapacity:self.titleArray.count];
    }
    return _paperViewDict;
}

- (NSMutableArray<AWStaticCellModel *> *)localSource {
    if (!_localSource) {
        _localSource = [NSMutableArray array];
    }
    return _localSource;
}

- (NSMutableDictionary *)totalSource {
    if (!_totalSource) {
        _totalSource = [NSMutableDictionary dictionaryWithCapacity:self.titleArray.count];
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
